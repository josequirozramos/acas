exports.setupAPIRoutes = (app, loginRoutes) ->
	app.get '/api/syncLiveDesignProjectsUsers', exports.syncLiveDesignProjectsUsers

exports.setupRoutes = (app, loginRoutes) ->
	app.get '/api/syncLiveDesignProjectsUsers', loginRoutes.ensureAuthenticated, exports.syncLiveDesignProjectsUsers

exports.syncLiveDesignProjectsUsers = (req, resp) ->
	req.setTimeout 600000
	exports.getGroupsJSON (groupsJSON, acasGroupsAndProjects) ->
		exports.getProjectsJSON (projectsJSON) ->
			exports.getConfigJSON (configJSON) ->
				caughtErrors = false
				pythonErrors = []
				exports.syncLiveDesignProjects caughtErrors, pythonErrors, configJSON, projectsJSON, (caughtErrors, pythonErrors) ->
					console.debug caughtErrors
					console.debug pythonErrors
					exports.syncLiveDesignRoles caughtErrors, pythonErrors, configJSON, groupsJSON, (caughtErrors, pythonErrors) ->
						if !caughtErrors
							resp.statusCode = 200
							console.log "Successfully synced projects and permissions with LiveDesign"
							resp.end "Successfully synced projects and permissions with LiveDesign"
						else
							resp.statusCode = 500
							console.log "An error has occurred trying to sync projects and permissions with LiveDesign. Please contact an administrator."
							resp.end "An error has occurred trying to sync projects and permissions with LiveDesign. Please contact an administrator."

exports.getGroupsJSON = (callback) ->
	request = require 'request'
	_ = require "underscore"
	config = require '../conf/compiled/conf.js'
	request.get
		url: config.all.client.service.persistence.fullpath+"authorization/groupsAndProjects"
		json: true
	, (error, response, body) =>
		serverError = error
		acasGroupsAndProjects = body
		#Re-map results from Roo authorization/groupsAndProjects route to new data structures - groupsJSON and projectsJSON
		groupsJSON = {}
		groupsJSON.groups = {}
		groupsJSON.projects = []
		_.each acasGroupsAndProjects.groups, (group) ->
			groupsJSON.groups[ group.name ] = group.members
		_.each acasGroupsAndProjects.projects, (project) ->
			projectGroups =
				alias: project.code
				active: if project.active? then project.active else true
				groups: project.groups
			groupsJSON.projects.push projectGroups
		callback groupsJSON, acasGroupsAndProjects


exports.getProjectsJSON = (callback) ->
	request = require 'request'
	_ = require "underscore"
	config = require '../conf/compiled/conf.js'
	request.get
		url: config.all.client.service.persistence.fullpath+"authorization/groupsAndProjects"
		json: true
	, (error, response, body) =>
		serverError = error
		acasGroupsAndProjects = body
		#Re-map results from Roo authorization/groupsAndProjects route to new data structures - groupsJSON and projectsJSON
		projectsJSON = {}
		projectsJSON.projects = []
		_.each acasGroupsAndProjects.projects, (project) ->
			projectEntry =
				id: project.id
				name: project.name
				code: project.code
				active: if project.active? then ['N','Y'][+project.active] else 'Y'
				is_restricted: if project.isRestricted? then +project.isRestricted else 0
				project_desc: project.name
			projectsJSON.projects.push projectEntry
		callback projectsJSON

exports.getConfigJSON = (callback) ->
	config = require '../conf/compiled/conf.js'
	#Build configJSON object of LiveDesign connection info to pass to python scripts
	configJSON =
		ld_server:
			ld_url: config.all.client.service.result.viewer.liveDesign.baseUrl
			ld_username: config.all.client.service.result.viewer.liveDesign.username
			ld_password: config.all.client.service.result.viewer.liveDesign.password
		livedesign_db:
			dbname: config.all.client.service.result.viewer.liveDesign.database.name
			user: config.all.client.service.result.viewer.liveDesign.database.username
			password: config.all.client.service.result.viewer.liveDesign.database.password
			host: config.all.client.service.result.viewer.liveDesign.database.hostname
			port: config.all.client.service.result.viewer.liveDesign.database.port
	callback configJSON

exports.syncLiveDesignProjects = (caughtErrors, pythonErrors, configJSON, projectsJSON, callback) ->
	if exports.validateLiveDesignConfigs(configJSON)
		exec = require('child_process').exec
		config = require '../conf/compiled/conf.js'
		#Call sync_projects.py to update list of projects in LiveDesign
		command = "python ./src/python/ServerAPI/syncProjectsUsers/sync_projects.py "
		command += "\'"+(JSON.stringify configJSON)+"\' "+"\'"+(JSON.stringify projectsJSON)+"\'"
		#		data = {"compounds":["V035000","CMPD-0000002"],"assays":[{"protocolName":"Target Y binding","resultType":"curve id"}]}
		#		command += (JSON.stringify data)+"'"
		console.log "About to call python using command: "+command
		child = exec command,  (error, stdout, stderr) ->
			reportURLPos = stdout.indexOf config.all.client.service.result.viewer.liveDesign.baseUrl
			reportURL = stdout.substr reportURLPos
			#console.warn "stderr: " + stderr
			console.log "stdout: " + stdout
			if error?
				caughtErrors = true
				console.error error
				pythonErrors.push error
			callback caughtErrors, pythonErrors
	else
		console.warn "some live design configs are null, skipping sync of live design projects"
		callback caughtErrors, pythonErrors

exports.validateLiveDesignConfigs = (configJSON) ->
	_ = require "underscore"
	countNull = _.map configJSON, (configs) ->
		nulls = _.pick configs, (config) ->
			_.isNull config
		return Object.keys(nulls).length
	countNull = _.reduce countNull, (sum, num) ->
		sum+num
	, 0
	return countNull == 0

exports.syncLiveDesignRoles = (caughtPythonErrors, pythonErrors, configJSON, groupsJSON, callback) ->
	if exports.validateLiveDesignConfigs(configJSON)
		exec = require('child_process').exec
		_ = require "underscore"
		config = require '../conf/compiled/conf.js'

		writeGroupsJSONToTempFile = (groupsJSON, callback) ->
			console.log "writeGroupsJSONToTempFile"
			groupsJSONFilePath = "/tmp/syncLiveDesignGroupsJSON.txt"
			fs = require 'fs'
			fs.writeFile(groupsJSONFilePath, JSON.stringify(groupsJSON), 'utf8', (error) ->
				if error
					callback "error", error
				else
					callback "successful", groupsJSONFilePath
			)

		writeGroupsJSONToTempFile groupsJSON, (status, writeGroupsJSONToTempFileResp) =>
			console.log "writeGroupsJSONToTempFileResp"
			console.log status
			console.log writeGroupsJSONToTempFileResp
			if status is "successful"
				#Filter out ignored projects
				filteredProjects = _.filter groupsJSON.projects, (project) ->
					project.active
				groupsJSON.projects = filteredProjects
				#Call ld_entitlements.py to update list of user-project ACLs in LiveDesign
				command = "python ./src/python/ServerAPI/syncProjectsUsers/ld_entitlements.py "
				command += "\'"+(JSON.stringify configJSON.ld_server)+"\' "+"\'"+writeGroupsJSONToTempFileResp+"\'"
				#		data = {"compounds":["V035000","CMPD-0000002"],"assays":[{"protocolName":"Target Y binding","resultType":"curve id"}]}
				#		command += (JSON.stringify data)+"'"
				console.log "About to call python using command: "+command
				child = exec command, {maxBuffer: 1024 * 1000}, (error, stdout, stderr) ->
					reportURLPos = stdout.indexOf config.all.client.service.result.viewer.liveDesign.baseUrl
					reportURL = stdout.substr reportURLPos
					#console.warn "stderr: " + stderr
					console.log "stdout: " + stdout
					if error?
						caughtPythonErrors = true
						console.error error
						pythonErrors.push error
					callback caughtPythonErrors, pythonErrors
			else
				console.error "Error writing groups JSON to temp file"
				caughtErrors = true
				pythonErrors.push writeGroupsJSONToTempFileResp #pushing error even though technically it's not a python error
				callback caughtErrors, pythonErrors
	else
		console.warn "some live design configs are null, skipping sync of live design roles"
		callback caughtPythonErrors, pythonErrors

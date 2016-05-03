exports.setupAPIRoutes = (app) ->
	app.post '/api/cmpdReg', exports.postAssignedProperties

exports.setupRoutes = (app, loginRoutes) ->
	app.get '/cmpdReg', loginRoutes.ensureAuthenticated, exports.cmpdRegIndex
	app.get '/marvin4js-license.cxl', loginRoutes.ensureAuthenticated, exports.getMarvinJSLicense
	app.get '/cmpdReg/scientists', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/parentAliasKinds', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/units', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/solutionUnits', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/salts', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/isotopes', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/stereoCategorys', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/fileTypes', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/projects', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/vendors', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/physicalStates', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/operators', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/purityMeasuredBys', loginRoutes.ensureAuthenticated, exports.getBasicCmpdReg
	app.get '/cmpdReg/structureimage/parent/[\\S]*', loginRoutes.ensureAuthenticated, exports.getStructureImage
	app.get '/cmpdReg/metalots/corpName/[\\S]*', loginRoutes.ensureAuthenticated, exports.getMetaLot
	app.get '/MultipleFilePicker/[\\S]*', loginRoutes.ensureAuthenticated, exports.getMultipleFilePicker
	app.post '/cmpdReg/search/cmpds', loginRoutes.ensureAuthenticated, exports.searchCmpds
	app.post '/cmpdReg/regsearches/parent', loginRoutes.ensureAuthenticated, exports.regSearch
	app.post '/cmpdReg/filesave', loginRoutes.ensureAuthenticated, exports.fileSave
	app.post '/cmpdReg/metalots', loginRoutes.ensureAuthenticated, exports.metaLots


exports.cmpdRegIndex = (req, res) ->
	scriptPaths = require './RequiredClientScripts.js'
	config = require '../conf/compiled/conf.js'
	cmpdRegConfig = require '../public/src/modules/CmpdReg/src/client/custom/configuration.json'
	_ = require 'underscore'
	grantedRoles = _.map req.user.roles, (role) ->
		role.roleEntry.roleName
	console.log grantedRoles
	isChemist = (config.all.client.roles.cmpdreg?.chemistRole? && config.all.client.roles.cmpdreg.chemistRole in grantedRoles)
	isAdmin = (config.all.client.roles.cmpdreg?.adminRole? && config.all.client.roles.cmpdreg.adminRole in grantedRoles)
	global.specRunnerTestmode = if global.stubsMode then true else false
	scriptsToLoad = scriptPaths.requiredScripts.concat(scriptPaths.applicationScripts)
	if config.all.client.require.login
		loginUserName = req.user.username
		loginUser = req.user
		cmpdRegUser =
			id: req.user.id
			code: req.user.username
			name: req.user.firstName + " " + req.user.lastName
			isChemist: isChemist
			isAdmin: isAdmin
		syncCmpdRegUser cmpdRegUser
	else
		loginUserName = "nouser"
		loginUser =
			id: 0,
			username: "nouser",
			email: "nouser@nowhere.com",
			firstName: "no",
			lastName: "user"
		cmpdRegUser =
			id: 0
			code: "nouser"
			name: "no user"
			isChemist: true
			isAdmin : true

	return res.render 'CmpdReg',
		title: "Compound Registration"
		scripts: scriptsToLoad
		AppLaunchParams:
			loginUserName: loginUserName
			loginUser: loginUser
			cmpdRegUser: cmpdRegUser
			testMode: false
			moduleLaunchParams: if moduleLaunchParams? then moduleLaunchParams else null
			deployMode: global.deployMode
			cmpdRegConfig: cmpdRegConfig

syncCmpdRegUser = (cmpdRegUser) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	getUsersUrl = config.all.client.service.cmpdReg.persistence.basepath + '/scientists'
	getScientists = (getUsersUrl, resp) ->
		request(
			method: 'GET'
			url: getUsersUrl
			timeout: 6000000
		, (error, response, json) =>
			if !error
				console.log JSON.stringify json
				resp.setHeader('Content-Type', 'application/json')
				resp.end JSON.stringify json
			else
				console.log 'got ajax error trying to search for compounds'
				console.log error
				console.log json
				console.log response
				resp.end JSON.stringify {error: "something went wrong :("}
		)
	scientists = (getScientists getUsersUrl).json
	console.log 'scientists:'
	console.log scientists

exports.getBasicCmpdReg = (req, resp) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	console.log 'in getBasicCmpdReg'
	console.log req.originalUrl
	endOfUrl = (req.originalUrl).replace /\/cmpdreg\//, ""
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + "/" +endOfUrl
	console.log cmpdRegCall
	req.pipe(request(cmpdRegCall)).pipe(resp)

exports.getProjects = (req, callback) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	console.log 'in getProjects'
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + "/projects"
	request(
		method: 'GET'
		url: cmpdRegCall
		json: true
	, (error, response, json)=>
		if !error
			console.log JSON.stringify json
			callback JSON.stringify json
		else
			console.log 'got ajax error trying to search for compounds'
			console.log error
			console.log json
			console.log response
			callback JSON.stringify {error: "something went wrong :("}
	)

exports.saveProjects = (jsonBody, callback) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	console.log 'in saveProjects'
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + "/projects/jsonArray"
	request(
		method: 'POST'
		url: cmpdRegCall
		body: JSON.stringify jsonBody
		json: true
	, (error, response, json)=>
		if !error
			console.log JSON.stringify json
			callback JSON.stringify json
		else
			console.log 'got ajax error trying to search for compounds'
			console.log error
			console.log json
			console.log response
			callback JSON.stringify {error: "something went wrong :("}
	)

exports.searchCmpds = (req, resp) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + '/search/cmpds'
	request(
		method: 'POST'
		url: cmpdRegCall
		body: JSON.stringify req.body
		json: true
		timeout: 6000000
	, (error, response, json) =>
		if !error
			console.log JSON.stringify json
			resp.setHeader('Content-Type', 'application/json')
			resp.end JSON.stringify json
		else
			console.log 'got ajax error trying to search for compounds'
			console.log error
			console.log json
			console.log response
			resp.end JSON.stringify {error: "something went wrong :("}
	)

exports.getStructureImage = (req, resp) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	imagePath = (req.originalUrl).replace /\/cmpdreg\/structureimage/, ""
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + '/structureimage' + imagePath
	req.pipe(request(cmpdRegCall)).pipe(resp)

exports.getMetaLot = (req, resp) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	endOfUrl = (req.originalUrl).replace /\/cmpdreg\/metalots/, ""
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + '/metalots' + endOfUrl
	console.log cmpdRegCall
	req.pipe(request(cmpdRegCall)).pipe(resp)

exports.regSearch = (req, resp) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + '/regsearches/parent'
	console.log cmpdRegCall
	request(
		method: 'POST'
		url: cmpdRegCall
		body: JSON.stringify req.body
		json: true
		timeout: 6000000
	, (error, response, json) =>
		if !error
			console.log JSON.stringify json
			resp.setHeader('Content-Type', 'application/json')
			resp.end JSON.stringify json
		else
			console.log 'got ajax error trying to do registration search'
			console.log error
			console.log json
			console.log response
			resp.end JSON.stringify {error: "something went wrong :("}
	)

exports.getMarvinJSLicense = (req, resp) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	cmpdRegCall = (config.all.client.service.cmpdReg.persistence.basepath).replace '\/cmpdreg', "/"
	licensePath = cmpdRegCall + 'marvin4js-license.cxl'
	console.log licensePath
	req.pipe(request(licensePath)).pipe(resp)

exports.getMultipleFilePicker = (req, resp) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + req.originalUrl
	console.log cmpdRegCall
	req.pipe(request(cmpdRegCall)).pipe(resp)

exports.fileSave = (req, resp) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + '/filesave'
	req.pipe(request[req.method.toLowerCase()](cmpdRegCall)).pipe(resp)

exports.metaLots = (req, resp) ->
	request = require 'request'
	config = require '../conf/compiled/conf.js'
	cmpdRegCall = config.all.client.service.cmpdReg.persistence.basepath + '/metalots'
	request(
		method: 'POST'
		url: cmpdRegCall
		body: JSON.stringify req.body
		json: true
		timeout: 6000000
	, (error, response, json) =>
		if !error
			console.log JSON.stringify json
			resp.setHeader('Content-Type', 'application/json')
			resp.end JSON.stringify json
		else
			console.log 'got ajax error trying to do metalot save'
			console.log error
			console.log json
			console.log response
			resp.end JSON.stringify {error: "something went wrong :("}
	)


exports.setupRoutes = (app, loginRoutes) ->
	app.post '/api/geneDataQuery', exports.getExperimentDataForGenes
	config = require '../conf/compiled/conf.js'
	if config.all.client.require.login
		app.get '/geneIDQuery', loginRoutes.ensureAuthenticated, exports.geneIDQueryIndex
	else
		app.get '/geneIDQuery', exports.geneIDQueryIndex

exports.getExperimentDataForGenes = (request, response)  ->
	request.connection.setTimeout 600000
	serverUtilityFunctions = require './ServerUtilityFunctions.js'

	response.writeHead(200, {'Content-Type': 'application/json'});
	if global.specRunnerTestmode
		console.log "test mode: "+global.specRunnerTestmode
		geneDataQueriesTestJSON = require '../public/javascripts/spec/testFixtures/GeneDataQueriesTestJson.js'
		requestError = if request.body.maxRowsToReturn < 0 then true else false
		if request.body.geneIDs[0].gid == "fiona"
			results = geneDataQueriesTestJSON.geneIDQueryResultsNoneFound
		else
			results = geneDataQueriesTestJSON.geneIDQueryResults
		responseObj =
			results: results
			hasError: requestError
			hasWarning: true
			errorMessages: [
				{errorLevel: "warning", message: "some genes not found"},
			]
		if requestError then responseObj.errorMessages.push {errorLevel: "error", message: "start offset outside allowed range, please speake to an administrator"}
		response.end JSON.stringify responseObj
	else
		#TODO replace with call to RApache
		console.log "test mode: "+global.specRunnerTestmode
		geneDataQueriesTestJSON = require '../public/javascripts/spec/testFixtures/GeneDataQueriesTestJson.js'
		requestError = if request.body.maxRowsToReturn < 0 then true else false
		if request.body.geneIDs[0].gid == "fiona"
			results = geneDataQueriesTestJSON.geneIDQueryResultsNoneFound
		else
			results = geneDataQueriesTestJSON.geneIDQueryResults
		responseObj =
			results: results
			hasError: requestError
			hasWarning: true
			errorMessages: [
				{errorLevel: "warning", message: "some genes not found"},
			]
		if requestError then responseObj.errorMessages.push {errorLevel: "error", message: "start offset outside allowed range, please speake to an administrator"}
		response.end JSON.stringify responseObj



exports.geneIDQueryIndex = (req, res) ->
	#"use strict"
	scriptPaths = require './RequiredClientScripts.js'
	config = require '../conf/compiled/conf.js'
	global.specRunnerTestmode = false
	scriptsToLoad = scriptPaths.requiredScripts.concat(scriptPaths.applicationScripts)
	if config.all.client.require.login
		loginUserName = req.user.username
		loginUser = req.user
	else
		loginUserName = "nouser"
		loginUser =
			id: 0,
			username: "nouser",
			email: "nouser@nowhere.com",
			firstName: "no",
			lastName: "user"

	return res.render 'GeneIDQuery',
		title: "Gene ID Queery"
		scripts: scriptsToLoad
		AppLaunchParams:
			loginUserName: loginUserName
			loginUser: loginUser
			testMode: false
			moduleLaunchParams: if moduleLaunchParams? then moduleLaunchParams else null
			deployMode: global.deployMode

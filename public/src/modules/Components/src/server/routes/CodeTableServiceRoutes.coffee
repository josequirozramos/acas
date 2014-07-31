exports.setupAPIRoutes = (app) ->
	app.get '/api/dataDict/:kind', exports.getDataDictValues

exports.setupRoutes = (app, loginRoutes) ->
	app.get '/api/dataDict/:kind', loginRoutes.ensureAuthenticated, exports.getDataDictValues

exports.getDataDictValues = (req, resp) ->
	if global.specRunnerTestmode
		codeTableServiceTestJSON = require '../public/javascripts/spec/testFixtures/CodeTableJSON.js'
		for i in codeTableServiceTestJSON.codes
			if i[req.params.kind]
				console.log "success"
				resp.end JSON.stringify i[req.params.kind]
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"api/v1/ddictvalues/bytype/"+req.params.kind+"/codetable"
		request = require 'request'
		request(
			method: 'GET'
			url: baseurl
			json: true
		, (error, response, json) =>
			if !error && response.statusCode == 200
				resp.json json
			else
				console.log 'got ajax error trying to get protocol labels'
				console.log error
				console.log json
				console.log response
		)

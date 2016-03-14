exports.setupAPIRoutes = (app) ->
	app.post '/api/getContainersInLocation', exports.getContainersInLocation
	app.post '/api/getContainerCodesByLabels', exports.getContainerCodesByLabels
	app.post '/api/getContainersByLabels', exports.getContainersByLabels
	app.post '/api/getContainersByCodeNames', exports.getContainersByCodeNames
	app.post '/api/getWellCodesByPlateBarcodes', exports.getWellCodesByPlateBarcodes
	app.post '/api/getWellContent', exports.getWellContent
	app.get '/api/plateMetadataAndDefinitionMetadataByPlateBarcode/:plateBarcode', exports.getPlateMetadataAndDefinitionMetadataByPlateBarcode
	app.put '/api/plateMetadataAndDefinitionMetadataByPlateBarcode/:plateBarcode', exports.updatePlateMetadataAndDefinitionMetadataByPlateBarcode
	app.put '/api/containers/jsonArray', exports.updateContainers
	app.post '/api/getBreadCrumbByContainerCode', exports.getBreadCrumbByContainerCode
	app.post '/api/getWellCodesByContainerCodes', exports.getWellCodesByContainerCodes
	app.get '/api/containers', exports.getAllContainers
	app.get '/api/containers/:lsType/:lsKind', exports.containersByTypeKind
	app.get '/api/containers/:code', exports.containerByCodeName
	app.post '/api/containers', exports.postContainer
	app.put '/api/containers/:code', exports.putContainer
	app.post '/api/validateContainerName', exports.validateContainerName
	app.post '/api/getContainerCodesFromLabels', exports.getContainerCodesFromLabels
	app.post '/api/getContainerFromLabel', exports.getContainerFromLabel

exports.setupRoutes = (app, loginRoutes) ->
	app.post '/api/getContainersInLocation', loginRoutes.ensureAuthenticated, exports.getContainersInLocation
	app.post '/api/getContainerCodesByLabels', loginRoutes.ensureAuthenticated, exports.getContainerCodesByLabels
	app.post '/api/getContainersByLabels', loginRoutes.ensureAuthenticated, exports.getContainersByLabels
	app.post '/api/getContainersByCodeNames', loginRoutes.ensureAuthenticated, exports.getContainersByCodeNames
	app.post '/api/getWellCodesByPlateBarcodes', loginRoutes.ensureAuthenticated, exports.getWellCodesByPlateBarcodes
	app.post '/api/getWellContent', loginRoutes.ensureAuthenticated, exports.getWellContent
	app.get '/api/plateMetadataAndDefinitionMetadataByPlateBarcode/:plateBarcode', loginRoutes.ensureAuthenticated, exports.getPlateMetadataAndDefinitionMetadataByPlateBarcode
	app.put '/api/plateMetadataAndDefinitionMetadataByPlateBarcode/:plateBarcode', loginRoutes.ensureAuthenticated, exports.updatePlateMetadataAndDefinitionMetadataByPlateBarcode
	app.post '/api/getWellCodesByContainerCodes', loginRoutes.ensureAuthenticated, exports.getWellCodesByContainerCodes
	app.get '/api/containers', loginRoutes.ensureAuthenticated, exports.getAllContainers
	app.get '/api/containers/:lsType/:lsKind', loginRoutes.ensureAuthenticated, exports.containersByTypeKind
	app.get '/api/containers/:code', loginRoutes.ensureAuthenticated, exports.containerByCodeName
	app.post '/api/containers', loginRoutes.ensureAuthenticated, exports.postContainer
	app.put '/api/containers/:code', loginRoutes.ensureAuthenticated, exports.putContainer
	app.post '/api/validateContainerName', loginRoutes.ensureAuthenticated, exports.validateContainerName
	app.post '/api/getContainerCodesFromLabels', loginRoutes.ensureAuthenticated, exports.getContainerCodesFromLabels
	app.post '/api/getContainerFromLabel', loginRoutes.ensureAuthenticated, exports.getContainerFromLabel

exports.getContainersInLocation = (req, resp) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getContainersInLocationResponse
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/getContainersInLocation"
		request = require 'request'
		request(
			method: 'POST'
			url: baseurl
			body: req.body
			json: true
		, (error, response, json) =>
			if !error && response.statusCode == 200
				resp.json json
			else
				console.error 'got ajax error trying to get getContainersInLocation'
				console.error error
				console.error json
				console.error response
				resp.end JSON.stringify "getContainersInLocation failed"
  		)

exports.getContainersByLabels = (req, resp) ->
	exports.getContainersByLabelsInternal req.body, req.query.containerType, req.query.containerKind, req.query.labelType, req.query.labelKind, (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json

exports.getContainersByLabelsInternal = (containerLabels, containerType, containerKind, labelType, labelKind, callback) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getContainersByLabelsInternalResponse
	else
		exports.getContainerCodesByLabelsInternal containerLabels, containerType, containerKind, labelType, labelKind, (containerCodes) =>
			if containerCodes.indexOf('failed') > -1
				callback JSON.stringify "getContainersByLabels failed"
			else
				_ = require 'underscore'
				codeNames = _.map containerCodes, (code) ->
					if code.foundCodeNames[0]?
						code.foundCodeNames[0]
					else
						""
				codeNamesJSON = JSON.stringify codeNames
				exports.getContainersByCodeNamesInternal codeNamesJSON, (containers) =>
					if containers.indexOf('failed') > -1
						callback JSON.stringify "getContainersByLabels failed"
					else
						response = []
						for label, index in containerLabels
							resp =
								label: label
								codeName: null
								container: null
							codeName =  _.findWhere containerCodes, {requestLabel: label}
							if codeName?.foundCodeNames[0]?
								resp.codeName = codeName.foundCodeNames[0]
								container =  _.findWhere containers, {containerCodeName: codeName.foundCodeNames[0]}
								if container?.container?
									resp.container = container.container
							response.push resp
						callback response

exports.getContainerCodesByLabels = (req, resp) ->
	exports.getContainerCodesByLabelsInternal req.body, req.query.containerType, req.query.containerKind, req.query.labelType, req.query.labelKind, (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json

exports.getContainerCodesByLabelsInternal = (containerCodesJSON, containerType, containerKind, labelType, labelKind, callback) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getContainerCodesByLabelsResponse
	else
		config = require '../conf/compiled/conf.js'
		queryParams = []
		if containerType?
			queryParams.push "containerType="+containerType
		if containerKind?
			queryParams.push "containerKind="+containerKind
		if labelType?
			queryParams.push "labelType="+labelType
		if labelKind?
			queryParams.push "labelKind="+labelKind
		queryString = queryParams.join "&"
		baseurl = config.all.client.service.persistence.fullpath+"containers/getContainerCodesByLabels?"+queryString
		request = require 'request'
		request(
			method: 'POST'
			url: baseurl
			body: JSON.stringify containerCodesJSON
			json: true
			headers: 'content-type': 'application/json'
		, (error, response, json) =>
			if !error && response.statusCode == 200
				callback json
			else
				console.error 'got ajax error trying to get getContainerCodesByLabels'
				console.error error
				console.error json
				console.error response
				callback JSON.stringify "getContainerCodesByLabels failed"
		)

exports.getWellCodesByPlateBarcodes = (req, resp) ->
	exports.getWellCodesByPlateBarcodesInternal req.body, (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json


exports.getWellCodesByPlateBarcodes = (req, resp) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getWellCodesByPlateBarcodesResponse
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/getWellCodesByPlateBarcodes"
		request = require 'request'
		request(
			method: 'POST'
			url: baseurl
			body: req.body
			json: true
		, (error, response, json) =>
			if !error && response.statusCode == 200
				resp.json json
			else
				console.error 'got ajax error trying to get getWellCodesByPlateBarcodes'
				console.error error
				console.error json
				console.error response
				resp.end JSON.stringify "getWellCodesByPlateBarcodes failed"
  		)

exports.getWellContent = (req, resp) ->
	exports.getWellContentInternal req.body, (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json

exports.getWellContentInternal = (wellCodeNames, callback) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		callback inventoryServiceTestJSON.getWellContentResponse
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/getWellContent"
		request = require 'request'
		console.debug 'calling service', baseurl
		request(
			method: 'POST'
			url: baseurl
			body: JSON.stringify wellCodeNames
			json: true
			headers: 'content-type': 'application/json'
		, (error, response, json) =>
			if !error && response.statusCode == 200
				console.debug 'returned success from service', baseurl
				callback json
			else
				console.error 'got ajax error trying to get getWellContent'
				console.error error
				console.error json
				console.error response
				callback JSON.stringify "getWellContent failed"
  		)

exports.getPlateMetadataAndDefinitionMetadataByPlateBarcode = (req, resp) ->
	exports.getPlateMetadataAndDefinitionMetadataByPlateBarcodesInternal [req.params.plateBarcode], (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json[0]

exports.getPlateMetadataAndDefinitionMetadataByPlateBarcodesInternal = (plateBarcodes, callback) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getPlateMetadataAndDefinitionMetadataByPlateBarcodeResponse
	else
		exports.getContainersByLabelsInternal plateBarcodes, "container", "plate", "barcode", "barcode", (containers) =>
			if containers.indexOf('failed') > -1
				callback JSON.stringify "getPlateMetadataAndDefinitionMetadataByPlateBarcodes failed"
			else
				_ = require 'underscore'
				codeNames = _.pluck containers, "codeName"
				codeNamesJSON = JSON.stringify codeNames
				serverUtilityFunctions = require './ServerUtilityFunctions.js'
				exports.getDefinitionContainersByContainerCodeNamesInternal codeNamesJSON, (definitions) =>
					if definitions.indexOf('failed') > -1
						callback JSON.stringify "getPlateMetadataAndDefinitionMetadataByPlateBarcodes failed"
					else
						responseArray = []
						for barcode, index in plateBarcodes
							response =
								barcode: barcode
								codeName: null
								description: null
								plateSize: null
								numberOfRows: null
								numberOfColumns: null
								type: null
								status: null
								createdDate: null
								supplier: null
							containerCode =  _.findWhere containers, {label: barcode}
							if containerCode?
								response.codeName = containerCode.codeName
								container =  _.findWhere containers, {containerCodeName: containerCode.codeName}
								if container?
									state = serverUtilityFunctions.getStatesByTypeAndKind container.container, 'metadata', 'information'
									if state.length > 0
										description = serverUtilityFunctions.getValuesByTypeAndKind(state[0], 'stringValue', 'description')
										if description.length > 0
											response.description = description[0].stringValue
										type = serverUtilityFunctions.getValuesByTypeAndKind(state[0], 'codeValue', 'plate type')
										if type.length > 0
											response.type = type[0].codeValue
										status = serverUtilityFunctions.getValuesByTypeAndKind(state[0], 'codeValue', 'status')
										if status.length > 0
											response.status = status[0].codeValue
										createdDate = serverUtilityFunctions.getValuesByTypeAndKind(state[0], 'dateValue', 'created date')
										if createdDate.length > 0
											response.createdDate = createdDate[0].dateValue
										supplier = serverUtilityFunctions.getValuesByTypeAndKind(state[0], 'codeValue', 'supplier code')
										if supplier.length > 0
											response.supplier = supplier[0].codeValue

								definition =  _.findWhere definitions, {containerCodeName: containerCode.codeName}
								if definition?
										state = serverUtilityFunctions.getStatesByTypeAndKind definition.definition, 'constants', 'format'
										if state.length > 0
											plateSize = serverUtilityFunctions.getValuesByTypeAndKind(state[0], 'numericValue', 'wells')
											if plateSize.length > 0
												response.plateSize = plateSize[0].numericValue
											numberOfRows = serverUtilityFunctions.getValuesByTypeAndKind(state[0], 'numericValue', 'rows')
											if numberOfRows.length > 0
												response.numberOfRows = numberOfRows[0].numericValue
											numberOfColumns = serverUtilityFunctions.getValuesByTypeAndKind(state[0], 'numericValue', 'columns')
											if numberOfColumns.length > 0
												response.numberOfColumns = numberOfColumns[0].numericValue
						responseArray.push response
						callback responseArray

exports.updatePlateMetadataAndDefinitionMetadataByPlateBarcode = (req, resp) ->
	exports.updatePlateMetadataAndDefinitionMetadataByPlateBarcodesInternal [req.body], (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json

exports.updatePlateMetadataAndDefinitionMetadataByPlateBarcodesInternal = (containerMetadataAndDefinitionMetadata, callback) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.updatePlateMetadataAndDefinitionMetadataByPlateBarcodeResponse
	else
		_ = require 'underscore'
		codeNames = _.pluck containerMetadataAndDefinitionMetadata, "codeName"
		exports.getContainersByCodeNamesInternal codeNames, (containers) =>
			if containers.indexOf('failed') > -1
				callback JSON.stringify "updateContainerMetadataAndDefinitionMetadataByPlateBarcodesInternal failed"
			else
				serverUtilityFunctions = require './ServerUtilityFunctions.js'
				containerArray = []
				recordedDate = new Date().getTime()
				for containerMeta, index in containerMetadataAndDefinitionMetadata
					container = new serverUtilityFunctions.Thing(containers[index].container)
					metaDataState = container.get('lsStates').getStatesByTypeAndKind('metadata', 'information')[0]
					metaDataValues = metaDataState.get('lsValues')
					if containerMeta.barcode?
						barcode = container.get('lsLabels').getLabelByTypeAndKind('barcode', 'barcode')[0]
						barcode.set 'ignored', containerMeta.barcode
					if containerMeta.description?
						description = container.get('lsStates').getOrCreateValueByTypeAndKind 'metadata', 'information', 'stringValue', 'description'
						description.set 'stringValue', containerMeta.description
						description.set 'recordedBy', containerMeta.recordedBy
						description.set 'recordedDate', recordedDate
					else
						description = metaDataState.getValuesByTypeAndKind('stringValue', 'description')[0]
						if description?
							description.set 'ignored', true
					if containerMeta.type?
						type = container.get('lsStates').getOrCreateValueByTypeAndKind 'metadata', 'information', 'codeValue', 'plate type'
						type.set 'codeValue', containerMeta.type
						type.set 'recordedBy', containerMeta.recordedBy
						type.set 'recordedDate', recordedDate
					else
						type = metaDataState.getValuesByTypeAndKind('codeValue', 'plate type')[0]
						if type?
							type.set 'ignored', true
					if containerMeta.status?
						status = container.get('lsStates').getOrCreateValueByTypeAndKind 'metadata', 'information', 'codeValue', 'status'
						status.set 'codeValue', containerMeta.status
						status.set 'recordedBy', containerMeta.recordedBy
						status.set 'recordedDate', recordedDate
					else
						status = metaDataState.getValuesByTypeAndKind('codeValue', 'status')[0]
						if status?
							status.set 'ignored', true
					if containerMeta.createdDate?
						console.log 'yes'
						createdDate = container.get('lsStates').getOrCreateValueByTypeAndKind 'metadata', 'information', 'dateValue', 'created date'
						createdDate.set 'dateValue', containerMeta.createdDate
						createdDate.set 'recordedBy', containerMeta.recordedBy
						createdDate.set 'recordedDate', recordedDate
					else
						createdDate = metaDataState.getValuesByTypeAndKind('dateValue', 'created date')[0]
						if createdDate?
							createdDate.set 'ignored', true
					if containerMeta.supplier?
						supplier = container.get('lsStates').getOrCreateValueByTypeAndKind 'metadata', 'information', 'codeValue', 'supplier code'
						supplier.set 'codeValue', containerMeta.supplier
						supplier.set 'recordedBy', containerMeta.recordedBy
						supplier.set 'recordedDate', recordedDate
					else
						supplier = metaDataState.getValuesByTypeAndKind('codeValue', 'supplier code')[0]
						if supplier?
							supplier.set 'ignored', true
					container.reformatBeforeSaving()
					containerArray.push container.attributes
					containerJSONArray = JSON.stringify(containerArray)
					exports.updateContainersInternal containerJSONArray, (savedContainers) =>
						for containerMeta, index in containerMetadataAndDefinitionMetadata
							savedContainer = new serverUtilityFunctions.Thing(savedContainers[index])
							containerMetadataAndDefinitionMetadata[index].description = savedContainer.get('lsStates').getStateValueByTypeAndKind('metadata', 'information', 'stringValue', 'description')?.get('stringValue') || null
							containerMetadataAndDefinitionMetadata[index].type = savedContainer.get('lsStates').getStateValueByTypeAndKind('metadata', 'information', 'codeValue', 'plate type')?.get('codeValue')|| null
							containerMetadataAndDefinitionMetadata[index].status = savedContainer.get('lsStates').getStateValueByTypeAndKind('metadata', 'information', 'codeValue', 'status')?.get('codeValue')|| null
							containerMetadataAndDefinitionMetadata[index].supplier = savedContainer.get('lsStates').getStateValueByTypeAndKind('metadata', 'information', 'codeValue', 'supplier code')?.get('codeValue') || null
						callback containerMetadataAndDefinitionMetadata

exports.getContainersByCodeNames = (req, resp) ->
	exports.getContainersByCodeNamesInternal req.body, (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json

exports.getContainersByCodeNamesInternal = (codeNamesJSON, callback) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getContainersByCodeNames
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/getContainersByCodeNames"
		request = require 'request'
		request(
			method: 'POST'
			url: baseurl
			body: codeNamesJSON
			json: true
			headers: 'content-type': 'application/json'
		, (error, response, json) =>
			if !error && response.statusCode in [200,400]
				callback json
			else
				console.error 'got ajax error trying to get getContainersByCodeNames'
				console.error error
				console.error json
				console.error response
				callback JSON.stringify "getContainersByCodeNames failed"
		)

exports.getDefinitionContainersByContainerCodeNamesInternal = (codeNamesJSON, callback) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getDefinitionContainersByContainerCodeNames
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/getDefinitionContainersByContainerCodeNames"
		request = require 'request'
		request(
			method: 'POST'
			url: baseurl
			body: codeNamesJSON
			json: true
			headers: 'content-type': 'application/json'
		, (error, response, json) =>
			if !error && response.statusCode == 200
				callback json
			else
				console.error 'got ajax error trying to get getDefinitionContainersByContainerCodeNames'
				console.error error
				console.error json
				console.error response
				callback JSON.stringify "getDefinitionContainersByContainerCodeNames failed"
		)

exports.getBreadCrumbByContainerCode = (req, resp) ->
	exports.getBreadCrumbByContainerCodeInternal req.body, req.query.delimeter, (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json

exports.getBreadCrumbByContainerCodeInternal = (codeNamesJSON, delimeter, callback) ->
	if !delimeter?
		delimeter = ">"
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getBreadCrumbByContainerCodeResponse
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.rapache.fullpath+"/getBreadCrumbByContainerCode?delimeter="+encodeURIComponent(delimeter)
		request = require 'request'
		request(
			method: 'POST'
			url: baseurl
			body: codeNamesJSON
			json: true
			headers: 'content-type': 'application/json'
		, (error, response, json) =>
			if !error && response.statusCode == 200
				callback json
			else
				console.error 'got ajax error trying to get getBreadCrumbByContainerCode'
				console.error error
				console.error json
				console.error response
				callback JSON.stringify "getBreadCrumbByContainerCode failed"
		)

exports.getWellCodesByContainerCodes = (req, resp) ->
	exports.getWellCodesByContainerCodesInternal req.body, (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json

exports.getWellCodesByContainerCodesInternal = (codeNamesJSON, callback) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getWellCodesByContainerCodesResponse
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/getWellCodesByContainerCodes"
		request = require 'request'
		request(
			method: 'POST'
			url: baseurl
			body: codeNamesJSON
			json: true
			headers: 'content-type': 'application/json'
		, (error, response, json) =>
			if !error && response.statusCode == 200
				callback json
			else
				console.error 'got ajax error trying to get getWellCodesByContainerCodes'
				console.error error
				console.error json
				console.error response
				callback JSON.stringify "getWellCodesByContainerCodes failed"
		)

exports.getWellContentByContainerCodesInternal = (containerCodeNames, callback) ->
	_ = require 'underscore'
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.getWellContentByContainerCodesResponse
	else
		console.debug 'requesting well codes from container codes'
		exports.getWellCodesByContainerCodesInternal containerCodeNames, (wellCodesResponse) ->
			wellCodes = _.map wellCodesResponse, (wellCode) ->
				_.map wellCode.wellCodeNames, (codeName) ->
					{containerCode: wellCode.requestCodeName, wellCode: codeName}
			wellCodes = _.flatten wellCodes
			wellContentRequest = _.pluck wellCodes, 'wellCode'
			console.debug 'requesting well content from well container codes'
			exports.getWellContentInternal wellContentRequest, (wellContentResponse) ->
				response = []
				for containerCodeName in containerCodeNames
					containerWellCodes = _.pluck(_.where(wellCodes, {containerCode: containerCodeName}), "wellCode")
					containerWellContent = _.filter wellContentResponse, (wellContent) ->
						return wellContent.containerCodeName in containerWellCodes
					containerWellContent = _.sortBy containerWellContent, 'wellName'
					response.push {containerCodeName: containerCodeName, wellContent: containerWellContent}
				callback response

exports.updateContainers = (req, resp) ->
	exports.updateContainersInternal req.body, (json) ->
		if json.indexOf('failed') > -1
			resp.statusCode = 500
		else
			resp.json json

exports.updateContainersInternal = (containers, callback) ->
	if global.specRunnerTestmode
		inventoryServiceTestJSON = require '../public/javascripts/spec/ServerAPI/testFixtures/InventoryServiceTestJSON.js'
		resp.json inventoryServiceTestJSON.updateContainersResponse
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/jsonArray"
		request = require 'request'
		console.log 'sending this', containers
		request(
			method: 'PUT'
			url: baseurl
			body: containers
			json: true
			headers: 'content-type': 'application/json'
		, (error, response, json) =>
			if !error && response.statusCode == 200
				callback json
			else
				console.error 'got ajax error trying to get updateContainers'
				console.error error
				console.error json
				console.error response
				callback JSON.stringify "updateContainers failed"
		)


serverUtilityFunctions = require './ServerUtilityFunctions.js'
csUtilities = require '../src/javascripts/ServerAPI/CustomerSpecificServerFunctions.js'


exports.getAllContainers = (req, resp) ->
	if req.query.testMode or global.specRunnerTestmode
		containerTestJSON = require '../public/javascripts/spec/testFixtures/ContainerServiceTestJSON.js'
		resp.json containerTestJSON.container
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers"
		serverUtilityFunctions.getFromACASServer(baseurl, resp)

exports.containersByTypeKind = (req, resp) ->
	config = require '../conf/compiled/conf.js'
	if req.query.format? and req.query.format=="codetable" #ie has '?format=codetable' appended to end of api route
		if req.query.testMode or global.specRunnerTestmode
			resp.end JSON.stringify "stubsMode for getting containers in codetable format not implemented yet"
		else
			baseurl = config.all.client.service.persistence.fullpath+"containers/codetable?lsType=#{req.params.lsType}&lsKind=#{req.params.lsKind}"
			stubFlag = "with=stub"
			if req.query.stub
				baseurl += "?#{stubFlag}"
			serverUtilityFunctions.getFromACASServer(baseurl, resp)

	else
		if req.query.testMode or global.specRunnerTestmode
			thingServiceTestJSON = require '../public/javascripts/spec/testFixtures/ThingServiceTestJSON.js'
			resp.end JSON.stringify thingServiceTestJSON.batchList
		else
			baseurl = config.all.client.service.persistence.fullpath+"containers?lsType="+req.params.lsType+"&lsKind="+req.params.lsKind
			console.log "containers by type and kind"
			console.log baseurl
			stubFlag = "with=stub"
			if req.query.stub
				baseurl += "?#{stubFlag}"
			serverUtilityFunctions.getFromACASServer(baseurl, resp)

exports.containerByCodeName = (req, resp) ->
	if req.query.testMode or global.specRunnerTestmode
		containerTestJSON = require '../public/javascripts/spec/testFixtures/ContainerServiceTestJSON.js'
		resp.json containerTestJSON.container
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/"+req.params.code
		serverUtilityFunctions.getFromACASServer(baseurl, resp)


updateContainer = (container, testMode, callback) ->
	serverUtilityFunctions = require './ServerUtilityFunctions.js'
	serverUtilityFunctions.createLSTransaction container.recordedDate, "updated experiment", (transaction) ->
		container = serverUtilityFunctions.insertTransactionIntoEntity transaction.id, container
		if testMode or global.specRunnerTestmode
			callback container
		else
			config = require '../conf/compiled/conf.js'
			baseurl = config.all.client.service.persistence.fullpath+"containers/"+container.code
			request = require 'request'
			request(
				method: 'PUT'
				url: baseurl
				body: container
				json: true
			, (error, response, json) =>
				if !error && response.statusCode == 200
					callback json
				else
					console.log 'got ajax error trying to update lsContainer'
					console.log error
					console.log response
			)


postContainer = (req, resp) ->
	console.log "post container"
	serverUtilityFunctions = require './ServerUtilityFunctions.js'
	containerToSave = req.body
	serverUtilityFunctions.createLSTransaction containerToSave.recordedDate, "new experiment", (transaction) ->
		containerToSave = serverUtilityFunctions.insertTransactionIntoEntity transaction.id, containerToSave
		if req.query.testMode or global.specRunnerTestmode
			unless containerToSave.codeName?
				containerToSave.codeName = "PT00002-1"

		checkFilesAndUpdate = (container) ->
			fileVals = serverUtilityFunctions.getFileValuesFromEntity container, false
			filesToSave = fileVals.length

			completeContainerUpdate = (containerToUpdate)->
				updateContainer containerToUpdate, req.query.testMode, (updatedContainer) ->
					resp.json updatedContainer

			fileSaveCompleted = (passed) ->
				if !passed
					resp.statusCode = 500
					return resp.end "file move failed"
				if --filesToSave == 0 then completeContainerUpdate(container)

			if filesToSave > 0
				prefix = serverUtilityFunctions.getPrefixFromEntityCode container.codeName
				for fv in fileVals
					console.log "updating file"
					csUtilities.relocateEntityFile fv, prefix, container.codeName, fileSaveCompleted
			else
				resp.json container

		if req.query.testMode or global.specRunnerTestmode
			checkFilesAndUpdate containerToSave
		else
			config = require '../conf/compiled/conf.js'
			baseurl = config.all.client.service.persistence.fullpath+"containers"
			request = require 'request'
			request(
				method: 'POST'
				url: baseurl
				body: containerToSave
				json: true
			, (error, response, json) =>
				if !error && response.statusCode == 201
					checkFilesAndUpdate json
				else
					console.log 'got ajax error trying to save lsContainer'
					console.log error
					console.log json
					console.log response
			)

exports.postContainer = (req, resp) ->
	postContainer req, resp

exports.putContainer = (req, resp) ->
#	if req.query.testMode or global.specRunnerTestmode
#		containerTestJSON = require '../public/javascripts/spec/testFixtures/ContainerServiceTestJSON.js'
#		containerToSave = JSON.parse(JSON.stringify(containerTestJSON.container))
#	else
	containerToSave = req.body
	fileVals = serverUtilityFunctions.getFileValuesFromEntity containerToSave, true
	filesToSave = fileVals.length

	completeContainerUpdate = ->
		updateContainer containerToSave, req.query.testMode, (updatedContainer) ->
			resp.json updatedContainer

	fileSaveCompleted = (passed) ->
		if !passed
			resp.statusCode = 500
			return resp.end "file move failed"
		if --filesToSave == 0 then completeContainerUpdate()

	if filesToSave > 0
		prefix = serverUtilityFunctions.getPrefixFromEntityCode req.body.codeName
		for fv in fileVals
			if !fv.id?
				csUtilities.relocateEntityFile fv, prefix, req.body.codeName, fileSaveCompleted
	else
		completeContainerUpdate()

exports.validateContainerName = (req, resp) ->
	if req.query.testMode or global.specRunnerTestmode
		containerTestJSON = require '../public/javascripts/spec/testFixtures/ContainerServiceTestJSON.js'
		resp.json true
	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/validate"
		#		if req.params.componentOrAssembly is "component"
		#			baseurl += "?uniqueName=true"
		#		else #is assembly
		#			baseurl += "?uniqueName=true&uniqueInteractions=true&orderMatters=true&forwardAndReverseAreSame=true"
		request = require 'request'
		console.log "validate container name body"
		console.log req.body
		console.log req.body.container
		request(
			method: 'POST'
			url: baseurl
			body: req.body.container
			json: true
		, (error, response, json) =>
			console.log "response"
			console.log json
			console.log response.statusCode
			if !error && response.statusCode == 202
				resp.json true
			else if response.statusCode == 409
				resp.json json
			else
				console.log 'got ajax error trying to validate container name'
				console.log error
				console.log json
				console.log response
				resp.json "error"
		)

exports.getContainerCodesFromNamesOrCodes = (codeRequest, callback) ->
	console.log "got to getContainerCodesFormNamesOrCodes"
	if global.specRunnerTestmode
		results = []
		for req in codeRequest.requests
			res = requestName: req.requestName
			if req.requestName.indexOf("ambiguous") > -1
				res.referenceName = ""
				res.preferredName = ""
			else if req.requestName.indexOf("name") > -1
				res.referenceName = "CONT1111"
				res.preferredName = "1111"
			else if req.requestName.indexOf("1111") > -1
				res.referenceName = "CONT1111"
				res.preferredName = "1111"
			else
				res.referenceName = req.requestName
				res.preferredName = req.requestName
			results.push res
		response =
			containerType: codeRequest.containerType
			containerKind: codeRequest.containerKind
			results: results

		callback response
	else
		config = require '../conf/compiled/conf.js'
		#TODO: replace with new url
		baseurl = config.all.client.service.persistence.fullpath+"containers/getCodeNameFromNameRequest?"
		#		baseurl = config.all.client.service.persistence.fullpath+"containers/getContainerCodesByLabels?"
		url = baseurl+"containerType=#{codeRequest.containerType}&containerKind=#{codeRequest.containerKind}"
		postBody = requests: codeRequest.requests
		console.log postBody
		console.log url
		request = require 'request'
		request(
			method: 'POST'
			url: url
			body: postBody
			json: true
		, (error, response, json) =>
			console.log response.statusCode
			console.log json
			if !error and !json.error
				callback
					containerType: codeRequest.containerType
					containerKind: codeRequest.containerKind
					results: json.results
			else
				console.log 'got ajax error trying to lookup lsContainer name'
				console.log error
				console.log response
				callback json
		)

getContainerCodesFromLabels = (req, callback) ->

	if global.specRunnerTestmode
		response =
			codeName: 'CONT-0000001'
			label: 'test label'
		callback response

	else
		config = require '../conf/compiled/conf.js'
		baseurl = config.all.client.service.persistence.fullpath+"containers/getContainerCodesByLabels?"
		url = baseurl+"containerType=#{req.body.containerType}&containerKind=#{req.body.containerKind}"
		postBody = req.body.labels
		console.log postBody
		console.log url
		request = require 'request'
		request(
			method: 'POST'
			url: url
			body: postBody
			json: true
		, (error, response, json) =>
			console.log response.statusCode
			console.log json
			if !error and !json.error
				callback json
			else
				console.log 'got ajax error trying to lookup lsContainer name'
				console.log error
				console.log response
				callback json
		)

exports.getContainerCodesFromLabels = (req, resp) ->

	getContainerCodesFromLabels req, (json) ->
		resp.json json


exports.getContainerFromLabel = (req, resp) -> #only for sending in 1 label and expecting to get 1 container back
	getContainerCodesFromLabels req, (json) ->
		if json[0]?.codeName? #assumes that labels are unique
			req.params.code = json[0].codeName
			exports.containerByCodeName req, resp
		else
			resp.json {}

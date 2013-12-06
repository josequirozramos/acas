class window.PrimaryScreenAnalysisParameters extends Backbone.Model
	defaults:
		transformationRule: "unassigned"
		normalizationRule: "unassigned"
		hitEfficacyThreshold: null
		hitSDThreshold: null
		positiveControl: new Backbone.Model()
		negativeControl: new Backbone.Model()
		vehicleControl: new Backbone.Model()
		thresholdType: "sd"

	initialize: ->
		@fixCompositeClasses()


	fixCompositeClasses: =>
		if @get('positiveControl') not instanceof Backbone.Model
			@set positiveControl: new Backbone.Model(@get('positiveControl'))
		@get('positiveControl').on "change", =>
			@trigger 'change'
		if @get('negativeControl') not instanceof Backbone.Model
			@set negativeControl: new Backbone.Model(@get('negativeControl'))
		@get('negativeControl').on "change", =>
			@trigger 'change'
		if @get('vehicleControl') not instanceof Backbone.Model
			@set vehicleControl: new Backbone.Model(@get('vehicleControl'))
		@get('vehicleControl').on "change", =>
			@trigger 'change'

class window.PrimaryScreenExperiment extends Experiment
	getAnalysisParameters: ->
		ap = @.get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "clobValue", "data analysis parameters"
		if ap.get('clobValue')?
			return new PrimaryScreenAnalysisParameters eval(ap.get('clobValue'))
		else
			return new PrimaryScreenAnalysisParameters()


class window.PrimaryScreenAnalysisParametersController extends AbstractParserFormController
	template: _.template($("#PrimaryScreenAnalysisParametersView").html())
	autofillTemplate: _.template($("#PrimaryScreenAnalysisParametersAutofillView").html())

	events:
		"change .bv_transformationRule": "handleInputChanged"
		"change .bv_normalizationRule": "handleInputChanged"
		"change .bv_transformationRule": "handleInputChanged"
		"change .bv_hitEfficacyThreshold": "handleInputChanged"
		"change .bv_hitSDThreshold": "handleInputChanged"
		"change .bv_posControlBatch": "handleInputChanged"
		"change .bv_posControlConc": "handleInputChanged"
		"change .bv_negControlBatch": "handleInputChanged"
		"change .bv_negControlConc": "handleInputChanged"
		"change .bv_vehControlBatch": "handleInputChanged"
		"change .bv_thresholdTypeEfficacy": "handleThresholdTypeChanged"
		"change .bv_thresholdTypeSD": "handleThresholdTypeChanged"

	initialize: ->
		@errorOwnerName = 'PrimaryScreenAnalysisParametersController'
		super()

	render: =>
		@$('.bv_autofillSection').empty()
		@$('.bv_autofillSection').html @autofillTemplate(@model.attributes)
		@$('.bv_transformationRule').val(@model.get('transformationRule'))
		@$('.bv_normalizationRule').val(@model.get('normalizationRule'))

		@

	handleInputChanged: =>
		@model.set
			transformationRule: @$('.bv_transformationRule').val()
			normalizationRule: @$('.bv_normalizationRule').val()
			hitEfficacyThreshold: @getTrimmedInput('.bv_hitEfficacyThreshold')
			hitSDThreshold: @getTrimmedInput('.bv_hitSDThreshold')
		@model.get('positiveControl').set
			batchCode: @getTrimmedInput('.bv_posControlBatch')
			concentration: @getTrimmedInput('.bv_posControlConc')
		@model.get('negativeControl').set
			batchCode: @getTrimmedInput('.bv_negControlBatch')
			concentration: @getTrimmedInput('.bv_negControlConc')
		@model.get('vehicleControl').set
			batchCode: @getTrimmedInput('.bv_vehControlBatch')
			concentration: null

	handleThresholdTypeChanged: =>
		thresholdType = @$("input[name='bv_thresholdType']:checked").val()
		@model.set thresholdType: thresholdType
		if thresholdType=="efficacy"
			@$('.bv_hitSDThreshold').attr('disabled','disabled')
			@$('.bv_hitEfficacyThreshold').removeAttr('disabled')
		else
			@$('.bv_hitEfficacyThreshold').attr('disabled','disabled')
			@$('.bv_hitSDThreshold').removeAttr('disabled')


class window.PrimaryScreenExperimentController extends Backbone.View
	template: _.template($("#PrimaryScreenExperimentView").html())
	events:
		"click .bv_save": "handleSaveClicked"

	initialize: ->
		unless @model?
			@model = new Experiment()

		$(@el).html @template()
		@model.on 'sync', @handleExperimentSaved
		@experimentBaseController = new ExperimentBaseController
			model: @model
			el: @$('.bv_experimentBase')
		@analysisController = new PrimaryScreenAnalysisController
			model: @model
			el: @$('.bv_primaryScreenDataAnalysis')
		@doseRespController = new DoseResponseAnalysisController
			model: @model
			el: @$('.bv_doseResponseAnalysis')
		@model.on "protocol_attributes_copied", @handleProtocolAttributesCopied

	render: ->
		@experimentBaseController.render()
		@analysisController.render()
		@doseRespController.render()
		return @

	handleSaveClicked: =>
		#TODO add validation code and keep this button disabled until saving is a good idea
		#console.log @model.getDescription()
		#console.log JSON.stringify @model
		@model.save()

	handleExperimentSaved: =>
		#console.log @model
		@analysisController.render()

	handleProtocolAttributesCopied: =>
		@analysisController.render()


class window.PrimaryScreenAnalysisController extends Backbone.View
	template: _.template($("#PrimaryScreenAnalysisView").html())
	events:
		"change .bv_hitThreshold": "handleHitThresholdChanged"
		"change .bv_transformationRule": "handleTransformationRuleChanged"
		"change .bv_normalizationRule": "handleNormalizationRuleChanged"

	initialize: ->
		@model.on "synced_and_repaired", @handleExperimentSaved

	render: =>
		$(@el).empty()
		$(@el).html @template()
		@showControlValues()
		@$('.bv_hitThreshold').val(@getHitThreshold())
		@$('.bv_transformationRule').val(@getTransformationRule())
		@$('.bv_normalizationRule').val(@getNormalizationRule())
		@showExistingResults()
		if not @model.isNew()
			@handleExperimentSaved()
		@

	showControlValues: ->
		#negControl = @model.getControlType("negative control")
		#console.log negControl
		#console.log @model.getControlStates()
		#@$('bv_negControlBatch').val negControl[0].getValuesByTypeAndKind("codeValue", "batch code")[0].get('codeValue')


	getHitThreshold: ->
		value = @model.get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment analysis parameters", "numericValue", "active efficacy threshold"
		value.get('numericValue')

	getTransformationRule: ->
		value = @model.get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment analysis parameters", "stringValue", "data transformation rule"
		value.get('stringValue')

	getNormalizationRule: ->
		value = @model.get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment analysis parameters", "stringValue", "normalization rule"
		value.get('stringValue')

	showExistingResults: ->
		analysisStatus = @model.get('lsStates').getStateValueByTypeAndKind "metadata", "experiment metadata", "stringValue", "analysis status"
		if analysisStatus != null
			@analysisStatus = analysisStatus.get('stringValue')
			@$('.bv_analysisStatus').html(@analysisStatus)
		else
			@analysisStatus = "not started"
		resultValue = @model.get('lsStates').getStateValueByTypeAndKind "metadata", "experiment metadata", "clobValue", "analysis result html"
		if resultValue != null
			@$('.bv_analysisResultsHTML').html(resultValue.get('clobValue'))

	handleHitThresholdChanged: =>
		value = @model.get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment analysis parameters", "numericValue", "active efficacy threshold"
		value.set numericValue: parseFloat($.trim(@$('.bv_hitThreshold').val()))

	handleTransformationRuleChanged: =>
		value = @model.get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment analysis parameters", "stringValue", "data transformation rule"
		value.set stringValue: $.trim(@$('.bv_transformationRule').val())

	handleNormalizationRuleChanged: =>
		value = @model.get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment analysis parameters", "stringValue", "normalization rule"
		value.set stringValue: $.trim(@$('.bv_normalizationRule').val())

	handleExperimentSaved: =>
		if @analysisStatus is "complete"
			@$('.bv_fileUploadWrapper').html("")
		else
			@dataAnalysisController = new UploadAndRunPrimaryAnalsysisController
				el: @$('.bv_fileUploadWrapper')
			@dataAnalysisController.setUser(@model.get('recordedBy'))
			@dataAnalysisController.setExperimentId(@model.id)

class window.UploadAndRunPrimaryAnalsysisController extends BasicFileValidateAndSaveController
	initialize: ->
		UploadAndRunPrimaryAnalsysisController.__super__.initialize.apply(@, arguments)
		@fileProcessorURL = "/api/primaryAnalysis/runPrimaryAnalysis"
		@errorOwnerName = 'UploadAndRunPrimaryAnalsysisController'
		@allowedFileTypes = ['zip']
		super()
		@$('.bv_moduleTitle').html("Upload Data and Analyze")

	setUser: (user) ->
		@userName = user

	setExperimentId: (expId) ->
		@additionalData =
			primaryAnalysisExperimentId: expId
			testMode: false

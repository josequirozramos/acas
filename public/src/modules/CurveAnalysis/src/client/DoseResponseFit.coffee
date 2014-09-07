class window.DoseResponseDataParserController extends BasicFileValidateAndSaveController

	initialize: ->
		@loadReportFile = true
		@fileProcessorURL = "/api/genericDataParser"
		@errorOwnerName = 'DoseResponseDataParserController'
		@additionalData = requireDoseResponse: true
		super()
		@$('.bv_moduleTitle').html('Load Efficacy Data for Dose-Response Fit')

	handleSaveReturnSuccess: (json) =>
		super(json)
		@trigger 'dataUploadComplete'
		@$('.bv_completeControlContainer').hide()



class window.DoseResponseFitController extends Backbone.View
	template: _.template($("#DoseResponseFitView").html())
	events:
		"click .bv_fitModelButton": "launchFit"

	initialize: ->
		if !@options.experimentCode?
			alert("DoseResponseFitController must be initialized with an experimentCode")

	render: =>
		@parameterController = null
		$(@el).empty()
		$(@el).html @template()
		@setupCurveFitAnalysisParameterController()

	setupCurveFitAnalysisParameterController: ->
		@parameterController = new DoseResponseAnalysisParametersController
			el: @$('.bv_analysisParameterForm')
			model: new DoseResponseAnalysisParameters()
		@parameterController.on 'amDirty', =>
			@trigger 'amDirty'
		@parameterController.on 'amClean', =>
			@trigger 'amClean'
		@parameterController.on 'valid', @paramsValid
		@parameterController.on 'invalid', @paramsInvalid
		@parameterController.render()

	paramsValid: =>
		@$('.bv_fitModelButton').removeAttr('disabled')

	paramsInvalid: =>
		@$('.bv_fitModelButton').attr('disabled','disabled')

	launchFit: =>
		@$('.bv_fitStatusDropDown').modal
			backdrop: "static"
		@$('.bv_fitStatusDropDown').modal "show"

		fitData =
			inputParameters: JSON.stringify @parameterController.model
			user: window.AppLaunchParams.loginUserName
			experimentCode: @options.experimentCode
			testMode: false

		$.ajax
			type: 'POST'
			url: "/api/doseResponseCurveFit"
			data: fitData
			success: @fitReturnSuccess
			error: (err) =>
				alert 'got ajax error'
				@serviceReturn = null
				@$('.bv_fitStatusDropDown').modal("hide")
			dataType: 'json'

	fitReturnSuccess: (json) =>
		@$('.bv_modelFitResultsHTML').html(json.results.htmlSummary)
		@$('.bv_modelFitStatus').html(json.results.status)
		@$('.bv_resultsContainer').show()
		@$('.bv_fitModelButton').hide()
		@$('.bv_fitOptionWrapper').hide()
		@$('.bv_fitStatusDropDown').modal("hide")
		@trigger 'fitComplete'
		@trigger 'amClean'


class window.DoseResponseFitWorkflowController extends Backbone.View
	template: _.template($("#DoseResponseFitWorkflowView").html())
	events:
		"click .bv_loadAnother": "handleFitAnother"

	render: =>
		@$el.empty()
		@$el.html @template()
		@intializeParserController()

		@

	intializeParserController: ->
		@$('.bv_dataParser').empty()
		@drdpc = new DoseResponseDataParserController
			el: @$('.bv_dataParser')
		@drdpc.on 'dataUploadComplete', @handleDataUploadComplete
		@drdpc.on 'amDirty', =>
			@trigger 'amDirty'
		@drdpc.on 'amClean', =>
			@trigger 'amClean'
		@drdpc.render()

	initializeCurveFitController: =>
		@$('.bv_doseResponseAnalysis').empty()
		@modelFitController = new DoseResponseFitController
			experimentCode: @drdpc.getNewExperimentCode()
			el: @$('.bv_doseResponseAnalysis')
		@modelFitController.on 'amDirty', =>
			@trigger 'amDirty'
		@modelFitController.on 'amClean', =>
			@trigger 'amClean'
		@modelFitController.render()
		@modelFitController.on 'fitComplete', @handleFitComplete

	handleDataUploadComplete: =>
		@$('.bv_modelFitTabLink').click()
		@initializeCurveFitController()
		@trigger 'amDirty'

	handleFitComplete: =>
		@$('.bv_completeControlContainer').show()

	handleFitAnother: =>
		@drdpc.loadAnother()
		@$('.bv_completeControlContainer').hide()
		@$('.bv_uploadDataTabLink').click()



class window.PrimaryAnalysisRead extends Backbone.Model
	defaults:
		readPosition: null
		readName: "unassigned"
		activity: false

	validate: (attrs) =>
		errors = []
		if _.isNaN(attrs.readPosition) or attrs.readPosition is "" or attrs.readPosition is null
			errors.push
				attribute: 'readPosition'
				message: "Read position must be a number"
		if attrs.readName is "unassigned" or attrs.readName is ""
			errors.push
				attribute: 'readName'
				message: "Read name must be assigned"
		if errors.length > 0
			return errors
		else
			return null

	triggerAmDirty: =>
		@trigger 'amDirty', @

class window.TransformationRule extends Backbone.Model
	defaults:
		transformationRule: "unassigned"

	validate: (attrs) ->
		errors = []
		if attrs.transformationRule is "unassigned"
			errors.push
				attribute: 'transformationRule'
				message: "Transformation Rule must be assigned"

		if errors.length > 0
			return errors
		else
			return null

	triggerAmDirty: =>
		@trigger 'amDirty', @

class window.PrimaryAnalysisReadList extends Backbone.Collection
	model: PrimaryAnalysisRead

	validateCollection: (matchReadName) =>
		modelErrors = []
		usedReadNames = {}
		if @.length != 0
			for index in [0..@.length-1]
				model = @.at(index)
				indivModelErrors = model.validate(model.attributes) # note: can't call model.isValid() because if invalid, the function will trigger validationError, which adds the class "error" to the invalid attributes
				if indivModelErrors != null
					for error in indivModelErrors
						unless (matchReadName and error.attribute == 'readPosition')
								modelErrors.push
									attribute: error.attribute+':eq('+index+')'
									message: error.message
				currentReadName = model.get('readName')
				if currentReadName of usedReadNames
					modelErrors.push
						attribute: 'readName:eq('+index+')'
						message: "Read name can not be chosen more than once"
					modelErrors.push
						attribute: 'readName:eq('+usedReadNames[currentReadName]+')'
						message: "Read name can not be chosen more than once"
				else
					usedReadNames[currentReadName] = index
		return modelErrors


class window.TransformationRuleList extends Backbone.Collection
	model: TransformationRule


	validateCollection: =>
		modelErrors = []
		usedRules ={}
		if @.length != 0
			for index in [0..@.length-1]
				model = @.at(index)
				indivModelErrors = model.validate(model.attributes)
				if indivModelErrors != null
					for error in indivModelErrors
						modelErrors.push
							attribute: error.attribute+':eq('+index+')'
							message: error.message
				currentRule = model.get('transformationRule')
				if currentRule of usedRules
					modelErrors.push
						attribute: 'transformationRule:eq('+index+')'
						message: "Transformation Rules can not be chosen more than once"
					modelErrors.push
						attribute: 'transformationRule:eq('+usedRules[currentRule]+')'
						message: "Transformation Rules can not be chosen more than once"
				else
					usedRules[currentRule] = index
		modelErrors


class window.PrimaryScreenAnalysisParameters extends Backbone.Model
	defaults: ->
		instrumentReader: "unassigned"
		signalDirectionRule: "unassigned"
		aggregateBy: "unassigned"
		aggregationMethod: "unassigned"
		normalizationRule: "unassigned"
		assayVolume: null
		transferVolume: null
		dilutionFactor: null
		hitEfficacyThreshold: null
		hitSDThreshold: null
		positiveControl: new Backbone.Model()
		negativeControl: new Backbone.Model()
		vehicleControl: new Backbone.Model()
		agonistControl: new Backbone.Model()
		thresholdType: null
		volumeType: "dilution"
		htsFormat: false
		autoHitSelection: false
		matchReadName: true
		primaryAnalysisReadList: new PrimaryAnalysisReadList()
		transformationRuleList: new TransformationRuleList()


	initialize: ->
		@.set @parse(@.attributes)

	parse: (resp) =>
		if resp.positiveControl?
			if resp.positiveControl not instanceof Backbone.Model
				resp.positiveControl = new Backbone.Model(resp.positiveControl)
			resp.positiveControl.on 'change', =>
				@trigger 'change'
		if resp.negativeControl?
			if resp.negativeControl not instanceof Backbone.Model
				resp.negativeControl = new Backbone.Model(resp.negativeControl)
			resp.negativeControl.on 'change', =>
				@trigger 'change'
		if resp.vehicleControl?
			if resp.vehicleControl not instanceof Backbone.Model
				resp.vehicleControl = new Backbone.Model(resp.vehicleControl)
			resp.vehicleControl.on 'change', =>
				@trigger 'change'
		if resp.agonistControl?
			if resp.agonistControl not instanceof Backbone.Model
				resp.agonistControl = new Backbone.Model(resp.agonistControl)
			resp.agonistControl.on 'change', =>
				@trigger 'change'
		if resp.primaryAnalysisReadList?
			if resp.primaryAnalysisReadList not instanceof PrimaryAnalysisReadList
				resp.primaryAnalysisReadList = new PrimaryAnalysisReadList(resp.primaryAnalysisReadList)
			resp.primaryAnalysisReadList.on 'change', =>
				@trigger 'change'
			resp.primaryAnalysisReadList.on 'amDirty', =>
				@trigger 'amDirty'
		if resp.transformationRuleList?
			if resp.transformationRuleList not instanceof TransformationRuleList
				resp.transformationRuleList = new TransformationRuleList(resp.transformationRuleList)
			resp.transformationRuleList.on 'change', =>
				@trigger 'change'
			resp.transformationRuleList.on 'amDirty', =>
				@trigger 'amDirty'
		resp


	validate: (attrs) ->
		errors = []
		readErrors = @get('primaryAnalysisReadList').validateCollection(attrs.matchReadName)
		errors.push readErrors...
		transformationErrors = @get('transformationRuleList').validateCollection()
		errors.push transformationErrors...
		positiveControl = @get('positiveControl').get('batchCode')
		if positiveControl is "" or positiveControl is undefined
			errors.push
				attribute: 'positiveControlBatch'
				message: "Positive control batch much be set"
		positiveControlConc = @get('positiveControl').get('concentration')
		if _.isNaN(positiveControlConc) or positiveControlConc is undefined or positiveControlConc is null or positiveControlConc is ""
			errors.push
				attribute: 'positiveControlConc'
				message: "Positive control conc much be set"
		negativeControl = @get('negativeControl').get('batchCode')
		if negativeControl is "" or negativeControl is undefined
			errors.push
				attribute: 'negativeControlBatch'
				message: "Negative control batch much be set"
		negativeControlConc = @get('negativeControl').get('concentration')
		if _.isNaN(negativeControlConc) || negativeControlConc is undefined || negativeControlConc is null or negativeControlConc is ""
			errors.push
				attribute: 'negativeControlConc'
				message: "Negative control conc much be set"

		agonistControl = @get('agonistControl').get('batchCode')
		agonistControlConc = @get('agonistControl').get('concentration')
		if (agonistControl !="" and agonistControl != undefined) or (agonistControlConc != "" and agonistControlConc != undefined) # at least one of the agonist control fields is filled
			if agonistControl is "" or agonistControl is undefined
				errors.push
					attribute: 'agonistControlBatch'
					message: "Agonist control batch much be set"
			if _.isNaN(agonistControlConc) || agonistControlConc is undefined || agonistControlConc is ""
				errors.push
					attribute: 'agonistControlConc'
					message: "Agonist control conc much be set"
		if attrs.signalDirectionRule is "unassigned" or attrs.signalDirectionRule is ""
			errors.push
				attribute: 'signalDirectionRule'
				message: "Signal Direction Rule must be assigned"
		if (attrs.aggregateBy is "unassigned" or attrs.aggregateBy is "") and (attrs.aggregationMethod is "unassigned" or attrs.aggregationMethod is "")
			errors.push
				attribute: 'aggregateByGroup'
				message: "Aggregate By and Aggregation Method must be assigned"
		else
			if attrs.aggregateBy is "unassigned" or attrs.aggregateBy is ""
				errors.push
					attribute: 'aggregateByGroup'
					message: "Aggregate By must be assigned"
			if attrs.aggregationMethod is "unassigned" or attrs.aggregationMethod is ""
				errors.push
					attribute: 'aggregateByGroup'
					message: "Aggregation method must be assigned"
		if attrs.normalizationRule is "unassigned" or attrs.normalizationRule is ""
			errors.push
				attribute: 'normalizationRule'
				message: "Normalization rule must be assigned"
		if attrs.autoHitSelection
			if attrs.thresholdType == "sd" && _.isNaN(attrs.hitSDThreshold)
				errors.push
					attribute: 'hitSDThreshold'
					message: "SD threshold must be assigned"
			if attrs.thresholdType == "efficacy" && _.isNaN(attrs.hitEfficacyThreshold)
				errors.push
					attribute: 'hitEfficacyThreshold'
					message: "Efficacy threshold must be assigned"
		if _.isNaN(attrs.assayVolume)
			errors.push
				attribute: 'assayVolume'
				message: "Assay volume must be assigned"
		if (attrs.assayVolume == "" or attrs.assayVolume == null) and (attrs.transferVolume != "" and attrs.transferVolume != null)
				errors.push
					attribute: 'assayVolume'
					message: "Assay volume must be assigned"
		if attrs.volumeType == "dilution" && _.isNaN(attrs.dilutionFactor)
			errors.push
				attribute: 'dilutionFactor'
				message: "Dilution factor must be a number"
		if attrs.volumeType == "transfer" and _.isNaN(attrs.transferVolume)
			errors.push
				attribute: 'transferVolume'
				message: "Transfer volume must be assigned"

		if errors.length > 0
			return errors
		else
			return null

	autocalculateVolumes: ->
		dilutionFactor = @.get('dilutionFactor')
		transferVolume = @.get('transferVolume')
		assayVolume = @.get('assayVolume')
		if @.get('volumeType')=='dilution'
			if isNaN(dilutionFactor) or dilutionFactor=="" or dilutionFactor == 0 or isNaN(assayVolume) or assayVolume==""
				transferVolume = ""
			else
				transferVolume = assayVolume/dilutionFactor
			@.set transferVolume: transferVolume
			return transferVolume
		else
			if isNaN(transferVolume) or transferVolume=="" or transferVolume == 0 or isNaN(assayVolume) or assayVolume==""
				dilutionFactor = ""
			else
				dilutionFactor = assayVolume/transferVolume
			@.set dilutionFactor: dilutionFactor
			return dilutionFactor


class window.PrimaryScreenExperiment extends Experiment

	initialize: ->
		super()
		@.set lsKind: "flipr screening assay"

	getDryRunStatus: ->
		status = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "codeValue", "dry run status"
		if !status.has('codeValue')
			status.set codeValue: "not started"
			status.set codeType: "dry run"
			status.set codeKind: "status"
			status.set codeOrigin: "acas ddict"

		status

	getDryRunResultHTML: ->
		result = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "clobValue", "dry run result html"
		if !result.has('clobValue')
			result.set clobValue: ""

		result

	getAnalysisStatus: ->
		status = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "stringValue", "analysis status"
		if !status.has('stringValue')
			status.set stringValue: "not started"

		status

	getAnalysisResultHTML: ->
		result = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "clobValue", "analysis result html"
		if !result.has('clobValue')
			result.set clobValue: ""

		result

	getModelFitStatus: ->
		status = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "stringValue", "model fit status"
		if !status.has('stringValue')
			status.set stringValue: "not started"

		status

	getModelFitResultHTML: ->
		result = @get('lsStates').getOrCreateValueByTypeAndKind "metadata", "experiment metadata", "clobValue", "model fit result html"
		if !result.has('clobValue')
			result.set clobValue: ""

		result

class window.PrimaryAnalysisReadController extends AbstractFormController
	template: _.template($("#PrimaryAnalysisReadView").html())
	tagName: "div"
	className: "form-inline"
	events:
		"change .bv_readPosition": "attributeChanged"
		"change .bv_readName": "attributeChanged"
		"click .bv_activity": "attributeChanged"
		"click .bv_delete": "clear"

	initialize: ->
		@errorOwnerName = 'PrimaryAnalysisReadController'
		@setBindings()
		@model.on "destroy", @remove, @



	render: =>
		$(@el).empty()
		$(@el).html @template(@model.attributes)
		@setUpReadNameSelect()

		@

	setUpReadNameSelect: ->
		@readNameList = new PickListList()
		@readNameList.url = "/api/dataDict/experiment metadata/read name"
		@readNameListController = new PickListSelectController
			el: @$('.bv_readName')
			collection: @readNameList
			insertFirstOption: new PickList
				code: "unassigned"
				name: "Select Read Name"
			selectedCode: @model.get('readName')

	setUpReadPosition: (matchReadNameChecked) ->
		if matchReadNameChecked
			@$('.bv_readPosition').attr('disabled','disabled')
		else
			@$('.bv_readPosition').removeAttr('disabled')


	updateModel: =>
		activity = @$('.bv_activity').is(":checked")
		@model.set
			readPosition: parseInt(UtilityFunctions::getTrimmedInput @$('.bv_readPosition'))
			readName: @readNameListController.getSelectedCode()
			activity: activity
		@model.triggerAmDirty()
		@trigger 'updateState'

	clear: =>
		@model.destroy()
		@model.triggerAmDirty()


class window.TransformationRuleController extends AbstractFormController
	template: _.template($("#TransformationRuleView").html())
	events:
		"change .bv_transformationRule": "attributeChanged"
		"click .bv_deleteRule": "clear"

	initialize: ->
		@errorOwnerName = 'TransformationRuleController'
		@setBindings()
		@model.on "destroy", @remove, @


	render: =>
		$(@el).empty()
		$(@el).html @template(@model.attributes)
		@setUpTransformationRuleSelect()

		@

	updateModel: =>
		@model.set transformationRule: @transformationListController.getSelectedCode()
		@model.triggerAmDirty()
		@trigger 'updateState'


	setUpTransformationRuleSelect: ->
		@transformationList = new PickListList()
		@transformationList.url = "/api/dataDict/experiment metadata/transformation"
		@transformationListController = new PickListSelectController
			el: @$('.bv_transformationRule')
			collection: @transformationList
			insertFirstOption: new PickList
				code: "unassigned"
				name: "Select Transformation Rule"
			selectedCode: @model.get('transformationRule')


	clear: =>
		@model.destroy()


class window.PrimaryAnalysisReadListController extends AbstractFormController
	template: _.template($("#PrimaryAnalysisReadListView").html())
	matchReadNameChecked: true
	events:
		"click .bv_addReadButton": "addNewRead"

	initialize: =>
		@collection.on 'remove', @checkActivity
		@collection.on 'remove', => @collection.trigger 'change'


	render: =>
		$(@el).empty()
		$(@el).html @template()
		@collection.each (read) =>
			@addOneRead(read)
		if @collection.length == 0
			@addNewRead(true)
		@checkActivity()

		@

	addNewRead: (skipAmDirtyTrigger) =>
		newModel = new PrimaryAnalysisRead()
		@collection.add newModel
		@addOneRead(newModel)
		if @collection.length ==1
			@checkActivity()
		unless skipAmDirtyTrigger is true
			newModel.triggerAmDirty()

	addOneRead: (read) ->
		parc = new PrimaryAnalysisReadController
			model: read
		@$('.bv_readInfo').append parc.render().el
		parc.setUpReadPosition(@matchReadNameChecked)
		parc.on 'updateState', =>
			@trigger 'updateState'

	matchReadNameChanged: (matchReadName) =>
		@matchReadNameChecked = matchReadName
		if @matchReadNameChecked
			@$('.bv_readPosition').val('')
			@$('.bv_readPosition').attr('disabled','disabled')
			@collection.each (read) =>
				read.set readPosition: ''
		else
			@$('.bv_readPosition').removeAttr('disabled')

	checkActivity: => #check that at least one activity is set
		index = @collection.length-1
		activitySet = false
		while index >= 0 and activitySet == false
			if @collection.at(index).get('activity') == true
				activitySet = true
			if index == 0
				@$('.bv_activity:eq(0)').attr('checked','checked')
				@collection.at(index).set activity: true
			index = index - 1


class window.TransformationRuleListController extends AbstractFormController
	template: _.template($("#TransformationRuleListView").html())
	events:
		"click .bv_addTransformationButton": "addNewRule"

	initialize: =>
		@collection.on 'remove', @checkNumberOfRules
		@collection.on 'remove', => @collection.trigger 'amDirty'
		@collection.on 'remove', => @collection.trigger 'change'


	render: =>
		$(@el).empty()
		$(@el).html @template()
		@collection.each (rule) =>
			@addOneRule(rule)
		if @collection.length == 0
			@addNewRule(true)
		@

	addNewRule: (skipAmDirtyTrigger)=>
		newModel = new TransformationRule()
		@collection.add newModel
		@addOneRule(newModel)
		unless skipAmDirtyTrigger is true
			newModel.triggerAmDirty()


	addOneRule: (rule) ->
		trc = new TransformationRuleController
			model: rule
		@$('.bv_transformationInfo').append trc.render().el
		trc.on 'updateState', =>
			@trigger 'updateState'


	checkNumberOfRules: => #ensures that there is always one rule
		if @collection.length == 0
			@addNewRule()

class window.PrimaryScreenAnalysisParametersController extends AbstractParserFormController
	template: _.template($("#PrimaryScreenAnalysisParametersView").html())
	autofillTemplate: _.template($("#PrimaryScreenAnalysisParametersAutofillView").html())


	events:
		"change .bv_instrumentReader": "attributeChanged"
		"change .bv_signalDirectionRule": "attributeChanged"
		"change .bv_aggregateBy": "attributeChanged"
		"change .bv_aggregationMethod": "attributeChanged"
		"change .bv_normalizationRule": "attributeChanged"
		"change .bv_assayVolume": "handleAssayVolumeChanged"
		"change .bv_dilutionFactor": "handleDilutionFactorChanged"
		"change .bv_transferVolume": "handleTransferVolumeChanged"
		"change .bv_hitEfficacyThreshold": "attributeChanged"
		"change .bv_hitSDThreshold": "attributeChanged"
		"change .bv_positiveControlBatch": "attributeChanged"
		"change .bv_positiveControlConc": "attributeChanged"
		"change .bv_negativeControlBatch": "attributeChanged"
		"change .bv_negativeControlConc": "attributeChanged"
		"change .bv_vehicleControlBatch": "attributeChanged"
		"change .bv_agonistControlBatch": "attributeChanged"
		"change .bv_agonistControlConc": "attributeChanged"
		"change .bv_thresholdTypeEfficacy": "handleThresholdTypeChanged"
		"change .bv_thresholdTypeSD": "handleThresholdTypeChanged"
		"change .bv_volumeTypeTransfer": "handleVolumeTypeChanged"
		"change .bv_volumeTypeDilution": "handleVolumeTypeChanged"
		"change .bv_autoHitSelection": "handleAutoHitSelectionChanged"
		"change .bv_htsFormat": "attributeChanged"
		"click .bv_matchReadName": "handleMatchReadNameChanged"




	initialize: ->
		@errorOwnerName = 'PrimaryScreenAnalysisParametersController'
		super()
		@model.bind 'amDirty', => @trigger 'amDirty', @
		@setupInstrumentReaderSelect()
		@setupSignalDirectionSelect()
		@setupAggregateBySelect()
		@setupAggregationMethodSelect()
		@setupNormalizationSelect()




	render: =>
		@$('.bv_autofillSection').empty()
		@$('.bv_autofillSection').html @autofillTemplate(@model.attributes)
		@setupInstrumentReaderSelect()
		@setupSignalDirectionSelect()
		@setupAggregateBySelect()
		@setupAggregationMethodSelect()
		@setupNormalizationSelect()
		@handleAutoHitSelectionChanged(true)
		@setupReadListController()
		@setupTransformationRuleListController()
		@handleMatchReadNameChanged(true)

		@


	setupInstrumentReaderSelect: ->
		@instrumentList = new PickListList()
		@instrumentList.url = "/api/dataDict/experiment metadata/instrument reader"
		@instrumentListController = new PickListSelectController
			el: @$('.bv_instrumentReader')
			collection: @instrumentList
			insertFirstOption: new PickList
				code: "unassigned"
				name: "Select Instrument"
			selectedCode: @model.get('instrumentReader')

	setupSignalDirectionSelect: ->
		@signalDirectionList = new PickListList()
		@signalDirectionList.url = "/api/dataDict/experiment metadata/signal direction"
		@signalDirectionListController = new PickListSelectController
			el: @$('.bv_signalDirectionRule')
			collection: @signalDirectionList
			insertFirstOption: new PickList
				code: "unassigned"
				name: "Select Signal Direction"
			selectedCode: @model.get('signalDirectionRule')

	setupAggregateBySelect: ->
		@aggregateByList = new PickListList()
		@aggregateByList.url = "/api/dataDict/experiment metadata/aggregate by"
		@aggregateByListController = new PickListSelectController
			el: @$('.bv_aggregateBy')
			collection: @aggregateByList
			insertFirstOption: new PickList
				code: "unassigned"
				name: "Select"
			selectedCode: @model.get('aggregateBy')

	setupAggregationMethodSelect: ->
		@aggregationMethodList = new PickListList()
		@aggregationMethodList.url = "/api/dataDict/experiment metadata/aggregation method"
		@aggregationMethodListController = new PickListSelectController
			el: @$('.bv_aggregationMethod')
			collection: @aggregationMethodList
			insertFirstOption: new PickList
				code: "unassigned"
				name: "Select"
			selectedCode: @model.get('aggregationMethod')

	setupNormalizationSelect: ->
		@normalizationList = new PickListList()
		@normalizationList.url = "/api/dataDict/experiment metadata/normalization"
		@normalizationListController = new PickListSelectController
			el: @$('.bv_normalizationRule')
			collection: @normalizationList
			insertFirstOption: new PickList
				code: "unassigned"
				name: "Select Rule"
			selectedCode: @model.get('normalizationRule')

	setupReadListController: ->
		@readListController= new PrimaryAnalysisReadListController
			el: @$('.bv_readList')
			collection: @model.get('primaryAnalysisReadList')
		@readListController.render()
		@readListController.on 'updateState', =>
			@trigger 'updateState'

	setupTransformationRuleListController: ->
		@transformationRuleListController= new TransformationRuleListController
			el: @$('.bv_transformationList')
			collection: @model.get('transformationRuleList')
		@transformationRuleListController.render()
		@transformationRuleListController.on 'updateState', =>
			@trigger 'updateState'



	updateModel: =>
		htsFormat = @$('.bv_htsFormat').is(":checked")
		@model.set
			instrumentReader: @instrumentListController.getSelectedCode()
			signalDirectionRule: @signalDirectionListController.getSelectedCode()
			aggregateBy: @aggregateByListController.getSelectedCode()
			aggregationMethod: @aggregationMethodListController.getSelectedCode()
			normalizationRule: @normalizationListController.getSelectedCode()
			hitEfficacyThreshold: parseFloat(UtilityFunctions::getTrimmedInput @$('.bv_hitEfficacyThreshold'))
			hitSDThreshold: parseFloat(UtilityFunctions::getTrimmedInput @$('.bv_hitSDThreshold'))
			assayVolume: UtilityFunctions::getTrimmedInput @$('.bv_assayVolume')
			transferVolume: UtilityFunctions::getTrimmedInput @$('.bv_transferVolume')
			dilutionFactor: UtilityFunctions::getTrimmedInput @$('.bv_dilutionFactor')
			htsFormat: htsFormat
		if @model.get('assayVolume') != ""
			@model.set assayVolume: parseFloat(UtilityFunctions::getTrimmedInput @$('.bv_assayVolume'))
		if @model.get('transferVolume') != ""
			@model.set transferVolume: parseFloat(UtilityFunctions::getTrimmedInput @$('.bv_transferVolume'))
		if @model.get('dilutionFactor') != ""
			@model.set dilutionFactor: parseFloat(UtilityFunctions::getTrimmedInput @$('.bv_dilutionFactor'))
		@model.get('positiveControl').set
			batchCode: UtilityFunctions::getTrimmedInput @$('.bv_positiveControlBatch')
			concentration: parseFloat(UtilityFunctions::getTrimmedInput @$('.bv_positiveControlConc'))
		@model.get('negativeControl').set
			batchCode: UtilityFunctions::getTrimmedInput @$('.bv_negativeControlBatch')
			concentration: parseFloat(UtilityFunctions::getTrimmedInput @$('.bv_negativeControlConc'))
		@model.get('vehicleControl').set
			batchCode: UtilityFunctions::getTrimmedInput @$('.bv_vehicleControlBatch')
			concentration: null
		@model.get('agonistControl').set
			batchCode: UtilityFunctions::getTrimmedInput @$('.bv_agonistControlBatch')
			concentration: UtilityFunctions::getTrimmedInput @$('.bv_agonistControlConc')
		if @model.get('agonistControl').get('concentration') != ""
			@model.get('agonistControl').set
				concentration: parseFloat(UtilityFunctions::getTrimmedInput @$('.bv_agonistControlConc'))
		@trigger 'updateState'

	handleAssayVolumeChanged: =>
		@attributeChanged()
		volumeType = @$("input[name='bv_volumeType']:checked").val()
		if volumeType == "dilution"
			@handleDilutionFactorChanged()
		else
			@handleTransferVolumeChanged()


	handleTransferVolumeChanged: =>
		@attributeChanged()
		dilutionFactor = @model.autocalculateVolumes()
		@$('.bv_dilutionFactor').val(dilutionFactor)

	handleDilutionFactorChanged: =>
		@attributeChanged()
		transferVolume = @model.autocalculateVolumes()
		@$('.bv_transferVolume').val(transferVolume)
		if transferVolume=="" or transferVolume == null
			@$('.bv_dilutionFactor').val(@model.get('dilutionFactor'))


	handleThresholdTypeChanged: =>
		thresholdType = @$("input[name='bv_thresholdType']:checked").val()
		@model.set thresholdType: thresholdType
		if thresholdType=="efficacy"
			@$('.bv_hitSDThreshold').attr('disabled','disabled')
			@$('.bv_hitEfficacyThreshold').removeAttr('disabled')
		else
			@$('.bv_hitEfficacyThreshold').attr('disabled','disabled')
			@$('.bv_hitSDThreshold').removeAttr('disabled')
		@attributeChanged()

	handleAutoHitSelectionChanged: (skipUpdate) =>
		autoHitSelection = @$('.bv_autoHitSelection').is(":checked")
		@model.set autoHitSelection: autoHitSelection
		if autoHitSelection
			@$('.bv_thresholdControls').show()
		else
			@$('.bv_thresholdControls').hide()
		unless skipUpdate is true
			@attributeChanged()

	handleVolumeTypeChanged: =>
		volumeType = @$("input[name='bv_volumeType']:checked").val()
		@model.set volumeType: volumeType
		if volumeType=="transfer"
			@$('.bv_dilutionFactor').attr('disabled','disabled')
			@$('.bv_transferVolume').removeAttr('disabled')
		else
			@$('.bv_transferVolume').attr('disabled','disabled')
			@$('.bv_dilutionFactor').removeAttr('disabled')
		if @model.get('transferVolume') == "" or @model.get('assayVolume')== ""
			@handleDilutionFactorChanged()
		@attributeChanged()

	handleMatchReadNameChanged: (skipUpdate) =>
		matchReadName = @$('.bv_matchReadName').is(":checked")
		@model.set matchReadName: matchReadName
		@readListController.matchReadNameChanged(matchReadName)
		unless skipUpdate is true
			@attributeChanged()

class window.AbstractUploadAndRunPrimaryAnalsysisController extends BasicFileValidateAndSaveController
#	See UploadAndRunPrimaryAnalsysisController for example required initialization function

	initialize: ->
		@allowedFileTypes = ['zip']
		@loadReportFile = true
		super()
		@$('.bv_reportFileDirections').html('To upload an <b>optional well flagging file</b>, click the "Browse Files…" button and select a file.')
#		@$("label[for='.bv_attachReportFile']").innerHTML('Attach optional well flagging file')
		@$('.bv_attachReportCheckboxText').html('Attach optional well flagging file')

	completeInitialization: ->
		@analysisParameterController.on 'valid', @handleMSFormValid
		@analysisParameterController.on 'invalid', @handleMSFormInvalid
		@analysisParameterController.on 'notifyError', @notificationController.addNotification
		@analysisParameterController.on 'clearErrors', @notificationController.clearAllNotificiations
		@analysisParameterController.on 'amDirty', =>
			@trigger 'amDirty'
		@analyzedPreviously = @options.analyzedPreviously
		@analysisParameterController.render()
		if @analyzedPreviously
			@$('.bv_loadAnother').html("Re-Analyze")
		@handleMSFormInvalid() #start invalid since file won't be loaded

	handleMSFormValid: =>
		if @parseFileUploaded
			@handleFormValid()

	handleMSFormInvalid: =>
		@handleFormInvalid()

	handleFormValid: ->
		if @analysisParameterController.isValid()
			super()

	handleValidationReturnSuccess: (json) =>
		super(json)
		if @$('.bv_resultStatus').html().indexOf "Success"
			resultStatus = "Dry Run Results: Success"
			if @$('.bv_resultStatus').html().indexOf "warnings"
				resultStatus += " but with warnings"
		else
			resultStatus = "Dry Run Results: Failed"
		@$('.bv_resultStatus').html(resultStatus)
		@analysisParameterController.disableAllInputs()

	handleSaveReturnSuccess: (json) =>
		super(json)
		@$('.bv_loadAnother').html("Re-Analyze")
		@trigger 'analysis-completed'

	backToUpload: =>
		super()
		@$('.bv_resultStatus').html("Upload Data and Analyze")
		@$('.bv_resultStatus').show()

	loadAnother: =>
		if @analyzedPreviously
			if !confirm("Re-analyzing the data will delete the previously saved results.")
				return
		super()
		@$('.bv_resultStatus').html("Upload Data and Analyze")
		@$('.bv_resultStatus').show()

	showFileSelectPhase: ->
		super()
		@$('.bv_resultStatus').show()
		if @analysisParameterController?
			@analysisParameterController.enableAllInputs()

	disableAll: ->
		@analysisParameterController.disableAllInputs()
		@$('.bv_htmlSummary').hide()
		@$('.bv_fileUploadWrapper').hide()
		@$('.bv_nextControlContainer').hide()
		@$('.bv_saveControlContainer').hide()
		@$('.bv_completeControlContainer').hide()
		@$('.bv_notifications').hide()

	enableAll: ->
		@analysisParameterController.enableAllInputs()
		@showFileSelectPhase()

	validateParseFile: =>
		@analysisParameterController.updateModel()
		unless !@analysisParameterController.isValid()
			@additionalData =
				inputParameters: JSON.stringify @analysisParameterController.model
				primaryAnalysisExperimentId: @experimentId
				testMode: false
			super()

	setUser: (user) ->
		@userName = user

	setExperimentId: (expId) ->
		@experimentId = expId

class window.UploadAndRunPrimaryAnalsysisController extends AbstractUploadAndRunPrimaryAnalsysisController
	initialize: ->
		@fileProcessorURL = "/api/primaryAnalysis/runPrimaryAnalysis"
		@errorOwnerName = 'UploadAndRunPrimaryAnalsysisController'
		@allowedFileTypes = ['zip']
		@maxFileSize = 200000000
		@loadReportFile = false
		super()
#		@$('.bv_moduleTitle').html("Upload Data and Analyze")
		@$('.bv_moduleTitle').hide()
		@analysisParameterController = new PrimaryScreenAnalysisParametersController
			model: @options.paramsFromExperiment
			el: @$('.bv_additionalValuesForm')
		@completeInitialization()

class window.PrimaryScreenAnalysisController extends Backbone.View
	template: _.template($("#PrimaryScreenAnalysisView").html())

	initialize: ->
		@model.on "sync", @handleExperimentSaved
		@model.getStatus().on 'change', @handleStatusChanged
		@dataAnalysisController = null
		$(@el).empty()
		$(@el).html @template()
		if @model.isNew()
			@setExperimentNotSaved()
		else
			@setExperimentSaved()
			@setupDataAnalysisController(@options.uploadAndRunControllerName)


	render: =>
		@showExistingResults()

	showExistingResults: ->
		dryRunStatus = @model.getDryRunStatus()
		if dryRunStatus != null
			dryRunStatus = dryRunStatus.get('codeValue')
		else
			dryRunStatus = "not started"
		analysisStatus = @model.getAnalysisStatus()
		if analysisStatus != null
			analysisStatus = analysisStatus.get('stringValue')
		else
			analysisStatus = "not started"
#		@$('.bv_analysisStatus').html(analysisStatus)


		#running statuses
		if dryRunStatus is "running"
			if analysisStatus is "running" # invalid state
				console.log "warning message"
				resultStatus = "An error has occurred. Dry Run: running. Analysis: running."
				resultHTML = "" #TODO: ask Sam if there will be anything in the result clobValues
				@trigger "warning"
			else
				console.log "validate status drop down modal progress bar"
				console.log "progress bar shown"
				resultStatus = "Dry Run Results: Dry run in progress."
				resultHTML = ""
				@trigger "dryRunRunning"
		else if analysisStatus is "running"
			if dryRunStatus is "not started" # invalid state
				console.log "warning message"
				resultStatus = "An error has occurred. Dry Run: not started. Analysis: running."
				resultHTML = "" #TODO: ask Sam if there will be anything in the result clobValues
			else #valid
				console.log "save status drop down modal progress bar"
				resultStatus = "Upload Results: Upload in progress." #TODO: need to have this?
				resultHTML = ""
				@trigger 'analysisRunning'

		#show analysis result clob
		else if analysisStatus is "complete" or analysisStatus is "failed"
			if analysisStatus is "complete"
				console.log "saved data page, fill bv_htmlSummary with analysis result html clobValue, show re-analyze button"
				resultStatus = "Upload Results: Success"
			else
				console.log "failed page, fill bv_htmlSummary with analyisis clob, show back button"
				resultStatus = "Upload Results: Failed due to errors"

			resultHTML = @model.getAnalysisResultHTML().get('clobValue')
			if @dataAnalysisController?
				@dataAnalysisController.showFileUploadCompletePhase()


		#if analysisStatus is not started
		else
			if dryRunStatus is "not started" #TODO: check if needed.
				console.log "upload data page - hide bv_htmlSummary, csvPreviewContainer, bv_saveControlContainer, bv_completeControlContainer"
				resultStatus = "Upload Data and Analyze"
				resultHTML = ""
			else
				console.log "update bv_resultStatus with the dryRun status, fill bv_htmlSummary with dry run result html"
				if dryRunStatus is "complete"
					resultStatus = "Dry Run Results: Success" #warnings are not stored so status will just be successful even if there are warnings
#					if @dataAnalysisController?
#						@dataAnalysisController.handleValidationReturnSuccess()
				else
					resultStatus = "Dry Run Results: Failed"
				resultHTML = @model.getDryRunResultHTML().get('clobValue')
				if @dataAnalysisController?
					@dataAnalysisController.parseFileUploaded = true
					@dataAnalysisController.filePassedValidation = true
					@dataAnalysisController.showFileUploadPhase()
					@dataAnalysisController.handleFormValid()

		@$('.bv_resultStatus').html(resultStatus)
		@$('.bv_htmlSummary').html(resultHTML)
#		if resultHTML == ""
#			@$('.bv_resultsContainer').hide()
#		else
#			@$('.bv_analysisResultsHTML').html(res)
#			@$('.bv_resultsContainer').show()

	setExperimentNotSaved: ->
		@$('.bv_fileUploadWrapper').hide()
		@$('.bv_resultsContainer').hide()
		@$('.bv_saveExperimentToAnalyze').show()

	setExperimentSaved: =>
		@$('.bv_saveExperimentToAnalyze').hide()
		@$('.bv_fileUploadWrapper').show()

	handleExperimentSaved: =>
		@setExperimentSaved()
		unless @dataAnalysisController?
			@setupDataAnalysisController(@options.uploadAndRunControllerName)
		@model.getStatus().on 'change', @handleStatusChanged

	handleAnalysisComplete: =>
		# Results are shown analysis controller, so redundant here until experiment is reloaded, which resets analysis controller
		@$('.bv_resultsContainer').hide()
		@trigger 'analysis-completed'

	handleStatusChanged: =>
		if @dataAnalysisController != null
			if @model.isEditable()
				@dataAnalysisController.enableAll()
			else
				@dataAnalysisController.disableAll()

	setupDataAnalysisController: (dacClassName) ->
		newArgs =
			el: @$('.bv_fileUploadWrapper')
			paramsFromExperiment:	@model.getAnalysisParameters()
			analyzedPreviously: @model.getAnalysisStatus().get('stringValue')!="not started"
		@dataAnalysisController = new window[dacClassName](newArgs)
		@dataAnalysisController.setUser(window.AppLaunchParams.loginUserName)
		@dataAnalysisController.setExperimentId(@model.id)
		@dataAnalysisController.on 'analysis-completed', @handleAnalysisComplete
		@dataAnalysisController.on 'amDirty', =>
			@trigger 'amDirty'
		@dataAnalysisController.on 'amClean', =>
			@trigger 'amClean'
		@showExistingResults()


# This wraps all the tabs
class window.AbstractPrimaryScreenExperimentController extends Backbone.View
	template: _.template($("#PrimaryScreenExperimentView").html())

	initialize: ->
		if @model?
			@completeInitialization()
		else
			if window.AppLaunchParams.moduleLaunchParams?
				if window.AppLaunchParams.moduleLaunchParams.moduleName == @moduleLaunchName
					$.ajax
						type: 'GET'
						url: "/api/experiments/codename/"+window.AppLaunchParams.moduleLaunchParams.code
						dataType: 'json'
						error: (err) ->
							alert 'Could not get experiment for code in this URL, creating new one'
							@completeInitialization()
						success: (json) =>
							if json.length == 0
								alert 'Could not get experiment for code in this URL, creating new one'
							else
								#TODO Once server is upgraded to not wrap in an array, use the commented out line. It is consistent with specs and tests
#								exp = new PrimaryScreenExperiment json
								lsKind = json[0].lsKind
								if lsKind is "flipr screening assay"
									exp = new PrimaryScreenExperiment json[0]
									exp.set exp.parse(exp.attributes)
									if window.AppLaunchParams.moduleLaunchParams.copy
										@model = exp.duplicateEntity()
									else
										@model = exp
								else
									alert 'Could not get primary screen experiment for code in this URL. Creating new primary screen experiment'
							@completeInitialization()
				else
					@completeInitialization()
			else
				@completeInitialization()

	completeInitialization: =>
		unless @model?
			@model = new PrimaryScreenExperiment()

		$(@el).html @template()
		@model.on 'sync', @handleExperimentSaved
		@experimentBaseController = new ExperimentBaseController
			model: @model
			el: @$('.bv_experimentBase')
			protocolFilter: @protocolFilter
			protocolKindFilter: @protocolKindFilter
		@experimentBaseController.on 'amDirty', =>
			@trigger 'amDirty'
		@experimentBaseController.on 'amClean', =>
			@trigger 'amClean'
		@analysisController = new PrimaryScreenAnalysisController
			model: @model
			el: @$('.bv_primaryScreenDataAnalysis')
			uploadAndRunControllerName: @uploadAndRunControllerName
		@analysisController.on 'amDirty', =>
			@trigger 'amDirty'
		@analysisController.on 'amClean', =>
			@trigger 'amClean'
		@analysisController.on 'warning', =>
			@showWarning()
		@analysisController.on 'dryRunRunning', =>
			@showValidateProgressBar()
		@analysisController.on 'analysisRunning', =>
			@showSaveProgressBar()
		@setupModelFitController(@modelFitControllerName)
		@analysisController.on 'analysis-completed', =>
			@modelFitController.primaryAnalysisCompleted()
		@model.on "protocol_attributes_copied", @handleProtocolAttributesCopied
		@experimentBaseController.render()
		@analysisController.render()
		@modelFitController.render()

	setupModelFitController: (modelFitControllerName) ->
		newArgs =
			model: @model
			el: @$('.bv_doseResponseAnalysis')
		@modelFitController = new window[modelFitControllerName](newArgs)
		@modelFitController.on 'amDirty', =>
			@trigger 'amDirty'
		@modelFitController.on 'amClean', =>
			@trigger 'amClean'

	handleExperimentSaved: =>
		@analysisController.render()

	handleProtocolAttributesCopied: =>
		@analysisController.render()

	showWarning: ->
		console.log "should show warning message"
		@$('a[href="#tab3"]').tab('show')
		dryRunStatus = @model.getDryRunStatus().get('codeValue')
		dryRunResult = @model.getDryRunResultHTML().get('clobValue')
		analysisStatus = @model.getAnalysisStatus().get('stringValue')
		analysisResult = @model.getAnalysisResultHTML().get('clobValue')
		console.log dryRunStatus
		console.log analysisStatus
		@$('.bv_dryRunStatus').html("Dry Run Status: "+dryRunStatus)
		@$('.bv_dryRunResult').html("Dry Run Result HTML: "+dryRunResult)
		@$('.bv_analysisStatus').html("Analysis Status: "+analysisStatus)
		@$('.bv_analysisResult').html("Analysis Result HTML: "+analysisResult)
		@$('.bv_invalidAnalysisStates').modal
			backdrop: "static"
		@$('.bv_invalidAnalysisStates').modal("show")
		@$('.bv_fileUploadWrapper .bv_fileUploadWrapper').hide()
		@$('.bv_fileUploadWrapper .bv_flowControl').hide()



	showValidateProgressBar: ->
		console.log "should show validate progress bar"
		@$('a[href="#tab3"]').tab('show')
		@$('.bv_validateStatusDropDown').modal
			backdrop: "static"
		@$('.bv_validateStatusDropDown').modal("show")

	showSaveProgressBar: ->
		console.log "should show save progress bar"
		@$('a[href="#tab3"]').tab('show')
		@$('.bv_saveStatusDropDown').modal
			backdrop: "static"
		@$('.bv_saveStatusDropDown').modal("show")

class window.PrimaryScreenExperimentController extends AbstractPrimaryScreenExperimentController
	uploadAndRunControllerName: "UploadAndRunPrimaryAnalsysisController"
	modelFitControllerName: "DoseResponseAnalysisController"
	protocolFilter: "?protocolName=FLIPR"
	protocolKindFilter: "?protocolKind=flipr screening assay"
	moduleLaunchName: "flipr_screening_assay"









class window.AbstractFormController extends Backbone.View
# Your initialization function needs at least these lines:
# 	initialize: ->
# 		@errorOwnerName = 'MyControllerName'
#   	@setBindings()

	show: ->
		$(@el).show()

	hide: ->
		$(@el).hide()

	cancel: ->
		@clearValidationErrorStyles()
		@hide()

	setModel: (model) ->
		@model = model
		@setBindings()
		@render()

	attributeChanged: =>
		@trigger 'amDirty'
		@updateModel()

	setBindings: ->
		@model.on 'invalid', @validationError
		@model.on 'change', @handleModelChange

	validationError: =>
		errors = @model.validationError
		@clearValidationErrorStyles()
		_.each errors, (err) =>
			@$('.bv_group_'+err.attribute).addClass 'input_error error'
			@trigger 'notifyError',  owner: this.errorOwnerName, errorLevel: 'error', message: err.message
		@trigger 'invalid'

	clearValidationErrorStyles: =>
		errorElms = @$('.input_error')
		@trigger 'clearErrors', @errorOwnerName
		_.each errorElms, (ee) =>
			$(ee).removeClass 'input_error error'

	isValid: ->
		@model.isValid()

	handleModelChange: =>
		@clearValidationErrorStyles()
		if @isValid()
			@trigger 'valid'
		else
			@trigger 'invalid'

	getTrimmedInput: (selector) ->
		$.trim(@$(selector).val())

	convertYMDDateToMs: (inStr) ->
		dateParts = inStr.split('-')
		new Date(dateParts[0], dateParts[1]-1, dateParts[2]).getTime()

	convertMSToYMDDate: (ms) ->
		date = new Date ms
		monthNum = date.getMonth()+1
		date.getFullYear()+'-'+("0" + monthNum).slice(-2)+'-'+("0" + date.getDate()).slice(-2)

	disableAllInputs: ->
		@$('input').attr 'disabled', 'disabled'
		@$('select').attr 'disabled', 'disabled'

	enableAllInputs: ->
		@$('input').removeAttr 'disabled'
		@$('select').removeAttr 'disabled'

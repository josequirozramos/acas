Backbone = require('backbone')
BackboneValidation = require('backbone-validation')
_ = require('lodash')
$ = require('jquery')

SelectList = require('./SelectList.coffee').SelectController

PLATE_INFO_CONTROLLER_EVENTS =
  DELETE_PLATE: 'deletePlate'
  CREATE_QUAD_PINNED_PLATE: 'createQuadPinnedPlate'
  MODEL_UPDATE_VALID: 'model_update_valid'
  MODEL_UPDATE_INVALID: 'model_update_INvalid'


_.extend(Backbone.Validation.callbacks, {
  valid: (view, attr, selector) ->
    $el = view.$('[name=' + attr + ']')
    $group = $el.closest('.form-group');

    $group.removeClass('has-error');
    $group.find('.help-block').html('').addClass('hidden');

  invalid: (view, attr, error, selector) ->
    $el = view.$('[name=' + attr + ']')
    $group = $el.closest('.form-group');

    $group.addClass('has-error');
    $group.find('.help-block').html(error).removeClass('hidden');

})


class PlateInfoController extends Backbone.View
  template: _.template(require('html!./PlateInfoTemplate.tmpl'))

  initialize: (options) ->
    Backbone.Validation.bind(@)
    @model = options.model
    @plateTypes = options.plateTypes
    @plateTypesSelectList = new SelectList({collection: @plateTypes, selectedValue: @model.get('type')})
    @plateStatuses = options.plateStatuses
    @plateStatusSelectList = new SelectList({collection: @plateStatuses, selectedValue: @model.get('status')})
    @selectLists = [
      controller: @plateTypesSelectList
      containerSelector: "select[name='type']"
    ,
      controller: @plateStatusSelectList
      containerSelector: "select[name='status']"
    ]

  events:
    "change input": "handleFormFieldUpdate"
    "click button[name='delete']": "handleDeleteClick"
    "click button[name='createQuadPinnedPlate']": "handleCreateQuadPinnedPlateClick"

  render: =>
    $(@el).html @template(@model.toJSON())
    @initializeSelectLists()

    @

  initializeSelectLists: =>
    _.each(@selectLists, (selectList) =>
      $(@el).find(selectList.containerSelector).html selectList.controller.render().el.childNodes
    )

  handleFormFieldUpdate: (evt) ->
    target = $(evt.currentTarget)
    data = {}
    data[target.attr('name')] = $.trim(target.val())
    @updateModel data

  handleDeleteClick: =>
    @trigger PLATE_INFO_CONTROLLER_EVENTS.DELETE_PLATE

  handleCreateQuadPinnedPlateClick: =>
    @trigger PLATE_INFO_CONTROLLER_EVENTS.CREATE_QUAD_PINNED_PLATE

  updateModel: (data) =>
    @model.set data
    if @model.isValid(true)
      @trigger PLATE_INFO_CONTROLLER_EVENTS.MODEL_UPDATE_VALID
    else
      @trigger PLATE_INFO_CONTROLLER_EVENTS.MODEL_UPDATE_INVALID

  updatePlate: (plate) =>
    @$("input[name='plateBarcode']").val plate.barcode



module.exports =
  PlateInfoController: PlateInfoController
  PLATE_INFO_CONTROLLER_EVENTS: PLATE_INFO_CONTROLLER_EVENTS
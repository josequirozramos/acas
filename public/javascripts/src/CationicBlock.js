(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.CationicBlockParent = (function(_super) {
    __extends(CationicBlockParent, _super);

    function CationicBlockParent() {
      return CationicBlockParent.__super__.constructor.apply(this, arguments);
    }

    CationicBlockParent.prototype.initialize = function() {
      this.set({
        lsType: "parent",
        lsKind: "cationic block"
      });
      return CationicBlockParent.__super__.initialize.call(this);
    };

    CationicBlockParent.prototype.lsProperties = {
      defaultLabels: [
        {
          key: 'cationic block name',
          type: 'name',
          kind: 'cationic block',
          preferred: true
        }
      ],
      defaultValues: [
        {
          key: 'completion date',
          stateType: 'metadata',
          stateKind: 'cationic block parent',
          type: 'dateValue',
          kind: 'completion date'
        }, {
          key: 'notebook',
          stateType: 'metadata',
          stateKind: 'cationic block parent',
          type: 'stringValue',
          kind: 'notebook'
        }, {
          key: 'molecular weight',
          stateType: 'metadata',
          stateKind: 'cationic block parent',
          type: 'numericValue',
          kind: 'molecular weight',
          unitType: 'molecular weight',
          unitKind: 'g/mol'
        }
      ]
    };

    CationicBlockParent.prototype.validate = function(attrs) {
      var bestName, cDate, errors, mw, nameError, notebook;
      errors = [];
      bestName = attrs.lsLabels.pickBestName();
      nameError = true;
      if (bestName != null) {
        nameError = true;
        if (bestName.get('labelText') !== "") {
          nameError = false;
        }
      }
      if (nameError) {
        errors.push({
          attribute: 'parentName',
          message: "Name must be set"
        });
      }
      if (_.isNaN(attrs.recordedDate)) {
        errors.push({
          attribute: 'recordedDate',
          message: "Recorded date must be set"
        });
      }
      if (!this.isNew()) {
        if (attrs.recordedBy === "" || attrs.recordedBy === "unassigned") {
          errors.push({
            attribute: 'recordedBy',
            message: "Scientist must be set"
          });
        }
        cDate = attrs["completion date"].get('value');
        if (cDate === void 0 || cDate === "") {
          cDate = "fred";
        }
        if (isNaN(cDate)) {
          errors.push({
            attribute: 'completionDate',
            message: "Date must be set"
          });
        }
        notebook = attrs.notebook.get('value');
        if (notebook === "" || notebook === void 0) {
          errors.push({
            attribute: 'notebook',
            message: "Notebook must be set"
          });
        }
      }
      mw = attrs["molecular weight"].get('value');
      if (mw === "" || mw === void 0 || isNaN(mw)) {
        errors.push({
          attribute: 'molecularWeight',
          message: "Molecular weight must be set"
        });
      }
      if (errors.length > 0) {
        return errors;
      } else {
        return null;
      }
    };

    return CationicBlockParent;

  })(AbstractBaseComponentParent);

  window.CationicBlockBatch = (function(_super) {
    __extends(CationicBlockBatch, _super);

    function CationicBlockBatch() {
      return CationicBlockBatch.__super__.constructor.apply(this, arguments);
    }

    CationicBlockBatch.prototype.initialize = function() {
      this.set({
        lsType: "batch",
        lsKind: "cationic block"
      });
      return CationicBlockBatch.__super__.initialize.call(this);
    };

    CationicBlockBatch.prototype.lsProperties = {
      defaultLabels: [],
      defaultValues: [
        {
          key: 'completion date',
          stateType: 'metadata',
          stateKind: 'cationic block batch',
          type: 'dateValue',
          kind: 'completion date'
        }, {
          key: 'notebook',
          stateType: 'metadata',
          stateKind: 'cationic block batch',
          type: 'stringValue',
          kind: 'notebook'
        }, {
          key: 'amount',
          stateType: 'metadata',
          stateKind: 'inventory',
          type: 'numericValue',
          kind: 'amount',
          unitType: 'mass',
          unitKind: 'g'
        }, {
          key: 'location',
          stateType: 'metadata',
          stateKind: 'inventory',
          type: 'stringValue',
          kind: 'location'
        }
      ]
    };

    return CationicBlockBatch;

  })(AbstractBaseComponentBatch);

  window.CationicBlockParentController = (function(_super) {
    __extends(CationicBlockParentController, _super);

    function CationicBlockParentController() {
      this.updateModel = __bind(this.updateModel, this);
      this.render = __bind(this.render, this);
      return CationicBlockParentController.__super__.constructor.apply(this, arguments);
    }

    CationicBlockParentController.prototype.additionalParentAttributesTemplate = _.template($("#CationicBlockParentView").html());

    CationicBlockParentController.prototype.events = function() {
      return _(CationicBlockParentController.__super__.events.call(this)).extend({
        "change .bv_molecularWeight": "attributeChanged"
      });
    };

    CationicBlockParentController.prototype.initialize = function() {
      if (this.model == null) {
        console.log("create new model in initialize");
        this.model = new CationicBlockParent();
      }
      this.errorOwnerName = 'CationicBlockParentController';
      return CationicBlockParentController.__super__.initialize.call(this);
    };

    CationicBlockParentController.prototype.render = function() {
      if (this.model == null) {
        this.model = new CationicBlockParent();
      }
      CationicBlockParentController.__super__.render.call(this);
      return this.$('.bv_molecularWeight').val(this.model.get('molecular weight').get('value'));
    };

    CationicBlockParentController.prototype.updateModel = function() {
      this.model.get("cationic block name").set("labelText", UtilityFunctions.prototype.getTrimmedInput(this.$('.bv_parentName')));
      this.model.get("molecular weight").set("value", parseFloat(UtilityFunctions.prototype.getTrimmedInput(this.$('.bv_molecularWeight'))));
      return CationicBlockParentController.__super__.updateModel.call(this);
    };

    return CationicBlockParentController;

  })(AbstractBaseComponentParentController);

  window.CationicBlockBatchController = (function(_super) {
    __extends(CationicBlockBatchController, _super);

    function CationicBlockBatchController() {
      this.render = __bind(this.render, this);
      return CationicBlockBatchController.__super__.constructor.apply(this, arguments);
    }

    CationicBlockBatchController.prototype.initialize = function() {
      if (this.model == null) {
        console.log("create new model in initialize");
        this.model = new CationicBlockBatch();
      }
      this.errorOwnerName = 'CationicBlockBatchController';
      return CationicBlockBatchController.__super__.initialize.call(this);
    };

    CationicBlockBatchController.prototype.render = function() {
      if (this.model == null) {
        console.log("create new model");
        this.model = new CationicBlockBatch();
      }
      return CationicBlockBatchController.__super__.render.call(this);
    };

    return CationicBlockBatchController;

  })(AbstractBaseComponentBatchController);

  window.CationicBlockBatchSelectController = (function(_super) {
    __extends(CationicBlockBatchSelectController, _super);

    function CationicBlockBatchSelectController() {
      this.handleSelectedBatchChanged = __bind(this.handleSelectedBatchChanged, this);
      return CationicBlockBatchSelectController.__super__.constructor.apply(this, arguments);
    }

    CationicBlockBatchSelectController.prototype.setupBatchRegForm = function(batch) {
      var model;
      if (batch != null) {
        model = batch;
      } else {
        model = new CationicBlockBatch();
      }
      this.batchController = new CationicBlockBatchController({
        model: model,
        el: this.$('.bv_batchRegForm')
      });
      return CationicBlockBatchSelectController.__super__.setupBatchRegForm.call(this);
    };

    CationicBlockBatchSelectController.prototype.handleSelectedBatchChanged = function() {
      var selectedBatch;
      console.log("handle selected batch changed");
      selectedBatch = this.batchListController.getSelectedCode();
      if (selectedBatch === "new batch" || selectedBatch === null || selectedBatch === void 0) {
        return this.setupBatchRegForm();
      } else {
        return $.ajax({
          type: 'GET',
          url: "/api/batches/codename/" + selectedBatch,
          dataType: 'json',
          error: function(err) {
            alert('Could not get selected batch, creating new one');
            return this.batchController.model = new CationicBlockBatch();
          },
          success: (function(_this) {
            return function(json) {
              var pb;
              if (json.length === 0) {
                return alert('Could not get selected batch, creating new one');
              } else {
                pb = new CationicBlockBatch(json);
                pb.set(pb.parse(pb.attributes));
                return _this.setupBatchRegForm(pb);
              }
            };
          })(this)
        });
      }
    };

    return CationicBlockBatchSelectController;

  })(AbstractBaseComponentBatchSelectController);

  window.CationicBlockController = (function(_super) {
    __extends(CationicBlockController, _super);

    function CationicBlockController() {
      this.completeInitialization = __bind(this.completeInitialization, this);
      return CationicBlockController.__super__.constructor.apply(this, arguments);
    }

    CationicBlockController.prototype.moduleLaunchName = "cationic block";

    CationicBlockController.prototype.initialize = function() {
      if (this.model != null) {
        return this.completeInitialization();
      } else {
        if (window.AppLaunchParams.moduleLaunchParams != null) {
          if (window.AppLaunchParams.moduleLaunchParams.moduleName === this.moduleLaunchName) {
            return $.ajax({
              type: 'GET',
              url: "/api/cationic blockParents/codeName/" + window.AppLaunchParams.moduleLaunchParams.code,
              dataType: 'json',
              error: function(err) {
                alert('Could not get parent for code in this URL, creating new one');
                return this.completeInitialization();
              },
              success: (function(_this) {
                return function(json) {
                  var cbp;
                  if (json.length === 0) {
                    alert('Could not get parent for code in this URL, creating new one');
                  } else {
                    cbp = new CationicBlockParent(json[0]);
                    cbp.set(cbp.parse(cbp.attributes));
                    _this.model = cbp;
                  }
                  return _this.completeInitialization();
                };
              })(this)
            });
          } else {
            return this.completeInitialization();
          }
        } else {
          return this.completeInitialization();
        }
      }
    };

    CationicBlockController.prototype.completeInitialization = function() {
      if (this.model == null) {
        this.model = new CationicBlockParent();
      }
      CationicBlockController.__super__.completeInitialization.call(this);
      return this.$('.bv_registrationTitle').html("Cationic Block Parent/Batch Registration");
    };

    CationicBlockController.prototype.setupParentController = function() {
      console.log("set up cationic block parent controller");
      console.log(this.model);
      this.parentController = new CationicBlockParentController({
        model: this.model,
        el: this.$('.bv_parent')
      });
      return CationicBlockController.__super__.setupParentController.call(this);
    };

    CationicBlockController.prototype.setupBatchSelectController = function() {
      this.batchSelectController = new CationicBlockBatchSelectController({
        el: this.$('.bv_batch'),
        parentCodeName: this.model.get('codeName')
      });
      return CationicBlockController.__super__.setupBatchSelectController.call(this);
    };

    return CationicBlockController;

  })(AbstractBaseComponentController);

}).call(this);

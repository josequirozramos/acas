(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Thing = (function(_super) {
    __extends(Thing, _super);

    function Thing() {
      this.createDefaultStates = __bind(this.createDefaultStates, this);
      this.createDefaultLabels = __bind(this.createDefaultLabels, this);
      this.sync = __bind(this.sync, this);
      this.parse = __bind(this.parse, this);
      this.defaults = __bind(this.defaults, this);
      return Thing.__super__.constructor.apply(this, arguments);
    }

    Thing.prototype.lsProperties = {};

    Thing.prototype.defaults = function() {
      this.set({
        urlRoot: "/api/cationicBlockParents"
      });
      this.set({
        lsType: "thing"
      });
      this.set({
        lsKind: "thing"
      });
      this.set({
        corpName: ""
      });
      this.set({
        recordedBy: ""
      });
      this.set({
        recordedDate: new Date().getTime()
      });
      this.set({
        shortDescription: " "
      });
      this.set({
        lsLabels: new LabelList()
      });
      this.set({
        lsStates: new StateList()
      });
      return this.set({
        urlRoot: "/api/cationicBlockParents"
      });
    };

    Thing.prototype.initialize = function() {
      console.log("initialize");
      console.log(this);
      return this.set(this.parse(this.attributes));
    };

    Thing.prototype.parse = function(resp) {
      console.log("parse");
      if (resp != null) {
        if (resp.lsLabels != null) {
          console.log("passed resp.labels?");
          if (!(resp.lsLabels instanceof LabelList)) {
            resp.lsLabels = new LabelList(resp.lsLabels);
          }
          resp.lsLabels.on('change', (function(_this) {
            return function() {
              return _this.trigger('change');
            };
          })(this));
        }
        if (resp.lsStates != null) {
          console.log("lsStates exists");
          console.log(resp.lsStates);
          if (!(resp.lsStates instanceof StateList)) {
            console.log("resp.lsStates = new StateList");
            resp.lsStates = new StateList(resp.lsStates);
            console.log("new resp.lsStates");
            console.log(resp.lsStates);
          }
          resp.lsStates.on('change', (function(_this) {
            return function() {
              return _this.trigger('change');
            };
          })(this));
        }
      }
      this.createDefaultLabels();
      return this.createDefaultStates();
    };

    Thing.prototype.sync = function() {
      var dLabel, dValue, _i, _j, _len, _len1, _ref, _ref1;
      console.log("sync in thing");
      console.log(this);
      _ref = this.lsProperties.defaultLabels;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        dLabel = _ref[_i];
        this.unset(dLabel.key);
      }
      _ref1 = this.lsProperties.defaultValues;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        dValue = _ref1[_j];
        this.unset(dValue.key);
      }
      console.log(this);
      Backbone.Model.prototype.sync.call(this);
      return console.log('done syncing');
    };

    Thing.prototype.createDefaultLabels = function() {
      var dLabel, newLabel, _i, _len, _ref;
      _ref = this.lsProperties.defaultLabels;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        dLabel = _ref[_i];
        newLabel = this.get('lsLabels').getOrCreateLabelByTypeAndKind(dLabel.type, dLabel.kind);
        this.set(dLabel.key, newLabel);
        newLabel.set({
          preferred: dLabel.preferred
        });
      }
      console.log("created default labels");
      return console.log(this);
    };

    Thing.prototype.createDefaultStates = function() {
      var dValue, newValue, _i, _len, _ref, _results;
      console.log("creating default states function");
      _ref = this.lsProperties.defaultValues;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        dValue = _ref[_i];
        newValue = this.get('lsStates').getOrCreateValueByTypeAndKind(dValue.stateType, dValue.stateKind, dValue.type, dValue.kind);
        if (dValue.unitKind != null) {
          newValue.set({
            unitKind: dValue.unitKind
          });
        }
        if (dValue.unitType != null) {
          newValue.set({
            unitType: dValue.unitType
          });
        }
        if (dValue.codeKind != null) {
          newValue.set({
            codeKind: dValue.codeKind
          });
        }
        if (dValue.codeType != null) {
          newValue.set({
            codeType: dValue.codeType
          });
        }
        this.set(dValue.key, newValue);
        _results.push(this.get(dValue.kind).set("value", newValue.get(dValue.type)));
      }
      return _results;
    };

    return Thing;

  })(Backbone.Model);

  window.BviditySiRNA = (function(_super) {
    __extends(BviditySiRNA, _super);

    function BviditySiRNA() {
      return BviditySiRNA.__super__.constructor.apply(this, arguments);
    }

    BviditySiRNA.prototype.defaultLabels = [
      {
        key: 'somename',
        type: 'name',
        kind: 'name',
        preferred: true,
        labelText: ""
      }, {
        key: 'somecorpName',
        type: 'name',
        kind: 'corpName',
        preferred: false,
        labelText: ""
      }, {
        key: 'somebarcode',
        type: 'barcode',
        kind: 'barcode',
        preferred: false,
        labelText: ""
      }
    ];

    BviditySiRNA.prototype.defaultValues = [
      {
        key: 'sequenceValue',
        stateType: 'descriptors',
        stateKind: 'unique attributes',
        type: 'stringValue',
        kind: 'sequence',
        value: ""
      }, {
        key: 'massValue',
        stateType: 'descriptors',
        stateKind: 'other attributes',
        type: 'numberValue',
        kind: 'mass',
        units: 'mg',
        value: 42.34
      }, {
        key: 'analysisParameters',
        stateType: 'meta',
        stateKind: 'experoiment meta',
        type: 'compositeObkectClob',
        kind: 'AnalysisParameters'
      }
    ];

    BviditySiRNA.prototype.defaultValueArrays = [
      {
        key: 'temperatureValueArray',
        stateType: 'measurements',
        stateKind: 'stateVsTime',
        type: 'numberValue',
        kind: 'temperature',
        units: 'C',
        value: null
      }, {
        key: 'timeValueArray',
        stateType: 'measurements',
        stateKind: 'stateVsTime',
        type: 'dateValue',
        kind: 'time',
        value: null
      }
    ];

    BviditySiRNA.prototype.defaults = function() {
      var attrs;
      attrs = BviditySiRNA.__super__.defaults.call(this);
      attrs.shortDescription = "awesome";
      return attrs;
    };

    BviditySiRNA.prototype.someMethod = function() {
      this.get('corpName').set({
        labelText: "fred"
      });
      this.set({
        coprpName: "don't do this"
      });
      return this.get('massValue').set({
        value: 42.0
      });
    };

    return BviditySiRNA;

  })(Thing);

}).call(this);
(function() {
  beforeEach(function() {
    return this.fixture = $.clone($("#fixture").get(0));
  });

  afterEach(function() {
    $("#fixture").remove();
    return $("body").append($(this.fixture));
  });

  describe("Dose Response Analysis Module Testing", function() {
    describe("Dose Response Analysis Parameter model testing", function() {
      describe("When loaded from new", function() {
        beforeEach(function() {
          return this.drap = new DoseResponseAnalysisParameters();
        });
        return describe("Existence and Defaults", function() {
          it("should be defined", function() {
            return expect(this.drap).toBeDefined();
          });
          return it("should have defaults", function() {
            expect(this.drap.get('inactiveThreshold')).toEqual(20);
            expect(this.drap.get('inverseAgonistMode')).toBeFalsy;
            expect(this.drap.get('max') instanceof Backbone.Model).toBeTruthy();
            expect(this.drap.get('min') instanceof Backbone.Model).toBeTruthy();
            return expect(this.drap.get('slope') instanceof Backbone.Model).toBeTruthy();
          });
        });
      });
      describe("model composite class tests", function() {
        beforeEach(function() {
          return this.drap = new DoseResponseAnalysisParameters(window.CurveFitTestJSON.doseResponseSimpleBulkFitOptions);
        });
        return it("should set objects to backbone models after they have been loaded", function() {
          expect(this.drap.get('max') instanceof Backbone.Model).toBeTruthy();
          expect(this.drap.get('min') instanceof Backbone.Model).toBeTruthy();
          return expect(this.drap.get('slope') instanceof Backbone.Model).toBeTruthy();
        });
      });
      return describe("model validation tests", function() {
        beforeEach(function() {
          return this.drap = new DoseResponseAnalysisParameters(window.CurveFitTestJSON.doseResponseSimpleBulkFitOptions);
        });
        it("should be valid as initialized", function() {
          return expect(this.drap.isValid()).toBeTruthy();
        });
        it("should be invalid when min limitType is pin and the value is not a number", function() {
          var filtErrors;
          this.drap.get('min').set({
            limitType: "pin"
          });
          this.drap.get('min').set({
            value: NaN
          });
          expect(this.drap.isValid()).toBeFalsy();
          filtErrors = _.filter(this.drap.validationError, function(err) {
            return err.attribute === 'min_value';
          });
          return expect(filtErrors.length).toBeGreaterThan(0);
        });
        it("should be invalid when min limitType is limit and the value is not a number", function() {
          var filtErrors;
          this.drap.get('min').set({
            limitType: "limit"
          });
          this.drap.get('min').set({
            value: NaN
          });
          expect(this.drap.isValid()).toBeFalsy();
          filtErrors = _.filter(this.drap.validationError, function(err) {
            return err.attribute === 'min_value';
          });
          return expect(filtErrors.length).toBeGreaterThan(0);
        });
        it("should be invalid when max limitType is pin and the value is not a number", function() {
          var filtErrors;
          this.drap.get('max').set({
            limitType: "pin"
          });
          this.drap.get('max').set({
            value: NaN
          });
          expect(this.drap.isValid()).toBeFalsy();
          filtErrors = _.filter(this.drap.validationError, function(err) {
            return err.attribute === 'max_value';
          });
          return expect(filtErrors.length).toBeGreaterThan(0);
        });
        it("should be invalid when max limitType is limit and the value is not a number", function() {
          var filtErrors;
          this.drap.get('max').set({
            limitType: "limit"
          });
          this.drap.get('max').set({
            value: NaN
          });
          expect(this.drap.isValid()).toBeFalsy();
          filtErrors = _.filter(this.drap.validationError, function(err) {
            return err.attribute === 'max_value';
          });
          return expect(filtErrors.length).toBeGreaterThan(0);
        });
        it("should be invalid when slope limitType is pin and the value is not a number", function() {
          var filtErrors;
          this.drap.get('slope').set({
            limitType: "pin"
          });
          this.drap.get('slope').set({
            value: NaN
          });
          expect(this.drap.isValid()).toBeFalsy();
          filtErrors = _.filter(this.drap.validationError, function(err) {
            return err.attribute === 'slope_value';
          });
          return expect(filtErrors.length).toBeGreaterThan(0);
        });
        it("should be invalid when slope limitType is limit and the value is not a number", function() {
          var filtErrors;
          this.drap.get('slope').set({
            limitType: "limit"
          });
          this.drap.get('slope').set({
            value: NaN
          });
          expect(this.drap.isValid()).toBeFalsy();
          filtErrors = _.filter(this.drap.validationError, function(err) {
            return err.attribute === 'slope_value';
          });
          return expect(filtErrors.length).toBeGreaterThan(0);
        });
        return it("should be invalid when inactiveThreshold is not a number", function() {
          var filtErrors;
          this.drap.set({
            inactiveThreshold: NaN
          });
          expect(this.drap.isValid()).toBeFalsy();
          filtErrors = _.filter(this.drap.validationError, function(err) {
            return err.attribute === 'inactiveThreshold';
          });
          return expect(filtErrors.length).toBeGreaterThan(0);
        });
      });
    });
    return describe('DoseResponseAnalysisParameters Controller', function() {
      return describe('when instantiated', function() {
        beforeEach(function() {
          this.drapc = new DoseResponseAnalysisParametersController({
            model: new DoseResponseAnalysisParameters(window.CurveFitTestJSON.doseResponseSimpleBulkFitOptions),
            el: $('#fixture')
          });
          return this.drapc.render();
        });
        describe("basic existance tests", function() {
          it('should exist', function() {
            return expect(this.drapc).toBeDefined();
          });
          it('should load autofill template', function() {
            return expect(this.drapc.$('.bv_autofillSection').length).toEqual(1);
          });
          return it('should load a template', function() {
            return expect(this.drapc.$('.bv_inverseAgonistMode').length).toEqual(1);
          });
        });
        describe("render existing parameters", function() {
          it('should show the inverse agonist mode', function() {
            return expect(this.drapc.$('.bv_inverseAgonistMode').attr('checked')).toEqual('checked');
          });
          it('should start with max_limitType radio set', function() {
            return expect(this.drapc.$("input[name='bv_max_limitType']:checked").val()).toEqual('pin');
          });
          it('should start with min_limitType radio set', function() {
            return expect(this.drapc.$("input[name='bv_min_limitType']:checked").val()).toEqual('none');
          });
          it('should start with slope_limitType radio set', function() {
            return expect(this.drapc.$("input[name='bv_slope_limitType']:checked").val()).toEqual('limit');
          });
          it('should set the max_value to the number', function() {
            return expect(this.drapc.$(".bv_max_value").val()).toEqual("100");
          });
          it('should set the min_value to the number', function() {
            return expect(this.drapc.$(".bv_min_value").val()).toEqual("");
          });
          return it('should set the slope_value to the number', function() {
            return expect(this.drapc.$(".bv_slope_value").val()).toEqual("1.5");
          });
        });
        describe("model update", function() {
          it('should update the inverse agonist mode', function() {
            expect(this.drapc.model.get('inverseAgonistMode')).toBeTruthy();
            this.drapc.$('.bv_inverseAgonistMode').click();
            return expect(this.drapc.model.get('inverseAgonistMode')).toBeFalsy();
          });
          it('should update the max_limitType radio to none', function() {
            this.drapc.$(".bv_max_limitType_none").click();
            return expect(this.drapc.model.get('max').get('limitType')).toEqual('none');
          });
          it('should update the max_limitType radio to pin', function() {
            this.drapc.$(".bv_max_limitType_pin").click();
            return expect(this.drapc.model.get('max').get('limitType')).toEqual('pin');
          });
          it('should update the max_limitType radio to limit', function() {
            this.drapc.$(".bv_max_limitType_limit").click();
            return expect(this.drapc.model.get('max').get('limitType')).toEqual('limit');
          });
          it('should update the min_limitType radio to none', function() {
            this.drapc.model.get('min').set({
              limitType: 'pin'
            });
            this.drapc.$(".bv_min_limitType_none").click();
            return expect(this.drapc.model.get('min').get('limitType')).toEqual('none');
          });
          it('should update the min_limitType radio to pin', function() {
            this.drapc.$(".bv_min_limitType_pin").click();
            return expect(this.drapc.model.get('min').get('limitType')).toEqual('pin');
          });
          it('should update the min_limitType radio to limit', function() {
            this.drapc.$(".bv_min_limitType_limit").click();
            return expect(this.drapc.model.get('min').get('limitType')).toEqual('limit');
          });
          it('should update the slope_limitType radio to none', function() {
            this.drapc.$(".bv_slope_limitType_none").click();
            return expect(this.drapc.model.get('slope').get('limitType')).toEqual('none');
          });
          it('should update the slope_limitType radio to pin', function() {
            this.drapc.$(".bv_slope_limitType_pin").click();
            return expect(this.drapc.model.get('slope').get('limitType')).toEqual('pin');
          });
          it('should update the slope_limitType radio to limit', function() {
            this.drapc.model.get('slope').set({
              limitType: 'pin'
            });
            this.drapc.$(".bv_slope_limitType_limit").click();
            return expect(this.drapc.model.get('slope').get('limitType')).toEqual('limit');
          });
          it('should update the max_value', function() {
            this.drapc.$('.bv_max_value').val(" 7.5 ");
            this.drapc.$('.bv_max_value').change();
            return expect(this.drapc.model.get('max').get('value')).toEqual(7.5);
          });
          it('should update the min_value', function() {
            this.drapc.$('.bv_min_value').val(" 22.3 ");
            this.drapc.$('.bv_min_value').change();
            return expect(this.drapc.model.get('min').get('value')).toEqual(22.3);
          });
          it('should update the slope_value', function() {
            this.drapc.$('.bv_slope_value').val(" 16.5 ");
            this.drapc.$('.bv_slope_value').change();
            return expect(this.drapc.model.get('slope').get('value')).toEqual(16.5);
          });
          it('should update the inactiveThreshold', function() {
            this.drapc.$('.bv_inactiveTreshold').val(" 30 ");
            this.drapc.$('.bv_inactiveTreshold').change();
            return expect(this.drapc.model.get('inactiveThreshold').get('value')).toEqual(30);
          });
          return describe("behavior and validation", function() {});
        });
        return describe("validation testing", function() {
          return describe("error notification", function() {
            it("should show error if max_limitType is set to pin and max_value is not set", function() {
              this.drapc.model.get('max').set({
                limitType: 'pin'
              });
              this.drapc.$('.bv_max_value').val("");
              this.drapc.$('.bv_max_value').change();
              return expect(this.drapc.$('.bv_group_max_value').hasClass("error")).toBeTruthy();
            });
            it("should show error if max_limitType is set to limit and max_value is not set", function() {
              this.drapc.model.get('max').set({
                limitType: 'limit'
              });
              this.drapc.$('.bv_max_value').val("");
              this.drapc.$('.bv_max_value').change();
              return expect(this.drapc.$('.bv_group_max_value').hasClass("error")).toBeTruthy();
            });
            it("should show error if min_limitType is set to pin and min_value is not set", function() {
              this.drapc.model.get('min').set({
                limitType: 'pin'
              });
              this.drapc.$('.bv_min_value').val("");
              this.drapc.$('.bv_min_value').change();
              return expect(this.drapc.$('.bv_group_min_value').hasClass("error")).toBeTruthy();
            });
            it("should show error if min_limitType is set to limit and min_value is not set", function() {
              this.drapc.model.get('min').set({
                limitType: 'limit'
              });
              this.drapc.$('.bv_min_value').val("");
              this.drapc.$('.bv_min_value').change();
              return expect(this.drapc.$('.bv_group_min_value').hasClass("error")).toBeTruthy();
            });
            it("should show error if slope_limitType is set to pin and slope_value is not set", function() {
              this.drapc.model.get('slope').set({
                limitType: 'pin'
              });
              this.drapc.$('.bv_slope_value').val("");
              this.drapc.$('.bv_slope_value').change();
              return expect(this.drapc.$('.bv_group_slope_value').hasClass("error")).toBeTruthy();
            });
            return it("should show error if slope_limitType is set to limit and slope_value is not set", function() {
              this.drapc.model.get('slope').set({
                limitType: 'limit'
              });
              this.drapc.$('.bv_slope_value').val("");
              this.drapc.$('.bv_slope_value').change();
              return expect(this.drapc.$('.bv_group_slope_value').hasClass("error")).toBeTruthy();
            });
          });
        });
      });
    });
  });

}).call(this);

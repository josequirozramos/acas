(function() {
  beforeEach(function() {
    return this.fixture = $.clone($("#fixture").get(0));
  });

  afterEach(function() {
    $("#fixture").remove();
    return $("body").append($(this.fixture));
  });

  describe("Label module testing", function() {
    describe("Label model test", function() {
      beforeEach(function() {
        return this.el = new Label();
      });
      return describe("Basic new label", function() {
        it("Class should exist", function() {
          return expect(this.el).toBeDefined();
        });
        return it("should have defaults", function() {
          expect(this.el.get('lsType')).toEqual('name');
          expect(this.el.get('lsKind')).toEqual('');
          expect(this.el.get('labelText')).toEqual('');
          expect(this.el.get('ignored')).toEqual(false);
          expect(this.el.get('preferred')).toEqual(false);
          expect(this.el.get('recordedBy')).toEqual('');
          expect(this.el.get('recordedDate')).toBeNull();
          expect(this.el.get('physicallyLabled')).toEqual(false);
          return expect(this.el.get('imageFile')).toBeNull();
        });
      });
    });
    describe("Label List testing", function() {
      describe("label list features when loaded from existing list", function() {
        beforeEach(function() {
          return this.ell = new LabelList(window.experimentServiceTestJSON.experimentLabels);
        });
        it("Class should exist", function() {
          return expect(this.ell).toBeDefined();
        });
        it("Class should have labels", function() {
          return expect(this.ell.length).toEqual(4);
        });
        it("Should return current (not ignored) labels", function() {
          return expect(this.ell.getCurrent().length).toEqual(3);
        });
        it("Should return not ignored name labels", function() {
          return expect(this.ell.getNames().length).toEqual(2);
        });
        it("Should return not ignored preferred labels", function() {
          return expect(this.ell.getPreferred().length).toEqual(1);
        });
        describe("best label picker", function() {
          it("Should select newest preferred label when there are preferred labels", function() {
            return expect(this.ell.pickBestLabel().get('labelText')).toEqual("FLIPR target A biochemical");
          });
          it("Should select newest name when there are no preferred labels but there are names", function() {
            this.ell2 = new LabelList(window.experimentServiceTestJSON.experimentLabelsNoPreferred);
            return expect(this.ell2.pickBestLabel().get('labelText')).toEqual("FLIPR target A biochemical with additional name awesomness");
          });
          return it("Should select newest label when there are no preferred labels and no names", function() {
            this.ell2 = new LabelList(window.experimentServiceTestJSON.experimentLabelsNoPreferredNoNames);
            return expect(this.ell2.pickBestLabel().get('labelText')).toEqual("AAABBD13343434");
          });
        });
        describe("best name picker", function() {
          return it("Should select newest preferred name label", function() {
            return expect(this.ell.pickBestName().get('labelText')).toEqual("FLIPR target A biochemical");
          });
        });
        return describe("setBestName functionality", function() {
          return it("should update existing unsaved label when best name changed", function() {
            var oldBestId;
            oldBestId = this.ell.pickBestLabel().id;
            this.ell.setBestName(new Label({
              labelText: "new best name",
              recordedBy: "fmcneil",
              recordedDate: 3362435677000
            }));
            expect(this.ell.pickBestLabel().get('labelText')).toEqual("new best name");
            expect(this.ell.pickBestLabel().isNew).toBeTruthy();
            return expect(this.ell.get(oldBestId).get('ignored')).toBeTruthy();
          });
        });
      });
      return describe("label list features when new and empty", function() {
        beforeEach(function() {
          return this.ell = new LabelList();
        });
        it("Class should have labels", function() {
          return expect(this.ell.length).toEqual(0);
        });
        return describe("setBestName functionality", function() {
          beforeEach(function() {
            return this.ell.setBestName(new Label({
              labelText: "best name",
              recordedBy: "jmcneil",
              recordedDate: 2362435677000
            }));
          });
          it("should add new label when best name added for first time", function() {
            expect(this.ell.pickBestLabel().get('labelText')).toEqual("best name");
            expect(this.ell.pickBestLabel().get('recordedBy')).toEqual("jmcneil");
            return expect(this.ell.pickBestLabel().get('recordedDate')).toEqual(2362435677000);
          });
          return it("should update existing unsaved label when best name changed", function() {
            this.ell.setBestName(new Label({
              labelText: "new best name",
              recordedBy: "fmcneil",
              recordedDate: 3362435677000
            }));
            expect(this.ell.length).toEqual(1);
            expect(this.ell.pickBestLabel().get('labelText')).toEqual("new best name");
            expect(this.ell.pickBestLabel().get('recordedBy')).toEqual("fmcneil");
            return expect(this.ell.pickBestLabel().get('recordedDate')).toEqual(3362435677000);
          });
        });
      });
    });
    describe("Value model testing", function() {
      beforeEach(function() {
        return this.val = new Value();
      });
      it("Class should exist", function() {
        return expect(this.val).toBeDefined();
      });
      return it("Should have defaults", function() {
        expect(this.val.get('recordedDate')).toBeNull();
        expect(this.val.get('recordedBy')).toEqual("");
        return expect(this.val.get('ignored')).toEqual(false);
      });
    });
    describe("Value list testing", function() {
      beforeEach(function() {
        return this.vl = new ValueList();
      });
      return describe("basic existance tests", function() {
        return it("Class should exist", function() {
          return expect(this.vl).toBeDefined();
        });
      });
    });
    describe("State model testing", function() {
      describe("when created empty", function() {
        beforeEach(function() {
          return this.es = new State();
        });
        return describe("basic existance tests", function() {
          it("Class should exist", function() {
            return expect(this.es).toBeDefined();
          });
          return it("should have defaults", function() {
            expect(this.es.get('lsValues') instanceof Backbone.Collection).toBeTruthy();
            expect(this.es.get('recordedDate')).toBeNull();
            expect(this.es.get('recordedBy')).toEqual("");
            return expect(this.es.get('ignored')).toEqual(false);
          });
        });
      });
      return describe("When loaded from state json", function() {
        beforeEach(function() {
          return this.es = new State(window.experimentServiceTestJSON.fullExperimentFromServer.lsStates[0]);
        });
        return describe("after initial load", function() {
          it("state should have kind ", function() {
            return expect(this.es.get('lsKind')).toEqual(window.experimentServiceTestJSON.fullExperimentFromServer.lsStates[0].lsKind);
          });
          it("state should have values", function() {
            return expect(this.es.get('lsValues').length).toEqual(window.experimentServiceTestJSON.fullExperimentFromServer.lsStates[0].lsValues.length);
          });
          it("state should have populated value", function() {
            return expect(this.es.get('lsValues').at(0).get('lsKind')).toEqual("control type");
          });
          it("should return requested value", function() {
            var values;
            values = this.es.getValuesByTypeAndKind("stringValue", "control type");
            expect(values.length).toEqual(1);
            return expect(values[0].get('stringValue')).toEqual("negative control");
          });
          return it("should trigger change when value changed in state", function() {
            runs(function() {
              var _this = this;
              this.stateChanged = false;
              this.es.on('change', function() {
                return _this.stateChanged = true;
              });
              return this.es.get('lsValues').at(0).set({
                valueKind: 'newkind'
              });
            });
            waitsFor(function() {
              return this.stateChanged;
            }, 500);
            return runs(function() {
              return expect(this.stateChanged).toBeTruthy();
            });
          });
        });
      });
    });
    return describe("State List model testing", function() {
      describe("when loaded from existing", function() {
        beforeEach(function() {
          return this.esl = new StateList(window.experimentServiceTestJSON.fullExperimentFromServer.lsStates);
        });
        describe("after initial load with test data", function() {
          it("Class should exist", function() {
            return expect(this.esl).toBeDefined();
          });
          it("should have states ", function() {
            return expect(this.esl.length).toEqual(window.experimentServiceTestJSON.fullExperimentFromServer.lsStates.length);
          });
          it("first state should have kind ", function() {
            return expect(this.esl.at(0).get('lsKind')).toEqual(window.experimentServiceTestJSON.fullExperimentFromServer.lsStates[0].lsKind);
          });
          it("states should have values", function() {
            return expect(this.esl.at(0).get('lsValues').length).toEqual(window.experimentServiceTestJSON.fullExperimentFromServer.lsStates[0].lsValues.length);
          });
          return it("first state should have populated value", function() {
            return expect(this.esl.at(0).get('lsValues').at(0).get('lsKind')).toEqual("control type");
          });
        });
        describe("Get states by type and kind", function() {
          return it("should return requested state", function() {
            var values;
            values = this.esl.getStatesByTypeAndKind("metadata", "experiment metadata");
            expect(values.length).toEqual(1);
            return expect(values[0].get('lsTypeAndKind')).toEqual("metadata_experiment metadata");
          });
        });
        describe("Get value by type and kind", function() {
          return it("should return requested value", function() {
            var value;
            value = this.esl.getStateValueByTypeAndKind("metadata", "experiment metadata", "stringValue", "notebook");
            return expect(value.get('stringValue')).toEqual("911");
          });
        });
        return describe("get or create a state or value", function() {
          it("should return an existing state", function() {
            var st;
            st = this.esl.getOrCreateStateByTypeAndKind("metadata", "experiment metadata");
            return expect(st.get('lsType')).toEqual("metadata");
          });
          return it("return an existing value", function() {
            var val;
            val = this.esl.getOrCreateValueByTypeAndKind("metadata", "experiment metadata", "stringValue", "notebook");
            return expect(val.get('stringValue')).toEqual("911");
          });
        });
      });
      return describe("when created empty", function() {
        beforeEach(function() {
          return this.esl = new StateList();
        });
        return describe("get or create a state or value", function() {
          it("should create a new state if a specific one is requested that doesn't exist", function() {
            expect(this.esl.getStatesByTypeAndKind("stateType", "stateKind").length).toEqual(0);
            this.esl.getOrCreateStateByTypeAndKind("stateType", "stateKind");
            return expect(this.esl.getStatesByTypeAndKind("stateType", "stateKind").length).toEqual(1);
          });
          return it("should create a new state and value if a specific value is requested that doesn't exist", function() {
            expect(this.esl.getStatesByTypeAndKind("stateType", "stateKind").length).toEqual(0);
            expect(this.esl.getStateValueByTypeAndKind("stateType", "stateKind", "valType", "valKind")).toBeNull;
            this.esl.getOrCreateValueByTypeAndKind("stateType", "stateKind", "valType", "valKind");
            expect(this.esl.getStatesByTypeAndKind("stateType", "stateKind").length).toEqual(1);
            return expect(this.esl.getStateValueByTypeAndKind("stateType", "stateKind", "valType", "valKind").get('lsKind')).toEqual("valKind");
          });
        });
      });
    });
  });

}).call(this);

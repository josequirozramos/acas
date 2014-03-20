
/*
This service takes a list of geneids and returns related experimental data,
 */

(function() {
  var advnacedReturnExampleSuccess, badDataRequest, basicReturnExampleError, basicReturnExampleSuccess, goodDataRequest;

  goodDataRequest = {
    geneIDs: "1234, 2345, 4444",
    maxRowsToReturn: 10000,
    user: 'jmcneil'
  };

  badDataRequest = {
    geneIDs: "1234, 2345, 4444",
    maxRowsToReturn: -1,
    user: 'jmcneil'
  };

  basicReturnExampleSuccess = {
    results: window.geneDataQueriesTestJSON.geneIDQueryResults,
    hasError: false,
    hasWarning: true,
    errorMessages: []
  };

  goodDataRequest = {
    geneIDs: "1234, 2345, 4444"
  };

  advnacedReturnExampleSuccess = {
    results: window.geneDataQueriesTestJSON.getGeneExperimentsReturn,
    hasError: false,
    hasWarning: false,
    errorMessages: []
  };

  advnacedReturnExampleSuccess = {
    results: window.geneDataQueriesTestJSON.getGeneExperimentsNoResultsReturn,
    hasError: false,
    hasWarning: false,
    errorMessages: []
  };

  basicReturnExampleError = {
    results: {
      htmlSummary: "Error: There is a problem in this request...",
      data: null
    },
    hasError: true,
    hasWarning: true,
    errorMessages: [
      {
        errorLevel: "warning",
        message: "some genes not found"
      }, {
        errorLevel: "error",
        message: "start offset outside allowed range, please speak to an administrator"
      }
    ]
  };

  describe('Gene Data Queries Service testing', function() {
    beforeEach(function() {
      return this.waitForServiceReturn = function() {
        return typeof this.serviceReturn !== 'undefined';
      };
    });
    describe("basic gene data query", function() {
      describe('when run with valid input data', function() {
        beforeEach(function() {
          return runs(function() {
            return $.ajax({
              type: 'POST',
              url: "api/geneDataQuery",
              data: goodDataRequest,
              success: (function(_this) {
                return function(json) {
                  return _this.serviceReturn = json;
                };
              })(this),
              error: (function(_this) {
                return function(err) {
                  console.log('got ajax error');
                  return _this.serviceReturn = null;
                };
              })(this),
              dataType: 'json'
            });
          });
        });
        return it('should return no errors, dry run mode, hasWarning, and an html summary', function() {
          waitsFor(this.waitForServiceReturn, 'service did not return', 10000);
          return runs(function() {
            expect(this.serviceReturn.hasError).toBeFalsy();
            expect(this.serviceReturn.results.data.aaData.length).toEqual(4);
            expect(this.serviceReturn.hasWarning).toBeDefined();
            return expect(this.serviceReturn.results.htmlSummary).toBeDefined();
          });
        });
      });
      describe('when run with no results expected', function() {
        beforeEach(function() {
          return runs(function() {
            return $.ajax({
              type: 'POST',
              url: "api/geneDataQuery",
              data: {
                geneIDs: "fiona"
              },
              success: (function(_this) {
                return function(json) {
                  return _this.serviceReturn = json;
                };
              })(this),
              error: (function(_this) {
                return function(err) {
                  console.log('got ajax error');
                  return _this.serviceReturn = null;
                };
              })(this),
              dataType: 'json'
            });
          });
        });
        return it('should return no errors, dry run mode, hasWarning, and an html summary', function() {
          waitsFor(this.waitForServiceReturn, 'service did not return', 10000);
          return runs(function() {
            expect(this.serviceReturn.hasError).toBeFalsy();
            expect(this.serviceReturn.results.data.iTotalRecords).toEqual(0);
            expect(this.serviceReturn.hasWarning).toBeDefined();
            return expect(this.serviceReturn.results.htmlSummary).toBeDefined();
          });
        });
      });
      return describe('when run with invalid input file', function() {
        beforeEach(function() {
          return runs(function() {
            return $.ajax({
              type: 'POST',
              url: "api/geneDataQuery",
              data: badDataRequest,
              success: (function(_this) {
                return function(json) {
                  return _this.serviceReturn = json;
                };
              })(this),
              error: (function(_this) {
                return function(err) {
                  console.log('got ajax error');
                  return _this.serviceReturn = null;
                };
              })(this),
              dataType: 'json'
            });
          });
        });
        return it('should return error=true, and at least one message', function() {
          waitsFor(this.waitForServiceReturn, 'service did not return', 20000);
          return runs(function() {
            expect(this.serviceReturn.results.htmlSummary).toBeDefined();
            expect(this.serviceReturn.hasError).toBeTruthy();
            expect(this.serviceReturn.errorMessages.length).toBeGreaterThan(0);
            return expect(this.serviceReturn.errorMessages[1].errorLevel).toEqual('error');
          });
        });
      });
    });
    return describe("advanced experiments for genes query", function() {
      describe('when run with valid input data', function() {
        beforeEach(function() {
          return runs(function() {
            return $.ajax({
              type: 'POST',
              url: "api/getGeneExperiments",
              data: goodDataRequest,
              success: (function(_this) {
                return function(json) {
                  return _this.serviceReturn = json;
                };
              })(this),
              error: (function(_this) {
                return function(err) {
                  console.log('got ajax error');
                  return _this.serviceReturn = null;
                };
              })(this),
              dataType: 'json'
            });
          });
        });
        return it('should return no errors, dry run mode, hasWarning, and an html summary', function() {
          waitsFor(this.waitForServiceReturn, 'service did not return', 10000);
          return runs(function() {
            expect(this.serviceReturn.hasError).toBeFalsy();
            expect(this.serviceReturn.results.experimentData[0].parent).toEqual("Root Node");
            expect(this.serviceReturn.hasWarning).toBeDefined();
            return expect(this.serviceReturn.results.htmlSummary).toBeDefined();
          });
        });
      });
      describe('when run with no results expected', function() {
        beforeEach(function() {
          return runs(function() {
            return $.ajax({
              type: 'POST',
              url: "api/getGeneExperiments",
              data: {
                geneIDs: "fiona"
              },
              success: (function(_this) {
                return function(json) {
                  return _this.serviceReturn = json;
                };
              })(this),
              error: (function(_this) {
                return function(err) {
                  console.log('got ajax error');
                  return _this.serviceReturn = null;
                };
              })(this),
              dataType: 'json'
            });
          });
        });
        return it('should return no errors, dry run mode, hasWarning, and an html summary', function() {
          waitsFor(this.waitForServiceReturn, 'service did not return', 10000);
          return runs(function() {
            expect(this.serviceReturn.hasError).toBeFalsy();
            expect(this.serviceReturn.results.experimentData.length).toEqual(0);
            expect(this.serviceReturn.hasWarning).toBeDefined();
            return expect(this.serviceReturn.results.htmlSummary).toBeDefined();
          });
        });
      });
      return describe('when run with invalid input file', function() {
        beforeEach(function() {
          return runs(function() {
            return $.ajax({
              type: 'POST',
              url: "api/getGeneExperiments",
              data: badDataRequest,
              success: (function(_this) {
                return function(json) {
                  return _this.serviceReturn = json;
                };
              })(this),
              error: (function(_this) {
                return function(err) {
                  console.log('got ajax error');
                  return _this.serviceReturn = null;
                };
              })(this),
              dataType: 'json'
            });
          });
        });
        return it('should return error=true, and at least one message', function() {
          waitsFor(this.waitForServiceReturn, 'service did not return', 20000);
          return runs(function() {
            expect(this.serviceReturn.results.htmlSummary).toBeDefined();
            expect(this.serviceReturn.hasError).toBeTruthy();
            expect(this.serviceReturn.errorMessages.length).toBeGreaterThan(0);
            return expect(this.serviceReturn.errorMessages[1].errorLevel).toEqual('error');
          });
        });
      });
    });
  });

}).call(this);

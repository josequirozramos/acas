(function() {
  exports.setupRoutes = function(app, loginRoutes) {
    var config;
    app.post('/api/geneDataQuery', exports.getExperimentDataForGenes);
    app.post('/api/getGeneExperiments', exports.getExperimentListForGenes);
    config = require('../conf/compiled/conf.js');
    if (config.all.client.require.login) {
      return app.get('/geneIDQuery', loginRoutes.ensureAuthenticated, exports.geneIDQueryIndex);
    } else {
      return app.get('/geneIDQuery', exports.geneIDQueryIndex);
    }
  };

  exports.getExperimentDataForGenes = function(req, resp) {
    var baseurl, config, geneDataQueriesTestJSON, request, requestError, responseObj, results, serverUtilityFunctions;
    req.connection.setTimeout(600000);
    serverUtilityFunctions = require('./ServerUtilityFunctions.js');
    resp.writeHead(200, {
      'Content-Type': 'application/json'
    });
    if (global.specRunnerTestmode) {
      console.log("test mode: " + global.specRunnerTestmode);
      geneDataQueriesTestJSON = require('../public/javascripts/spec/testFixtures/GeneDataQueriesTestJson.js');
      requestError = req.body.maxRowsToReturn < 0 ? true : false;
      if (req.body.geneIDs === "fiona") {
        results = geneDataQueriesTestJSON.geneIDQueryResultsNoneFound;
      } else {
        results = geneDataQueriesTestJSON.geneIDQueryResults;
      }
      responseObj = {
        results: results,
        hasError: requestError,
        hasWarning: true,
        errorMessages: [
          {
            errorLevel: "warning",
            message: "some genes not found"
          }
        ]
      };
      if (requestError) {
        responseObj.errorMessages.push({
          errorLevel: "error",
          message: "start offset outside allowed range, please speake to an administrator"
        });
      }
      return resp.end(JSON.stringify(responseObj));
    } else {
      config = require('../conf/compiled/conf.js');
      baseurl = config.all.client.service.rapache.fullpath + "getGeneData/";
      request = require('request');
      return request({
        method: 'POST',
        url: baseurl,
        body: req.body,
        json: true
      }, (function(_this) {
        return function(error, response, json) {
          console.log(response.statusCode);
          if (!error) {
            console.log(JSON.stringify(json));
            return resp.end(JSON.stringify(json));
          } else {
            console.log('got ajax error trying to query gene data');
            console.log(error);
            return console.log(resp);
          }
        };
      })(this));
    }
  };

  exports.getExperimentListForGenes = function(req, resp) {
    var geneDataQueriesTestJSON, requestError, responseObj, results, serverUtilityFunctions;
    req.connection.setTimeout(600000);
    serverUtilityFunctions = require('./ServerUtilityFunctions.js');
    resp.writeHead(200, {
      'Content-Type': 'application/json'
    });
    if (global.specRunnerTestmode) {
      console.log("test mode: " + global.specRunnerTestmode);
      geneDataQueriesTestJSON = require('../public/javascripts/spec/testFixtures/GeneDataQueriesTestJson.js');
      requestError = req.body.maxRowsToReturn < 0 ? true : false;
      if (req.body.geneIDs === "fiona") {
        results = geneDataQueriesTestJSON.getGeneExperimentsNoResultsReturn;
      } else {
        results = geneDataQueriesTestJSON.getGeneExperimentsReturn;
      }
      responseObj = {
        results: results,
        hasError: requestError,
        hasWarning: true,
        errorMessages: [
          {
            errorLevel: "warning",
            message: "some genes not found"
          }
        ]
      };
      if (requestError) {
        responseObj.errorMessages.push({
          errorLevel: "error",
          message: "start offset outside allowed range, please speake to an administrator"
        });
      }
      return resp.end(JSON.stringify(responseObj));
    } else {
      return console.log("production function getExperimentListForGenes not implemented");
    }
  };

  exports.geneIDQueryIndex = function(req, res) {
    var config, loginUser, loginUserName, scriptPaths, scriptsToLoad;
    scriptPaths = require('./RequiredClientScripts.js');
    config = require('../conf/compiled/conf.js');
    global.specRunnerTestmode = global.stubsMode ? true : false;
    scriptsToLoad = scriptPaths.requiredScripts.concat(scriptPaths.applicationScripts);
    if (config.all.client.require.login) {
      loginUserName = req.user.username;
      loginUser = req.user;
    } else {
      loginUserName = "nouser";
      loginUser = {
        id: 0,
        username: "nouser",
        email: "nouser@nowhere.com",
        firstName: "no",
        lastName: "user"
      };
    }
    return res.render('GeneIDQuery', {
      title: "Gene ID Queery",
      scripts: scriptsToLoad,
      AppLaunchParams: {
        loginUserName: loginUserName,
        loginUser: loginUser,
        testMode: false,
        moduleLaunchParams: typeof moduleLaunchParams !== "undefined" && moduleLaunchParams !== null ? moduleLaunchParams : null,
        deployMode: global.deployMode
      }
    });
  };

}).call(this);

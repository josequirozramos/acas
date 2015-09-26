(function() {
  exports.setupRoutes = function(app, loginRoutes) {
    return app.get('/api/redirectToNewLiveDesignLiveReportForExperiment/:experimentCode', loginRoutes.ensureAuthenticated, exports.redirectToNewLiveDesignLiveReportForExperiment);
  };

  exports.redirectToNewLiveDesignLiveReportForExperiment = function(req, resp) {
    var config, exec, expCode, request;
    exec = require('child_process').exec;
    config = require('../conf/compiled/conf.js');
    request = require('request');
    expCode = req.params.experimentCode;
    return request.get({
      url: config.all.client.service.rapache.fullpath + "ServerAPI/getCmpdAndResultType?experiment=" + expCode,
      json: true
    }, (function(_this) {
      return function(error, response, body) {
        var child, command, exptInfo, serverError;
        serverError = error;
        exptInfo = body;
        console.log(_this.responseJSON);
        command = "./public/src/modules/ServerAPI/src/server/createLiveDesignLiveReportForACAS/create_lr_for_acas.py -e ";
        command += "'https://mcneilco-ld-73.onschrodinger.com/livedesign' -u 'regressiontester' -p 'allthedataallthethings' -i '";
        command += (JSON.stringify(exptInfo)) + "'";
        console.log("About to call python using command: " + command);
        return child = exec(command, function(error, stdout, stderr) {
          var reportURL, reportURLPos;
          reportURLPos = stdout.indexOf("https://");
          reportURL = stdout.substr(reportURLPos);
          console.log("stderr: " + stderr);
          console.log("stdout: " + stdout);
          return resp.redirect(reportURL);
        });
      };
    })(this));
  };

}).call(this);

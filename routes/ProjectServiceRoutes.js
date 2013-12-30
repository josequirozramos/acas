/* To install this Module
1) Add these lines to app.coffee under # serverAPI routes:
#Components routes
projectServiceRoutes = require './routes/ProjectServiceRoutes.js'
app.get '/api/projects', projectServiceRoutes.getProjects
*/


(function() {
  exports.getProjects = function(req, resp) {
    var csUtilities, projectServiceTestJSON;

    csUtilities = require('../public/src/conf/CustomerSpecificServerFunctions.js');
    if (global.specRunnerTestmode) {
      projectServiceTestJSON = require('../public/javascripts/spec/testFixtures/projectServiceTestJSON.js');
      return resp.end(JSON.stringify(projectServiceTestJSON.projects));
    } else {
      return csUtilities.getProjects(resp);
    }
  };

}).call(this);

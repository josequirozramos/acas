(function() {
  var dnsAuthCheck, users;

  users = [
    {
      id: 1,
      username: "bob",
      password: "secret",
      email: "bob@example.com"
    }, {
      id: 2,
      username: "joe",
      password: "birthday",
      email: "joe@example.com"
    }, {
      id: 3,
      username: "ldap-query",
      password: "Est@P7uRi5SyR+",
      email: "sdfsdfdfsfds"
    }
  ];

  exports.findById = function(id, fn) {
    var idx;

    idx = id - 1;
    if (users[idx]) {
      return fn(null, users[idx]);
    } else {
      return fn(new Error("User " + id + " does not exist"));
    }
  };

  exports.findByUsername = function(username, fn) {
    var i, len, user;

    i = 0;
    len = users.length;
    while (i < len) {
      user = users[i];
      if (user.username === username) {
        return fn(null, user);
      }
      i++;
    }
    return fn(null, null);
  };

  exports.loginStrategy = function(username, password, done) {
    return process.nextTick(function() {
      return exports.findByUsername(username, function(err, user) {
        if (err) {
          return done(err);
        }
        if (!user) {
          return done(null, false, {
            message: "Unknown user " + username
          });
        }
        if (user.password !== password) {
          return done(null, false, {
            message: "Invalid password"
          });
        }
        return done(null, user);
      });
    });
  };

  exports.loginPage = function(req, res) {
    var error, errorMsg, user;

    user = null;
    if (req.user != null) {
      user = req.user;
    }
    errorMsg = "";
    error = req.flash('error');
    if (error.length > 0) {
      errorMsg = error[0];
    }
    return res.render('login', {
      title: "ACAS Login",
      scripts: [],
      user: user,
      message: errorMsg
    });
  };

  exports.loginPost = function(req, res) {
    return res.redirect('/');
  };

  exports.logout = function(req, res) {
    req.logout();
    return res.redirect('/');
  };

  exports.ensureAuthenticated = function(req, res, next) {
    if (req.isAuthenticated()) {
      return next();
    }
    return res.redirect('/login');
  };

  exports.authenticationService = function(req, resp) {
    var callback, config;

    config = require('../public/src/conf/configurationNode.js');
    callback = function(results) {
      if (results.indexOf("Success") >= 0) {
        return resp.json({
          status: "Success"
        });
      } else {
        return resp.json({
          status: "Fail"
        });
      }
    };
    if (global.specRunnerTestmode) {
      return callback("Success");
    } else {
      if (config.serverConfigurationParams.configuration.userAuthenticationType === "Demo") {
        return callback("Success");
      } else if (config.serverConfigurationParams.configuration.userAuthenticationType === "DNS") {
        return dnsAuthCheck(req.body.user, req.body.password, callback);
      }
    }
  };

  dnsAuthCheck = function(user, pass, retFun) {
    var config, request,
      _this = this;

    config = require('../public/src/conf/configurationNode.js');
    request = require('request');
    return request({
      method: 'POST',
      url: config.serverConfigurationParams.configuration.userAuthenticationServiceURL,
      form: {
        username: user,
        password: pass
      },
      json: true
    }, function(error, response, json) {
      if (!error && response.statusCode === 200) {
        console.log(JSON.stringify(json));
        return retFun(JSON.stringify(json));
      } else {
        console.log('got ajax error trying authenticate a user');
        console.log(error);
        console.log(json);
        return console.log(response);
      }
    });
  };

}).call(this);

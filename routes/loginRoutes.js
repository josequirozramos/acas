(function() {
  var config, csUtilities;

  exports.setupAPIRoutes = function(app) {
    return app.get('/api/users/:username', exports.getUsers);
  };

  exports.setupRoutes = function(app, passport) {
    app.get('/login', exports.loginPage);
    app.post('/login', passport.authenticate('local', {
      failureRedirect: '/login',
      failureFlash: true
    }), exports.loginPost);
    app.get('/logout', exports.logout);
    app.post('/api/userAuthentication', exports.authenticationService);
    app.get('/api/users/:username', exports.ensureAuthenticated, exports.getUsers);
    app.get('/passwordReset', exports.resetpage);
    app.post('/passwordReset', exports.resetAuthenticationService, exports.resetPost);
    app.post('/api/userResetAuthentication', exports.resetAuthenticationService);
    app.get('/passwordChange', exports.ensureAuthenticated, exports.changePage);
    app.post('/passwordChange', exports.changeAuthenticationService, exports.changePost);
    return app.post('/api/userChangeAuthentication', exports.changeAuthenticationService);
  };

  csUtilities = require('../public/src/conf/CustomerSpecificServerFunctions.js');

  config = require('../conf/compiled/conf.js');

  exports.loginPage = function(req, res) {
    var error, errorMsg, resetPasswordOption, user;
    user = null;
    if (req.user != null) {
      user = req.user;
    }
    errorMsg = "";
    error = req.flash('error');
    if (error.length > 0) {
      errorMsg = error[0];
    }
    if (config.all.server.security.authstrategy === "database") {
      resetPasswordOption = true;
    } else {
      resetPasswordOption = false;
    }
    return res.render('login', {
      title: "ACAS Login",
      scripts: [],
      user: user,
      message: errorMsg,
      resetPasswordOption: resetPasswordOption
    });
  };

  exports.resetPost = function(req, res) {
    console.log(req.session);
    return res.redirect('/passwordReset');
  };

  exports.loginPost = function(req, res) {
    console.log("got to login post");
    if (req.session.returnTo != null) {
      return res.redirect(req.session.returnTo);
    } else {
      return res.redirect('/');
    }
  };

  exports.changePost = function(req, res) {
    console.log(req.session);
    return res.redirect('/passwordChange');
  };

  exports.logout = function(req, res) {
    req.logout();
    return res.redirect('/');
  };

  exports.ensureAuthenticated = function(req, res, next) {
    console.log("checking for login for path: " + req.url);
    if (req.isAuthenticated()) {
      return next();
    }
    if (req.session != null) {
      req.session.returnTo = req.url;
    }
    return res.redirect('/login');
  };

  exports.getUsers = function(req, resp) {
    var callback;
    console.log("get users in route file");
    callback = function(err, user) {
      if (user === null) {
        return resp.send(204);
      } else {
        delete user.password;
        return resp.json(user);
      }
    };
    return csUtilities.getUser(req.params.username, callback);
  };

  exports.authenticationService = function(req, resp) {
    var callback;
    callback = function(results) {
      console.log(results);
      if (results.indexOf("Success") >= 0) {
        console.log("in authentication service success");
        return resp.json({
          status: "Success"
        });
      } else {
        console.log("in authentication service fail");
        return resp.json({
          status: "Fail"
        });
      }
    };
    if (global.specRunnerTestmode) {
      return callback("Success");
    } else {
      return csUtilities.authCheck(req.body.user, req.body.password, callback);
    }
  };

  exports.resetAuthenticationService = function(req, resp) {
    var callback;
    callback = function(results) {
      console.log(results);
      if (results.indexOf("Your new password is sent to your email address") >= 0) {
        req.flash('error', 'Your new password has been sent to your email address.');
        return resp.redirect('/passwordReset');
      } else if (results.indexOf("connection_error") >= 0) {
        req.flash('error', 'Cannot connect to authentication service. Please contact an administrator.');
        return resp.redirect('/passwordReset');
      } else {
        req.flash('error', 'Invalid Email or Username');
        return resp.redirect('/passwordReset');
      }
    };
    if (global.specRunnerTestmode) {
      return callback("Success");
    } else {
      return csUtilities.resetAuth(req.body.email, callback);
    }
  };

  exports.changeAuthenticationService = function(req, resp) {
    var callback;
    callback = function(results) {
      console.log(results);
      if (results.indexOf("You password has been successfully been changed") >= 0) {
        req.flash('error', 'Your new password is set.');
        return resp.redirect('/login');
      } else if (results.indexOf("connection_error") >= 0) {
        req.flash('error', 'Cannot connect to authentication service. Please contact an administrator.');
        return resp.redirect('/passwordChange');
      } else {
        req.flash('error', 'Invalid password or new password does not match.');
        return resp.redirect('/passwordChange');
      }
    };
    if (global.specRunnerTestmode) {
      return callback("Success");
    } else {
      return csUtilities.changeAuth(req.body.user, req.body.oldPassword, req.body.newPassword, req.body.newPasswordAgain, callback);
    }
  };

  exports.resetpage = function(req, res) {
    var error, errorMsg, user;
    user = null;
    if (req.user != null) {
      user = req.user;
    }
    console.log(req.flash);
    errorMsg = "";
    error = req.flash('error');
    if (error.length > 0) {
      errorMsg = error[0];
    }
    console.log("trying to reset pass");
    if (config.all.server.security.authstrategy === "database") {
      return res.render('passwordReset', {
        title: "ACAS reset",
        scripts: [],
        user: user,
        message: errorMsg
      });
    } else {
      return res.redirect('/login');
    }
  };

  exports.changePage = function(req, res) {
    var error, errorMsg, user;
    user = null;
    if (req.user != null) {
      user = req.user;
    }
    if (user !== null) {
      errorMsg = "";
      error = req.flash('error');
      if (error.length > 0) {
        errorMsg = error[0];
      }
      return res.render('passwordChange', {
        title: "ACAS reset",
        scripts: [],
        user: user,
        message: errorMsg
      });
    } else {
      return res.render('login', {
        title: "ACAS login",
        scripts: [],
        user: user,
        message: "need login or admin"
      });
    }
  };

}).call(this);

$ = require('jquery')
_ = require('lodash')

AppRouter = require('../src/client/AppRouter.coffee').AppRouter

describe "AppRouter", ->
  beforeEach ->
    window.AppLaunchParams = {}
    @appRouter = new AppRouter()

  it "should exist", ->
    expect(@appRouter).toBeTruthy()
module.exports = (grunt) ->
	"use strict"

	#
	# Grunt configuration:
	#
	# https://github.com/cowboy/grunt/blob/master/docs/getting_started.md
	#
	grunt.initConfig

	# Project configuration
	# ---------------------
		coffee:
			app:
				files: [
						expand: true
						flatten: true
						src: ["public/src/modules/**/src/client/*.coffee"]
						dest: "public/javascripts/src/"
						ext: '.js'
					]

			spec:
				files: [
					expand: true
					flatten: true
					src: ["public/src/modules/**/spec/*.coffee"]
					dest: "public/javascripts/spec/"
					ext: '.js'
				]

			compileTestFixtures:
				files: [
					expand: true
					flatten: true
					src: ["public/src/modules/**/spec/testFixtures/*.coffee"]
					dest: "public/javascripts/spec/testFixtures/"
					ext: '.js'
				]

			compileApp:
				files: [
					expand: true
					flatten: true
					src: ["./*.coffee"]
					dest: "./"
					ext: '.js'
				]

			compileRoutes:
				files: [
					expand: true
					flatten: true
					src: ["routes/*.coffee"]
					dest: "routes/"
					ext: '.js'
				]

			moduleRoutes:
				files: [
					expand: true
					flatten: true
					src: ["public/src/modules/**/src/server/routes/*.coffee"]
					dest: "routes/"
					ext: '.js'
				]

		watch:
			coffee:
				files: 'public/src/modules/**/src/client/*.coffee'
				tasks: 'coffee:app'

			compileSpec:
				files: "public/src/modules/**/spec/*.coffee"
				tasks: "coffee:spec"

			compileTestFixtures:
				files: "public/src/modules/**/spec/testFixtures/*.coffee"
				tasks: "coffee:compileTestFixtures"

			compileApp:
				files: "./*.coffee"
				tasks: "coffee:compileApp"

			compileRoutes:
				files: "routes/*.coffee"
				tasks: "coffee:compileRoutes"

			moduleRoutes:
				files: "public/src/modules/**/src/server/routes/*.coffee"
				tasks: "coffee:moduleRoutes"

		concat:
			dist:
				src: ["public/javascripts/src/*.js"]
				dest: "public/src/built.js"

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-watch"

	# set the default task to the "watch" task
	grunt.registerTask "default", ["watch"]
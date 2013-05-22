###
This service runs a primary data analysis. The data is provided in a directory containing one or more data files. There should be no extraneous files not required for data analysis in this source directory. For example, the FLIPR will make one file for the max values for each plate, and another file for the min values. If multiple plates are to be analyzed, there would be multiple files. The way the files should be interpreted is determined by the dataSource parameter of the PrimaryAnalysisProtocol

The raw data and results are stored in the database. Additionally, a PDF is generated summarizing the analysis in graphs and tables. There is also csv result file containing the raw data, batch number, transformed data, well types, and well flags

###

#The required data structure is
goodExampleData =
	primaryAnalysisExperimentId: 332134			# Id returned by fitProtocolService
	fileToParse: "/var/www/rScripts/specFiles/primaryAnalysis/GoodFLIPRMinMaxSet1/rawData.zip" # Path to a previously uploaded file
	user: 'jmcneil'
	dryRun: true 					# a testing option to do everything but save the results


#The expected return format for success is:
returnExampleSuccess =
	transactionId: null
	results:
		fileToParse: "path/to/directory"
		htmlSummary: "plates to analyze: 3 <br/> batches to associate: 123"
		primaryAnalysisExperimentId: 332134
		dryRun: true
	hasError: false
	hasWarning: true
	errorMessages: [{errorLevel: "warning", message: "some warning"}]


#The expected return format for error is:
returnExampleError =
	transactionId: null
	results:
		fileToParse: "path/to/file"
		htmlSummary: "Error: Can't read dat file"
		dryRun: true
	hasError: true
	hasWarning: true
	errorMessages: [
		{errorLevel: "warning", message: "some warning"},
		{errorLevel: "error", message: "Can't read file"},
		{errorLevel: "error", message: "Can't find positive control on plate"}
	]


# Here is example usage
describe 'Run primary analysis service testing', ->
	beforeEach ->
		@waitForServiceReturn = ->
			typeof @serviceReturn != 'undefined'

	describe 'when run with valid input', ->
		beforeEach ->
			self = @
			$.ajax
				type: 'POST'
				url: "api/primaryAnalysis/runPrimaryAnalysis"
				data: goodExampleData
				success: (json) ->
					self.serviceReturn = json
				error: (err) ->
					console.log 'got ajax error'
					self.serviceReturn = null
				dataType: 'json'

		it 'should return error=false', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				(expect @serviceReturn.error).toBeFalsy

	describe 'when run with flawed input file', ->
		beforeEach ->
			goodExampleData.fileToParse += "_with_error"
			self = @
			$.ajax
				type: 'POST'
				url: "api/primaryAnalysis/runPrimaryAnalysis"
				data: goodExampleData # modified to have bad fitProtocolId
				success: (json) ->
					self.serviceReturn = json
				error: (err) ->
					console.log 'got ajax error'
					self.serviceReturn = null
				dataType: 'json'

		it 'should return error=true', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				(expect @serviceReturn.error).toBeTruthy

		it 'should return error messages', ->
			waitsFor( @waitForServiceReturn, 'service did not return', 2000)
			runs ->
				(expect @serviceReturn.errorMessages.length).toBeGreaterThan 0


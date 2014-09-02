beforeEach ->
	@fixture = $.clone($("#fixture").get(0))

afterEach ->
	$("#fixture").remove()
	$("body").append $(@fixture)

describe "Primary Screen Experiment module testing", ->

	describe "Primary Analysis Read model testing", ->
		describe "When loaded from new", ->
			beforeEach ->
				@par = new PrimaryAnalysisRead()
			describe "Existence and Defaults", ->
				it "should be defined", ->
					expect(@par).toBeDefined()
				it "should have defaults", ->
					expect(@par.get('readPosition')).toBeNull()
					expect(@par.get('readName')).toEqual "unassigned"
					expect(@par.get('activity')).toBeFalsy()
		describe "model validation tests", ->
			beforeEach ->
				@par = new PrimaryAnalysisRead window.primaryScreenTestJSON.primaryAnalysisReads[0]
			it "should be valid as initialized", ->
				expect(@par.isValid()).toBeTruthy()
			it "should be invalid when read position is NaN", ->
				@par.set readPosition: NaN
				expect(@par.isValid()).toBeFalsy()
				filtErrors = _.filter @par.validationError, (err) ->
					err.attribute=='readPosition'
				expect(filtErrors.length).toBeGreaterThan 0
			it "should be invalid when read name is unassigned", ->
				@par.set readName: "unassigned"
				expect(@par.isValid()).toBeFalsy()
				filtErrors = _.filter @par.validationError, (err) ->
					err.attribute=='readName'
				expect(filtErrors.length).toBeGreaterThan 0

	describe "Transformation Rule Model testing", ->
		describe "When loaded from new", ->
			beforeEach ->
				@tr = new TransformationRule()
			describe "Existence and Defaults", ->
				it "should be defined", ->
					expect(@tr).toBeDefined()
				it "should have defaults", ->
					expect(@tr.get('transformationRule')).toEqual "unassigned"
		describe "model validation tests", ->
			beforeEach ->
				@tr = new TransformationRule window.primaryScreenTestJSON.transformationRules[0]
			it "should be valid as initialized", ->
				expect(@tr.isValid()).toBeTruthy()
			it "should be invalid when transformation rule is unassigned", ->
				@tr.set transformationRule: "unassigned"
				expect(@tr.isValid()).toBeFalsy()
				filtErrors = _.filter @tr.validationError, (err) ->
					err.attribute=='transformationRule'
				expect(filtErrors.length).toBeGreaterThan 0

	describe "Primary Analysis Read List testing", ->
		describe "When loaded from new", ->
			beforeEach ->
				@parl = new PrimaryAnalysisReadList()
			describe "Existence", ->
				it "should be defined", ->
					expect(@parl).toBeDefined()
		describe "When loaded form existing", ->
			beforeEach ->
				@parl = new PrimaryAnalysisReadList window.primaryScreenTestJSON.primaryAnalysisReads
			it "should have three reads", ->
				expect(@parl.length).toEqual 3
			it "should have the correct read info for the first read", ->
				readtwo = @parl.at(0)
				expect(readtwo.get('readPosition')).toEqual 11
				expect(readtwo.get('readName')).toEqual "none"
				expect(readtwo.get('activity')).toBeTruthy()
			it "should have the correct read info for the second read", ->
				readtwo = @parl.at(1)
				expect(readtwo.get('readPosition')).toEqual 12
				expect(readtwo.get('readName')).toEqual "fluorescence"
				expect(readtwo.get('activity')).toBeFalsy()
			it "should have the correct read info for the third read", ->
				readthree = @parl.at(2)
				expect(readthree.get('readPosition')).toEqual 13
				expect(readthree.get('readName')).toEqual "luminescence"
				expect(readthree.get('activity')).toBeFalsy()


	describe "Transformation Rule List testing", ->
		describe "When loaded from new", ->
			beforeEach ->
				@trl = new TransformationRuleList()
			describe "Existence", ->
				it "should be defined", ->
					expect(@trl).toBeDefined()
		describe "When loaded form existing", ->
			beforeEach ->
				@trl = new TransformationRuleList window.primaryScreenTestJSON.transformationRules
			it "should have three reads", ->
				expect(@trl.length).toEqual 3
			it "should have the correct rule info for the first rule", ->
				ruleone = @trl.at(0)
				expect(ruleone.get('transformationRule')).toEqual "% efficacy"
			it "should have the correct read info for the second rule", ->
				ruletwo = @trl.at(1)
				expect(ruletwo.get('transformationRule')).toEqual "sd"
			it "should have the correct read info for the third read", ->
				rulethree = @trl.at(2)
				expect(rulethree.get('transformationRule')).toEqual "null"
		describe "collection validation", ->
			beforeEach ->
				@trl= new TransformationRuleList window.primaryScreenTestJSON.transformationRules
			it "should be invalid if a transformation rule is selected more than once", ->
				@trl.at(0).set transformationRule: "sd"
				@trl.at(1).set transformationRule: "sd"
				expect((@trl.validateCollection()).length).toBeGreaterThan 0

	describe "Analysis Parameter model testing", ->
		describe "When loaded from new", ->
			beforeEach ->
				@psap = new PrimaryScreenAnalysisParameters()
			describe "Existence and Defaults", ->
				it "should be defined", ->
					expect(@psap).toBeDefined()
				it "should have defaults", ->
					expect(@psap.get('assayVolume')).toBeNull()
					expect(@psap.get('transferVolume')).toBeNull()
					expect(@psap.get('dilutionFactor')).toBeNull()
					expect(@psap.get('volumeType')).toEqual "dilution"
					expect(@psap.get('instrumentReader')).toEqual "unassigned"
					expect(@psap.get('signalDirectionRule')).toEqual "unassigned"
					expect(@psap.get('aggregateBy1')).toEqual "unassigned"
					expect(@psap.get('aggregateBy2')).toEqual "unassigned"
					expect(@psap.get('normalizationRule')).toEqual "unassigned"
					expect(@psap.get('hitEfficacyThreshold')).toBeNull()
					expect(@psap.get('hitSDThreshold')).toBeNull()
					expect(@psap.get('positiveControl') instanceof Backbone.Model).toBeTruthy()
					expect(@psap.get('negativeControl') instanceof Backbone.Model).toBeTruthy()
					expect(@psap.get('vehicleControl') instanceof Backbone.Model).toBeTruthy()
					expect(@psap.get('agonistControl') instanceof Backbone.Model).toBeTruthy()
					expect(@psap.get('thresholdType')).toEqual "sd"
					expect(@psap.get('autoHitSelection')).toBeFalsy()
					expect(@psap.get('htsFormat')).toBeFalsy()
					expect(@psap.get('matchReadName')).toBeTruthy()
					expect(@psap.get('primaryAnalysisReadList') instanceof PrimaryAnalysisReadList).toBeTruthy()
					expect(@psap.get('transformationRuleList') instanceof TransformationRuleList).toBeTruthy()

		describe "When loaded form existing", ->
			beforeEach ->
				@psap = new PrimaryScreenAnalysisParameters window.primaryScreenTestJSON.primaryScreenAnalysisParameters
			describe "composite object creation", ->
				it "should convert readlist to PrimaryAnalysisReadList", ->
					expect( @psap.get('primaryAnalysisReadList') instanceof PrimaryAnalysisReadList).toBeTruthy()
				it "should convert transformationRuleList to TransformationRuleList", ->
					expect( @psap.get('transformationRuleList') instanceof TransformationRuleList).toBeTruthy()
			describe "model validation tests", ->
				it "should be valid as initialized", ->
					expect(@psap.isValid()).toBeTruthy()
				it "should be invalid when positive control batch is empty", ->
					@psap.get('positiveControl').set
						batchCode: ""
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='positiveControlBatch'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when positive control conc is NaN", ->
					@psap.get('positiveControl').set
						concentration: NaN
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='positiveControlConc'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when negative control batch is empty", ->
					@psap.get('negativeControl').set
						batchCode: ""
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='negativeControlBatch'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when negative control conc is NaN", ->
					@psap.get('negativeControl').set
						concentration: NaN
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='negativeControlConc'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be valid when agonist control batch and conc are both empty", ->
					@psap.get('agonistControl').set
						batchCode: ""
						concentration: ""
					expect(@psap.validate(@psap.attributes)).toEqual null
				it "should be valid when agonist control batch is entered and agonist control conc is a number ", ->
					@psap.get('agonistControl').set
						batchCode:"CMPD-87654399-01"
						concentration: 12
					expect(@psap.isValid()).toBeTruthy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='agonistControlConc'
						err.attribute=='agonistControlBatch'
					expect(filtErrors.length).toEqual 0
				it "should be invalid when agonist control batch is entered and agonist control conc is NaN", ->
					@psap.get('agonistControl').set
						batchCode:"CMPD-87654399-01"
						concentration: NaN
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='agonistControlConc'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when agonist control batch is empty and agonist control conc is a number ", ->
					@psap.get('agonistControl').set
						batchCode:""
						concentration: 13
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='agonistControlBatch'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be valid when vehicle control is empty", ->
					@psap.get('vehicleControl').set
						batchCode: ""
					expect(@psap.isValid()).toBeTruthy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='vehicleControlBatch'
					expect(filtErrors.length).toEqual 0
				it "should be invalid when assayVolume is NaN (but can be empty)", ->
					@psap.set assayVolume: NaN
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='assayVolume'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when assayVolume is not set but transfer volume is set", ->
					@psap.set assayVolume: ""
					@psap.set dilutionFactor: ""
					@psap.set transferVolume: 40
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='assayVolume'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be valid when assayVolume, transfer volume, and dilution factors are empty", ->
					@psap.set assayVolume: ""
					@psap.set transferVolume: ""
					@psap.set dilutionFactor: ""
					expect(@psap.isValid()).toBeTruthy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='assayVolume'
					expect(filtErrors.length).toEqual 0
				it "should be valid when instrument reader is unassigned", ->
					@psap.set instrumentReader: "unassigned"
					expect(@psap.isValid()).toBeTruthy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='instrumentReader'
					expect(filtErrors.length).toEqual 0
				it "should be invalid when aggregate by1 is unassigned", ->
					@psap.set aggregateBy1: "unassigned"
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='aggregateBy1'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when aggregate by2 is unassigned", ->
					@psap.set aggregateBy2: "unassigned"
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='aggregateBy2'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when signal direction rule is unassigned", ->
					@psap.set signalDirectionRule: "unassigned"
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='signalDirectionRule'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when normalization rule is unassigned", ->
					@psap.set normalizationRule: "unassigned"
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='normalizationRule'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when volumeType is dilution and dilutionFactor is not a number (but can be empty)", ->
					@psap.set volumeType: "dilution"
					@psap.set dilutionFactor: NaN
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='dilutionFactor'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be valid when volumeType is dilution and dilutionFactor is empty", ->
					@psap.set volumeType: "dilution"
					@psap.set dilutionFactor: ""
					expect(@psap.isValid()).toBeTruthy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='dilutionFactor'
					expect(filtErrors.length).toEqual 0
				it "should be invalid when volumeType is transfer and transferVolume is not a number (but can be empty)", ->
					@psap.set volumeType: "transfer"
					@psap.set transferVolume: NaN
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='transferVolume'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be valid when volumeType is transfer and transferVolume is empty", ->
					@psap.set volumeType: "transfer"
					@psap.set transferVolume: ""
					expect(@psap.isValid()).toBeTruthy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='transferVolume'
					expect(filtErrors.length).toEqual 0
				it "should be invalid when autoHitSelection is checked and thresholdType is sd and hitSDThreshold is not a number", ->
					@psap.set autoHitSelection: true
					@psap.set thresholdType: "sd"
					@psap.set hitSDThreshold: NaN
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='hitSDThreshold'
					expect(filtErrors.length).toBeGreaterThan 0
				it "should be invalid when autoHitSelection is checked and thresholdType is efficacy and hitEfficacyThreshold is not a number", ->
					@psap.set autoHitSelection: true
					@psap.set thresholdType: "efficacy"
					@psap.set hitEfficacyThreshold: NaN
					expect(@psap.isValid()).toBeFalsy()
					filtErrors = _.filter @psap.validationError, (err) ->
						err.attribute=='hitEfficacyThreshold'
					expect(filtErrors.length).toBeGreaterThan 0

			describe "autocalculating volumes", ->
				it "should autocalculate the dilution factor from the transfer volume and assay volume", ->
					@psap.set volumeType: "transfer"
					@psap.set transferVolume: 12
					@psap.set assayVolume: 36
					expect(@psap.autocalculateVolumes()).toEqual 36/12
				it "should autocalculate the transfer volume from the dilution factor and assay volume", ->
					@psap.set volumeType: "dilution"
					@psap.set dilutionFactor: 4
					@psap.set assayVolume: 36
					expect(@psap.autocalculateVolumes()).toEqual 36/4
				it "should not autocalculate the dilution factor if transfer volume is NaN", ->
					@psap.set volumeType: "transfer"
					@psap.set transferVolume: NaN
					@psap.set assayVolume: 36
					expect(@psap.autocalculateVolumes()).toEqual ""
				it "should not autocalculate the dilution factor if assay volume is NaN", ->
					@psap.set volumeType: "transfer"
					@psap.set transferVolume: 14
					@psap.set assayVolume: NaN
					expect(@psap.autocalculateVolumes()).toEqual ""
				it "should not autocalculate the transfer volume if the dilution factor is NaN", ->
					@psap.set volumeType: "dilution"
					@psap.set dilutionFactor: NaN
					@psap.set assayVolume: 36
					expect(@psap.autocalculateVolumes()).toEqual ""
				it "should not autocalculate the dilution factor if the transfer volume is 0", ->
					@psap.set volumeType: "transfer"
					@psap.set transferVolume: 0
					@psap.set assayVolume: 123
					expect(@psap.autocalculateVolumes()).toEqual ""
				it "should not autocalculate the transfer volume if the dilution factor is 0", ->
					@psap.set volumeType: "dilution"
					@psap.set dilutionFactor: 0
					@psap.set assayVolume: 123
					expect(@psap.autocalculateVolumes()).toEqual ""

	describe "Primary Screen Experiment model testing", ->
		describe "When loaded from existing", ->
			beforeEach ->
				@pse = new PrimaryScreenExperiment window.experimentServiceTestJSON.fullExperimentFromServer
			describe "Existence and Defaults", ->
				it "should be defined", ->
					expect(@pse).toBeDefined()
			describe "special getters", ->
				describe "analysis parameters", ->
					it 'Should be able to get analysis parameters', ->
						expect(@pse.getAnalysisParameters() instanceof PrimaryScreenAnalysisParameters).toBeTruthy()
					it 'Should parse analysis parameters', ->
						expect(@pse.getAnalysisParameters().get('hitSDThreshold')).toEqual 5
						expect(@pse.getAnalysisParameters().get('dilutionFactor')).toEqual 21
					it 'Should parse pos control into backbone models', ->
						expect(@pse.getAnalysisParameters().get('positiveControl').get('batchCode')).toEqual "CMPD-12345678-01"
					it 'Should parse neg control into backbone models', ->
						expect(@pse.getAnalysisParameters().get('negativeControl').get('batchCode')).toEqual "CMPD-87654321-01"
					it 'Should parse veh control into backbone models', ->
						expect(@pse.getAnalysisParameters().get('vehicleControl').get('batchCode')).toEqual "CMPD-00000001-01"
					it 'Should parse agonist control into backbone models', ->
						expect(@pse.getAnalysisParameters().get('agonistControl').get('batchCode')).toEqual "CMPD-87654399-01"
				describe "model fit parameters", ->
					it 'Should be able to get model parameters', ->
						# this is not hydrated into a specific model type at this level, it is passed to the specific curve fit class for that
						expect(@pse.getModelFitParameters().inverseAgonistMode ).toBeTruthy()
				describe "special states", ->
					it "should be able to get the analysis status", ->
						expect(@pse.getAnalysisStatus().get('stringValue')).toEqual "not started"
					it "should be able to get the analysis result html", ->
						expect(@pse.getAnalysisResultHTML().get('clobValue')).toEqual "<p>Analysis not yet completed</p>"
					it "should be able to get the model fit status", ->
						expect(@pse.getModelFitStatus().get('stringValue')).toEqual "not started"
					it "should be able to get the model result html", ->
						expect(@pse.getModelFitResultHTML().get('clobValue')).toEqual "<p>Model fit not yet completed</p>"
		describe "When loaded from new", ->
			beforeEach ->
				@pse2 = new PrimaryScreenExperiment()
			describe "special states", ->
				it "should be able to get the analysis status", ->
					expect(@pse2.getAnalysisStatus().get('stringValue')).toEqual "not started"
				it "should be able to get the analysis result html", ->
					expect(@pse2.getAnalysisResultHTML().get('clobValue')).toEqual ""
				it "should be able to get the model fit status", ->
					expect(@pse2.getModelFitStatus().get('stringValue')).toEqual "not started"
				it "should be able to get the model result html", ->
					expect(@pse2.getModelFitResultHTML().get('clobValue')).toEqual ""

	describe "PrimaryAnalysisReadController", ->
		describe "when instantiated", ->
			beforeEach ->
				@parc = new PrimaryAnalysisReadController
					model: new PrimaryAnalysisRead window.primaryScreenTestJSON.primaryAnalysisReads[0]
					el: $('#fixture')
				@parc.render()
			describe "basic existance tests", ->
				it "should exist", ->
					expect(@parc).toBeDefined()
				it "should load a template", ->
					expect(@parc.$('.bv_readName').length).toEqual 1
			describe "render existing parameters", ->
				it "should show read position", ->
					expect(@parc.$('.bv_readPosition').val()).toEqual "11"
				it "should show read name", ->
					waitsFor ->
						@parc.$('.bv_readName option').length > 0
					, 1000
					runs ->
						expect(@parc.$('.bv_readName').val()).toEqual "none"
				it "should have activity checked", ->
					expect(@parc.$('.bv_activity').attr("checked")).toEqual "checked"
			describe "model updates", ->
				it "should update the readPosition ", ->
					@parc.$('.bv_readPosition').val( '42' )
					@parc.$('.bv_readPosition').change()
					expect(@parc.model.get('readPosition')).toEqual 42
				it "should update the read name", ->
					waitsFor ->
						@parc.$('.bv_readName option').length > 0
					, 1000
					runs ->
						@parc.$('.bv_readName').val('unassigned')
						@parc.$('.bv_readName').change()
						expect(@parc.model.get('readName')).toEqual "unassigned"
		describe "validation testing", ->
			beforeEach ->
				@parc = new PrimaryAnalysisReadController
					model: new PrimaryAnalysisRead window.primaryScreenTestJSON.primaryAnalysisReads
					el: $('#fixture')
				@parc.render()

	describe "TransformationRuleController", ->
		describe "when instantiated", ->
			beforeEach ->
				@trc = new TransformationRuleController
					model: new TransformationRule window.primaryScreenTestJSON.transformationRules[0]
					el: $('#fixture')
				@trc.render()
			describe "basic existance tests", ->
				it "should exist", ->
					expect(@trc).toBeDefined()
				it "should load a template", ->
					expect(@trc.$('.bv_transformationRule').length).toEqual 1
			describe "render existing parameters", ->
				it "should show transformation rule", ->
					waitsFor ->
						@trc.$('.bv_transformationRule option').length > 0
					, 1000
					runs ->
						expect(@trc.$('.bv_transformationRule').val()).toEqual "% efficacy"
			describe "model updates", ->
				it "should update the transformation rule", ->
					waitsFor ->
						@trc.$('.bv_transformationRule option').length > 0
					, 1000
					runs ->
						@trc.$('.bv_transformationRule').val('sd')
						@trc.$('.bv_transformationRule').change()
						expect(@trc.model.get('transformationRule')).toEqual "sd"

	describe "Primary Analysis Read List Controller testing", ->
		describe "when instantiated with no data", ->
			beforeEach ->
				@parlc= new PrimaryAnalysisReadListController
					el: $('#fixture')
					collection: new PrimaryAnalysisReadList()
				@parlc.render()
			describe "basic existence tests", ->
				it "should exist", ->
					expect(@parlc).toBeDefined()
				it "should load a template", ->
					expect(@parlc.$('.bv_addReadButton').length).toEqual 1
			describe "rendering", ->
				it "should show one read with the activity selected", ->
					expect(@parlc.$('.bv_readInfo .bv_readName').length).toEqual 1
					expect(@parlc.collection.length).toEqual 1
#					expect(@parlc.$('.bv_readPosition:eq(0)').toBeTruthy())
			describe "adding and removing", ->
				it "should have two reads when add read is clicked", ->
					@parlc.$('.bv_addReadButton').click()
					expect(@parlc.$('.bv_readInfo .bv_readName').length).toEqual 2
					expect(@parlc.collection.length).toEqual 2
				it "should have no reads when there is one read and remove is clicked", ->
					expect(@parlc.collection.length).toEqual 1
					@parlc.$('.bv_delete').click()
					expect(@parlc.$('.bv_readInfo .bv_readName').length).toEqual 0
					expect(@parlc.collection.length).toEqual 0
				it "should have one read when there are two reads and remove is clicked", ->
					@parlc.$('.bv_addReadButton').click()
					expect(@parlc.$('.bv_readInfo .bv_readName').length).toEqual 2
					@parlc.$('.bv_delete:eq(0)').click()
					expect(@parlc.$('.bv_readInfo .bv_readName').length).toEqual 1
					expect(@parlc.collection.length).toEqual 1
		describe "when instantiated with data", ->
			beforeEach ->
				@parlc= new PrimaryAnalysisReadListController
					el: $('#fixture')
					collection: new PrimaryAnalysisReadList window.primaryScreenTestJSON.primaryAnalysisReads
				@parlc.render()
			it "should have three reads", ->
				expect(@parlc.collection.length).toEqual 3
			it "should have the correct read info for the first read", ->
				waitsFor ->
					@parlc.$('.bv_readName option').length > 0
				, 1000
				runs ->
					expect(@parlc.$('.bv_readPosition:eq(0)').val()).toEqual "11"
					expect(@parlc.$('.bv_readName:eq(0)').val()).toEqual "none"
					expect(@parlc.$('.bv_activity:eq(0)').attr("checked")).toEqual "checked"
			it "should have the correct read info for the second read", ->
				waitsFor ->
					@parlc.$('.bv_readName option').length > 0
				, 1000
				runs ->
					expect(@parlc.$('.bv_readPosition:eq(1)').val()).toEqual "12"
					expect(@parlc.$('.bv_readName:eq(1)').val()).toEqual "fluorescence"
					expect(@parlc.$('.bv_activity:eq(1)').attr("checked")).toBeUndefined()
			it "should have the correct read info for the third read", ->
				waitsFor ->
					@parlc.$('.bv_readName option').length > 0
				, 1000
				runs ->
					expect(@parlc.$('.bv_readPosition:eq(2)').val()).toEqual "13"
					expect(@parlc.$('.bv_readName:eq(2)').val()).toEqual "luminescence"
					expect(@parlc.$('.bv_activity:eq(2)').attr("checked")).toBeUndefined()

	describe "Transformation Rule List Controller testing", ->
		describe "when instantiated with no data", ->
			beforeEach ->
				@trlc= new TransformationRuleListController
					el: $('#fixture')
					collection: new TransformationRuleList()
				@trlc.render()
			describe "basic existence tests", ->
				it "should exist", ->
					expect(@trlc).toBeDefined()
				it "should load a template", ->
					expect(@trlc.$('.bv_addTransformationButton').length).toEqual 1
			describe "rendering", ->
				it "should show one rule", ->
					expect(@trlc.$('.bv_transformationInfo .bv_transformationRule').length).toEqual 1
					expect(@trlc.collection.length).toEqual 1
			describe "adding and removing", ->
				it "should have two rules when add transformation button is clicked", ->
					@trlc.$('.bv_addTransformationButton').click()
					expect(@trlc.$('.bv_transformationInfo .bv_transformationRule').length).toEqual 2
					expect(@trlc.collection.length).toEqual 2
				it "should have one rule when there are two rules and remove is clicked", ->
					@trlc.$('.bv_addTransformationButton').click()
					expect(@trlc.$('.bv_transformationInfo .bv_transformationRule').length).toEqual 2
					@trlc.$('.bv_deleteRule:eq(0)').click()
					expect(@trlc.$('.bv_transformationInfo .bv_transformationRule').length).toEqual 1
					expect(@trlc.collection.length).toEqual 1
				it "should always have one read", ->
					expect(@trlc.collection.length).toEqual 1
					@trlc.$('.bv_deleteRule').click()
					expect(@trlc.$('.bv_transformationInfo .bv_transformationRule').length).toEqual 1
					expect(@trlc.collection.length).toEqual 1

		describe "when instantiated with data", ->
			beforeEach ->
				@trlc= new TransformationRuleListController
					el: $('#fixture')
					collection: new TransformationRuleList window.primaryScreenTestJSON.transformationRules
				@trlc.render()
			it "should have three rules", ->
				expect(@trlc.$('.bv_transformationInfo .bv_transformationRule').length).toEqual 3
				expect(@trlc.collection.length).toEqual 3
			it "should have the correct rule info for the first rule", ->
				waitsFor ->
					@trlc.$('.bv_transformationRule option').length > 0
				, 1000
				runs ->
					expect(@trlc.$('.bv_transformationInfo .bv_transformationRule:eq(0)').val()).toEqual "% efficacy"
			it "should have the correct rule info for the second rule", ->
				waitsFor ->
					@trlc.$('.bv_transformationRule option').length > 0
				, 1000
				runs ->
					expect(@trlc.$('.bv_transformationInfo .bv_transformationRule:eq(1)').val()).toEqual "sd"
			it "should have the correct rule info for the third rule", ->
				# note: this test sometimes breaks for no reason. If run the specific test, it will pass.
				waitsFor ->
					@trlc.$('.bv_transformationRule option').length > 0
				, 1000
				runs ->
					expect(@trlc.$('.bv_transformationInfo .bv_transformationRule:eq(2)').val()).toEqual "null"


	describe 'PrimaryScreenAnalysisParameters Controller', ->
		describe 'when instantiated', ->
			beforeEach ->
				@psapc = new PrimaryScreenAnalysisParametersController
					model: new PrimaryScreenAnalysisParameters window.primaryScreenTestJSON.primaryScreenAnalysisParameters
					el: $('#fixture')
				@psapc.render()
			describe "basic existance tests", ->
				it 'should exist', ->
					expect(@psapc).toBeDefined()
				it 'should load a template', ->
					expect(@psapc.$('.bv_autofillSection').length).toEqual 1
				it 'should load autofill template', ->
					expect(@psapc.$('.bv_hitSDThreshold').length).toEqual 1
			describe "render existing parameters", ->
				it 'should show the instrumentReader', ->
					waitsFor ->
						@psapc.$('.bv_instrumentReader option').length > 0
					, 1000
					runs ->
						expect(@psapc.$('.bv_instrumentReader').val()).toEqual "flipr"
				it 'should show the signal direction rule', ->
					waitsFor ->
						@psapc.$('.bv_signalDirectionRule option').length > 0
					, 1000
					runs ->
						expect(@psapc.$('.bv_signalDirectionRule').val()).toEqual "increasing signal (highest = 100%)"
				it 'should show the aggregateBy1', ->
					waitsFor ->
						@psapc.$('.bv_aggregateBy1 option').length > 0
					, 1000
					runs ->
						expect(@psapc.$('.bv_aggregateBy1').val()).toEqual "compound batch concentration"
				it 'should show the aggregateBy2', ->
					waitsFor ->
						@psapc.$('.bv_aggregateBy2 option').length > 0
					, 1000
					runs ->
						expect(@psapc.$('.bv_aggregateBy2').val()).toEqual "median"
				it 'should show the normalization rule', ->
					waitsFor ->
						@psapc.$('.bv_normalizationRule option').length > 0
					, 1000
					runs ->
						expect(@psapc.$('.bv_normalizationRule').val()).toEqual "plate order only"
				it 'should show the assayVolume', ->
					expect(@psapc.$('.bv_assayVolume').val()).toEqual '24'
				it 'should show the transferVolume', ->
					expect(@psapc.$('.bv_transferVolume').val()).toEqual '12'
				it 'should show the dilutionFactor', ->
					expect(@psapc.$('.bv_dilutionFactor').val()).toEqual '21'
				it 'should start with volumeType radio set', ->
					expect(@psapc.$("input[name='bv_volumeType']:checked").val()).toEqual 'dilution'
				it 'should show the positiveControlBatch', ->
					expect(@psapc.$('.bv_positiveControlBatch').val()).toEqual 'CMPD-12345678-01'
				it 'should show the positiveControlConc', ->
					expect(@psapc.$('.bv_positiveControlConc').val()).toEqual '10'
				it 'should show the negativeControlBatch', ->
					expect(@psapc.$('.bv_negativeControlBatch').val()).toEqual 'CMPD-87654321-01'
				it 'should show the negativeControlConc', ->
					expect(@psapc.$('.bv_negativeControlConc').val()).toEqual '1'
				it 'should show the vehControlBatch', ->
					expect(@psapc.$('.bv_vehicleControlBatch').val()).toEqual 'CMPD-00000001-01'
				it 'should show the agonistControlBatch', ->
					expect(@psapc.$('.bv_agonistControlBatch').val()).toEqual 'CMPD-87654399-01'
				it 'should show the agonistControlConc', ->
					expect(@psapc.$('.bv_agonistControlConc').val()).toEqual '250753.77'
				it 'should start with autoHitSelection unchecked', ->
					expect(@psapc.$('.bv_autoHitSelection').attr("checked")).toBeUndefined()
				it 'should show the hitSDThreshold', ->
					expect(@psapc.$('.bv_hitSDThreshold').val()).toEqual '5'
				it 'should show the hitEfficacyThreshold', ->
					expect(@psapc.$('.bv_hitEfficacyThreshold').val()).toEqual '42'
				it 'should start with thresholdType radio set', ->
					expect(@psapc.$("input[name='bv_thresholdType']:checked").val()).toEqual 'sd'
				it 'should hide threshold controls if the model loads unchecked automaticHitSelection', ->
					expect(@psapc.$('.bv_thresholdControls')).toBeHidden()
				it 'should start with htsFormat unchecked', ->
					expect(@psapc.$('.bv_htsFormat').attr("checked")).toBeUndefined()
				it 'should start with matchReadName unchecked', ->
					expect(@psapc.$('.bv_matchReadName').attr("checked")).toBeUndefined()
				it 'should show a primary analysis read list', ->
					expect(@psapc.$('.bv_readInfo .bv_readName').length).toEqual 3

			describe "model updates", ->
				it "should update the instrument reader", ->
					waitsFor ->
						@psapc.$('.bv_instrumentReader option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_instrumentReader').val('unassigned')
						@psapc.$('.bv_instrumentReader').change()
						expect(@psapc.model.get('instrumentReader')).toEqual "unassigned"
				it "should update the signal direction rule", ->
					waitsFor ->
						@psapc.$('.bv_signalDirectionRule option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_signalDirectionRule').val('unassigned')
						@psapc.$('.bv_signalDirectionRule').change()
						expect(@psapc.model.get('signalDirectionRule')).toEqual "unassigned"
				it "should update the aggregateBy1", ->
					waitsFor ->
						@psapc.$('.bv_aggregateBy1 option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_aggregateBy1').val('unassigned')
						@psapc.$('.bv_aggregateBy1').change()
						expect(@psapc.model.get('aggregateBy1')).toEqual "unassigned"
				it "should update the bv_aggregateBy2", ->
					waitsFor ->
						@psapc.$('.bv_aggregateBy2 option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_aggregateBy2').val('unassigned')
						@psapc.$('.bv_aggregateBy2').change()
						expect(@psapc.model.get('aggregateBy2')).toEqual "unassigned"
				it "should update the normalizationRule rule", ->
					waitsFor ->
						@psapc.$('.bv_normalizationRule option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_normalizationRule').val('unassigned')
						@psapc.$('.bv_normalizationRule').change()
						expect(@psapc.model.get('normalizationRule')).toEqual "unassigned"
				it "should update the assayVolume and recalculate the transfer volume if the dilution factor is set ", ->
					@psapc.$('.bv_volumeTypeDilution').click()
					@psapc.$('.bv_dilutionFactor').val(' 3 ')
					@psapc.$('.bv_dilutionFactor').change()
					expect(@psapc.model.get('dilutionFactor')).toEqual 3
					@psapc.$('.bv_assayVolume').val(' 27 ')
					@psapc.$('.bv_assayVolume').change()
					expect(@psapc.model.get('assayVolume')).toEqual 27
					expect(@psapc.model.get('transferVolume')).toEqual 9
				it "should update the transferVolume and autocalculate the dilution factor based on assay and transfer volumes", ->
					@psapc.$('.bv_volumeTypeTransfer').click()
					@psapc.$('.bv_transferVolume').val(' 12 ')
					@psapc.$('.bv_transferVolume').change()
					expect(@psapc.model.get('transferVolume')).toEqual 12
					@psapc.$('.bv_assayVolume').val(' 24 ')
					@psapc.$('.bv_assayVolume').change()
					expect(@psapc.model.get('dilutionFactor')).toEqual 2
				it "should update the dilution factor and autocalculate the transfer volume based on assay volume and dilution factor ", ->
					@psapc.$('.bv_dilutionFactor').val(' 4 ')
					@psapc.$('.bv_dilutionFactor').change()
					expect(@psapc.model.get('dilutionFactor')).toEqual 4
					@psapc.$('.bv_assayVolume').val(' 24 ')
					@psapc.$('.bv_assayVolume').change()
					expect(@psapc.model.get('transferVolume')).toEqual 6
				it "should update the hitSDThreshold ", ->
					@psapc.$('.bv_hitSDThreshold').val(' 24 ')
					@psapc.$('.bv_hitSDThreshold').change()
					expect(@psapc.model.get('hitSDThreshold')).toEqual 24
				it "should update the hitEfficacyThreshold ", ->
					@psapc.$('.bv_hitEfficacyThreshold').val(' 25 ')
					@psapc.$('.bv_hitEfficacyThreshold').change()
					expect(@psapc.model.get('hitEfficacyThreshold')).toEqual 25
				it "should update the positiveControl ", ->
					@psapc.$('.bv_positiveControlBatch').val(' pos cont ')
					@psapc.$('.bv_positiveControlBatch').change()
					expect(@psapc.model.get('positiveControl').get('batchCode')).toEqual "pos cont"
				it "should update the positiveControl conc ", ->
					@psapc.$('.bv_positiveControlConc').val(' 250753.77 ')
					@psapc.$('.bv_positiveControlConc').change()
					expect(@psapc.model.get('positiveControl').get('concentration')).toEqual 250753.77
				it "should update the negativeControl ", ->
					@psapc.$('.bv_negativeControlBatch').val(' neg cont ')
					@psapc.$('.bv_negativeControlBatch').change()
					expect(@psapc.model.get('negativeControl').get('batchCode')).toEqual "neg cont"
				it "should update the negativeControl conc ", ->
					@psapc.$('.bv_negativeControlConc').val(' 62 ')
					@psapc.$('.bv_negativeControlConc').change()
					expect(@psapc.model.get('negativeControl').get('concentration')).toEqual 62
				it "should update the vehicleControl ", ->
					@psapc.$('.bv_vehicleControlBatch').val(' veh cont ')
					@psapc.$('.bv_vehicleControlBatch').change()
					expect(@psapc.model.get('vehicleControl').get('batchCode')).toEqual "veh cont"
				it "should update the agonistControl", ->
					@psapc.$('.bv_agonistControlBatch').val(' ag cont ')
					@psapc.$('.bv_agonistControlBatch').change()
					expect(@psapc.model.get('agonistControl').get('batchCode')).toEqual "ag cont"
				it "should update the agonistControl conc", ->
					@psapc.$('bv_agonistControlConc').val(' 2 ')
					@psapc.$('.bv_agonistControlConc').change()
					expect(@psapc.model.get('agonistControl').get('concentration')).toEqual 250753.77
				it "should update the thresholdType ", ->
					@psapc.$('.bv_thresholdTypeEfficacy').click()
					expect(@psapc.model.get('thresholdType')).toEqual "efficacy"
				it "should update the volumeType ", ->
					@psapc.$('.bv_volumeTypeTransfer').click()
					expect(@psapc.model.get('volumeType')).toEqual "transfer"
				it "should update the autoHitSelection ", ->
					@psapc.$('.bv_autoHitSelection').click()
					expect(@psapc.model.get('autoHitSelection')).toBeTruthy()
				it "should update the htsFormat checkbox ", ->
					@psapc.$('.bv_htsFormat').click()
					expect(@psapc.model.get('htsFormat')).toBeTruthy()
				it "should update the matchReadName checkbox ", ->
					@psapc.$('.bv_matchReadName').click()
					@psapc.$('.bv_matchReadName').click()
					expect(@psapc.model.get('matchReadName')).toBeTruthy()
					#don't know why matcchReadName needs to be clicked twice for spec to pass but the implementation is correct
			describe "behavior and validation", ->
				it "should disable read position field if match read name is selected", ->
					@psapc.$('.bv_matchReadName').click()
					@psapc.$('.bv_matchReadName').click()
					expect(@psapc.$('.bv_readPosition').attr("disabled")).toEqual "disabled"
				it "should enable read position field if match read name is not selected", ->
					expect(@psapc.$('.bv_readPosition').attr("disabled")).toBeUndefined()
				it "should disable sd threshold field if that radio not selected", ->
					@psapc.$('.bv_thresholdTypeEfficacy').click()
					expect(@psapc.$('.bv_hitSDThreshold').attr("disabled")).toEqual "disabled"
					expect(@psapc.$('.bv_hitEfficacyThreshold').attr("disabled")).toBeUndefined()
				it "should disable efficacy threshold field if that radio not selected", ->
					@psapc.$('.bv_thresholdTypeEfficacy').click()
					@psapc.$('.bv_thresholdTypeSD').click()
					expect(@psapc.$('.bv_hitEfficacyThreshold').attr("disabled")).toEqual "disabled"
					expect(@psapc.$('.bv_hitSDThreshold').attr("disabled")).toBeUndefined()
				it "should disable dilutionFactor field if that radio not selected", ->
					@psapc.$('.bv_volumeTypeTransfer').click()
					expect(@psapc.$('.bv_dilutionFactor').attr("disabled")).toEqual "disabled"
					expect(@psapc.$('.bv_transferVolume').attr("disabled")).toBeUndefined()
				it "should disable transferVolume if that radio not selected", ->
					@psapc.$('.bv_volumeTypeTransfer').click()
					@psapc.$('.bv_volumeTypeDilution').click()
					expect(@psapc.$('.bv_transferVolume').attr("disabled")).toEqual "disabled"
					expect(@psapc.$('.bv_dilutionFactor').attr("disabled")).toBeUndefined()
		describe "validation testing", ->
			beforeEach ->
				@psapc = new PrimaryScreenAnalysisParametersController
					model: new PrimaryScreenAnalysisParameters window.primaryScreenTestJSON.primaryScreenAnalysisParameters
					el: $('#fixture')
				@psapc.render()
			describe "error notification", ->
				it "should show error if positiveControl batch is not set", ->
					@psapc.$('.bv_positiveControlBatch').val ""
					@psapc.$('.bv_positiveControlBatch').change()
					expect(@psapc.$('.bv_group_positiveControlBatch').hasClass("error")).toBeTruthy()
				it "should show error if positiveControl conc is not set", ->
					@psapc.$('.bv_positiveControlConc').val ""
					@psapc.$('.bv_positiveControlConc').change()
					expect(@psapc.$('.bv_group_positiveControlConc').hasClass("error")).toBeTruthy()
				it "should show error if negativeControl batch is not set", ->
					@psapc.$('.bv_negativeControlBatch').val ""
					@psapc.$('.bv_negativeControlBatch').change()
					expect(@psapc.$('.bv_group_negativeControlBatch').hasClass("error")).toBeTruthy()
				it "should show error if negativeControl conc is not set", ->
					@psapc.$('.bv_negativeControlConc').val ""
					@psapc.$('.bv_negativeControlConc').change()
					expect(@psapc.$('.bv_group_negativeControlConc').hasClass("error")).toBeTruthy()
				it "should not show error if agonistControl batch and conc are not set", ->
					@psapc.$('.bv_agonistControlBatch').val ""
					@psapc.$('.bv_agonistControlBatch').change()
					@psapc.$('.bv_agonistControlConc').val ""
					@psapc.$('.bv_agonistControlConc').change()
					expect(@psapc.$('.bv_group_agonistControlBatch').hasClass("error")).toBeFalsy()
					expect(@psapc.$('.bv_group_agonistControlConc').hasClass("error")).toBeFalsy()
				it "should not show error if agonistControl batch and conc are set correctly", ->
					@psapc.$('.bv_agonistControlBatch').val "CMPD-12345678-01"
					@psapc.$('.bv_agonistControlBatch').change()
					@psapc.$('.bv_agonistControlConc').val 12
					@psapc.$('.bv_agonistControlConc').change()
					expect(@psapc.$('.bv_group_agonistControlBatch').hasClass("error")).toBeFalsy()
					expect(@psapc.$('.bv_group_agonistControlConc').hasClass("error")).toBeFalsy()
				it "should show error if agonistControl batch is correct but conc is NaN or empty", ->
					@psapc.$('.bv_agonistControlBatch').val "CMPD-12345678-01"
					@psapc.$('.bv_agonistControlBatch').change()
					@psapc.$('.bv_agonistControlConc').val ""
					@psapc.$('.bv_agonistControlConc').change()
					expect(@psapc.$('.bv_group_agonistControlBatch').hasClass("error")).toBeFalsy()
					expect(@psapc.$('.bv_group_agonistControlConc').hasClass("error")).toBeTruthy()
				it "should show error if agonistControl batch is empty but conc is a number", ->
					@psapc.$('.bv_agonistControlBatch').val ""
					@psapc.$('.bv_agonistControlBatch').change()
					@psapc.$('.bv_agonistControlConc').val 23
					@psapc.$('.bv_agonistControlConc').change()
					expect(@psapc.$('.bv_group_agonistControlBatch').hasClass("error")).toBeTruthy()
					expect(@psapc.$('.bv_group_agonistControlConc').hasClass("error")).toBeFalsy()
				it "should not show error if vehicleControl is not set", ->
					@psapc.$('.bv_vehicleControlBatch').val ""
					@psapc.$('.bv_vehicleControlBatch').change()
					expect(@psapc.$('.bv_group_vehicleControlBatch').hasClass("error")).toBeFalsy()
				it "should not show error if instrumentReader is unassigned", ->
					waitsFor ->
						@psapc.$('.bv_instrumentReader option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_instrumentReader').val "unassigned"
						@psapc.$('.bv_instrumentReader').change()
						expect(@psapc.$('.bv_group_instrumentReader').hasClass("error")).toBeFalsy()
				it "should show error if signal direction rule is unassigned", ->
					waitsFor ->
						@psapc.$('.bv_signalDirectionRule option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_signalDirectionRule').val "unassigned"
						@psapc.$('.bv_signalDirectionRule').change()
						expect(@psapc.$('.bv_group_signalDirectionRule').hasClass("error")).toBeTruthy()
				it "should show error if aggregateBy1 is unassigned", ->
					waitsFor ->
						@psapc.$('.bv_aggregateBy1 option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_aggregateBy1').val "unassigned"
						@psapc.$('.bv_aggregateBy1').change()
						expect(@psapc.$('.bv_group_aggregateBy1').hasClass("error")).toBeTruthy()
				it "should show error if aggregateBy2 is unassigned", ->
					waitsFor ->
						@psapc.$('.bv_aggregateBy2 option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_aggregateBy2').val "unassigned"
						@psapc.$('.bv_aggregateBy2').change()
						expect(@psapc.$('.bv_group_aggregateBy2').hasClass("error")).toBeTruthy()
				it "should show error if normalizationRule is unassigned", ->
					waitsFor ->
						@psapc.$('.bv_normalizationRule option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_normalizationRule').val "unassigned"
						@psapc.$('.bv_normalizationRule').change()
						expect(@psapc.$('.bv_group_normalizationRule').hasClass("error")).toBeTruthy()
				it "should show error if threshold type is efficacy and efficacy threshold not a number", ->
					@psapc.$('.bv_thresholdTypeEfficacy').click()
					@psapc.$('.bv_hitEfficacyThreshold').val ""
					@psapc.$('.bv_hitEfficacyThreshold').change()
					expect(@psapc.$('.bv_group_hitEfficacyThreshold').hasClass("error")).toBeTruthy()
				it "should show error if threshold type is sd and sd threshold not a number", ->
					@psapc.$('.bv_thresholdTypeSD').click()
					@psapc.$('.bv_hitSDThreshold').val ""
					@psapc.$('.bv_hitSDThreshold').change()
					expect(@psapc.$('.bv_group_hitSDThreshold').hasClass("error")).toBeTruthy()
				it "should show error if volume type is transferVolume and transferVolume not a number (but can be empty)", ->
					@psapc.$('.bv_volumeTypeTransfer').click()
					@psapc.$('.bv_transferVolume').val "hello"
					@psapc.$('.bv_transferVolume').change()
					expect(@psapc.$('.bv_group_transferVolume').hasClass("error")).toBeTruthy()
				it "should not show error if volume type is transferVolume and transferVolume is empty", ->
					@psapc.$('.bv_volumeTypeTransfer').click()
					@psapc.$('.bv_transferVolume').val ""
					@psapc.$('.bv_transferVolume').change()
					expect(@psapc.$('.bv_group_transferVolume').hasClass("error")).toBeFalsy()
				it "should show error if volume type is dilutionFactor and dilutionFactor not a number (but can be empty)", ->
					@psapc.$('.bv_volumeTypeDilution').click()
					@psapc.$('.bv_dilutionFactor').val "hello again"
					@psapc.$('.bv_dilutionFactor').change()
					expect(@psapc.$('.bv_group_dilutionFactor').hasClass("error")).toBeTruthy()
				it "should not show error if volume type is dilutionFactor and dilutionFactor is empty", ->
					@psapc.$('.bv_volumeTypeDilution').click()
					@psapc.$('.bv_dilutionFactor').val ""
					@psapc.$('.bv_dilutionFactor').change()
					expect(@psapc.$('.bv_group_dilutionFactor').hasClass("error")).toBeFalsy()
				it "should show error if assayVolume is NaN", ->
					@psapc.$('.bv_assayVolume').val "b"
					@psapc.$('.bv_assayVolume').change()
					expect(@psapc.$('.bv_group_assayVolume').hasClass("error")).toBeTruthy()
				it "should not show error if assayVolume, dilutionFactor, and transferVolume are empty", ->
					@psapc.$('.bv_assayVolume').val ""
					@psapc.$('.bv_assayVolume').change()
					@psapc.$('.bv_dilutionFactor').val ""
					@psapc.$('.bv_dilutionFactor').change()
					@psapc.$('.bv_transferVolume').val ""
					@psapc.$('.bv_transferVolume').change()
					expect(@psapc.$('.bv_group_assayVolume').hasClass("error")).toBeFalsy()
				it "should not show error on read position if match read name is checked", ->
					@psapc.$('.bv_matchReadName').click()
					expect(@psapc.$('bv_group_readPosition').hasClass("error")).toBeFalsy()
				it "should show error if readPosition is NaN", ->
					@psapc.$('.bv_readPosition:eq(0)').val ""
					@psapc.$('.bv_readPosition:eq(0)').change()
					expect(@psapc.$('.bv_group_readPosition:eq(0)').hasClass("error")).toBeTruthy()
				it "should show error if read name is unassigned", ->
					waitsFor ->
						@psapc.$('.bv_readName option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_readName:eq(0)').val "unassigned"
						@psapc.$('.bv_readName:eq(0)').change()
						expect(@psapc.$('.bv_group_readName').hasClass("error")).toBeTruthy()
				it "should show error if transformation rule is unassigned", ->
					waitsFor ->
						@psapc.$('.bv_transformationRule option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_transformationRule:eq(0)').val "unassigned"
						@psapc.$('.bv_transformationRule:eq(0)').change()
						expect(@psapc.$('.bv_group_transformationRule:eq(0)').hasClass("error")).toBeTruthy()
				it "should show error if a transformation rule is selected more than once", ->
					@psapc.$('.bv_addTransformationButton').click()
					waitsFor ->
						@psapc.$('.bv_transformationInfo .bv_transformationRule option').length > 0
					, 1000
					runs ->
						@psapc.$('.bv_transformationRule:eq(0)').val "sd"
						@psapc.$('.bv_transformationRule:eq(0)').change()
						@psapc.$('.bv_transformationRule:eq(1)').val "sd"
						@psapc.$('.bv_transformationRule:eq(1)').change()
						expect(@psapc.$('.bv_group_transformationRule:eq(0)').hasClass('error')).toBeTruthy()
						expect(@psapc.$('.bv_group_transformationRule:eq(1)').hasClass('error')).toBeTruthy()


	describe "Abstract Upload and Run Primary Analysis Controller testing", ->
		describe "Basic loading", ->
			it "Class should exist", ->
				expect(window.AbstractUploadAndRunPrimaryAnalsysisController).toBeDefined()

	describe "Upload and Run Primary Analysis Controller testing", ->
		beforeEach ->
			@exp = new PrimaryScreenExperiment()
			@uarpac = new UploadAndRunPrimaryAnalsysisController
				el: $('#fixture')
				paramsFromExperiment:	@exp.getAnalysisParameters()
			@uarpac.render()

		describe "Basic loading", ->
			it "Class should exist", ->
				expect(@uarpac).toBeDefined()
			it "Should load the template", ->
				expect(@uarpac.$('.bv_parseFile').length).toNotEqual 0

	describe "Primary Screen Analysis Controller testing", ->
		describe "basic plumbing checks with experiment copied from template", ->
			beforeEach ->
				@exp = new PrimaryScreenExperiment()
				@exp.copyProtocolAttributes new Protocol JSON.parse(JSON.stringify(window.protocolServiceTestJSON.fullSavedProtocol))
				@psac = new PrimaryScreenAnalysisController
					model: @exp
					el: $('#fixture')
					uploadAndRunControllerName: "UploadAndRunPrimaryAnalsysisController"
				@psac.render()
			describe "Basic loading", ->
				it "Class should exist", ->
					expect(@psac).toBeDefined
				it "Should load the template", ->
					expect(@psac.$('.bv_analysisStatus').length).toNotEqual 0
			describe "display logic", ->
				it "should show analysis status not started becuase this is a new experiment", ->
					expect(@psac.$('.bv_analysisStatus').html()).toEqual "not started"
				it "should not show analysis results becuase this is a new experiment", ->
					expect(@psac.$('.bv_analysisResultsHTML').html()).toEqual ""
					expect(@psac.$('.bv_resultsContainer')).toBeHidden()
				it "should be able to hide data analysis controller", ->
					@psac.setExperimentNotSaved()
					expect(@psac.$('.bv_fileUploadWrapper')).toBeHidden()
					expect(@psac.$('.bv_saveExperimentToAnalyze')).toBeVisible()
				it "should be able to show data analysis controller", ->
					@psac.setExperimentSaved()
					expect(@psac.$('.bv_fileUploadWrapper')).toBeVisible()
					expect(@psac.$('.bv_saveExperimentToAnalyze')).toBeHidden()
		describe "experiment status locks analysis", ->
			beforeEach ->
				@exp = new PrimaryScreenExperiment window.experimentServiceTestJSON.fullExperimentFromServer
				@psac = new PrimaryScreenAnalysisController
					model: @exp
					el: $('#fixture')
					uploadAndRunControllerName: "UploadAndRunPrimaryAnalsysisController"
				@psac.render()
			it "Should disable analsyis parameter editing if status is finalized", ->
				@psac.model.getStatus().set stringValue: "finalized"
				expect(@psac.$('.bv_normalizationRule').attr('disabled')).toEqual 'disabled'
			it "Should enable analsyis parameter editing if status is finalized", ->
				@psac.model.getStatus().set stringValue: "finalized"
				@psac.model.getStatus().set stringValue: "started"
				expect(@psac.$('.bv_normalizationRule').attr('disabled')).toBeUndefined()
			it "should show upload button as upload data since status is 'not started'", ->
				expect(@psac.$('.bv_save').html()).toEqual "Upload Data"
		describe "handling re-analysis", ->
			beforeEach ->
				@exp = new PrimaryScreenExperiment window.experimentServiceTestJSON.fullExperimentFromServer
				@exp.getAnalysisStatus().set stringValue: "analsysis complete"
				@psac = new PrimaryScreenAnalysisController
					model: @exp
					el: $('#fixture')
					uploadAndRunControllerName: "UploadAndRunPrimaryAnalsysisController"
				@psac.render()
			it "should show upload button as re-analyze since status is not 'not started'", ->
				expect(@psac.$('.bv_save').html()).toEqual "Re-Analyze"


	describe "Abstract Primary Screen Experiment Controller testing", ->
		describe "Basic loading", ->
			it "Class should exist", ->
				expect(window.AbstractPrimaryScreenExperimentController).toBeDefined()

	describe "Primary Screen Experiment Controller testing", ->
		describe "basic plumbing checks with new experiment", ->
			beforeEach ->
				@psec = new PrimaryScreenExperimentController
					model: new PrimaryScreenExperiment()
					el: $('#fixture')
				@psec.render()
			describe "Basic loading", ->
				it "Class should exist", ->
					expect(@psec).toBeDefined()
				it "Should load the template", ->
					expect(@psec.$('.bv_experimentBase').length).toNotEqual 0
				it "Should load a base experiment controller", ->
					expect(@psec.$('.bv_experimentBase .bv_experimentName').length).toNotEqual 0
				it "Should load an analysis controller", ->
					expect(@psec.$('.bv_primaryScreenDataAnalysis .bv_analysisStatus').length).toNotEqual 0
				#TODO this spec is not running because prod IFF does not include a fit module yet
				xit "Should load a dose response controller", ->
					expect(@psec.$('.bv_doseResponseAnalysis .bv_fitModelButton').length).toNotEqual 0




#TODO Validation rules for different threshold modes






exports.requiredScripts = [
	'/src/lib/jquery.min.js',
	'/src/lib/json2.js',
	'/src/lib/underscore.js',
	'/src/lib/backbone-min.js',
	'/src/lib/bootstrap/bootstrap-tooltip.js',
	'/src/lib/bootstrap-tagsinput/bootstrap-tagsinput.min.js',
	'/src/lib/jqueryFileUpload/js/vendor/jquery.ui.widget.js',
	'/src/lib/jqueryFileUpload/js/jquery.iframe-transport.js',
	'/src/lib/bootstrap/bootstrap.min.js',
	'/src/lib/jqueryFileUpload/tmpl.min.js',
	'/src/lib/jqueryFileUpload/js/jquery.iframe-transport.js',
	'/src/lib/jqueryFileUpload/js/jquery.fileupload.js',
	'/src/lib/jqueryFileUpload/js/jquery.fileupload-fp.js',
	'/src/lib/jqueryFileUpload/js/jquery.fileupload-ui.js',
	'/src/lib/jqueryFileUpload/js/locale.js',
	'/src/lib/jquery-ui-1.10.2.custom/js/jquery-ui-1.10.2.custom.min.js',
	'/src/lib/dataTables/js/jquery.dataTables.js',
	'/src/lib/jstree/jstree.min.js'
];

exports.applicationScripts = [
	'/src/conf/conf.js',
	"/javascripts/src/UtilityFunctions.js",
	'/javascripts/src/LSFileInput.js',
	'/javascripts/src/LSFileChooser.js',
	'/javascripts/src/LSErrorNotification.js',
	'/javascripts/src/AbstractFormController.js',
	'/javascripts/src/AbstractParserFormController.js',
	'/javascripts/src/BasicFileValidateAndSave.js',
	'/javascripts/src/PickList.js',
	'/javascripts/src/Label.js',
	'/javascripts/src/AnalysisGroup.js',
	'/javascripts/src/Experiment.js',
	'/javascripts/src/Protocol.js',
	"/javascripts/src/PrimaryScreenExperiment.js",
	"/javascripts/src/AppController.js",
	"/javascripts/src/BatchListValidator.js",
	"/javascripts/src/BulkLoadContainersFromSDF.js",
	"/javascripts/src/BulkLoadSampleTransfers.js",
	"/javascripts/src/CurveCurator.js",
	"/javascripts/src/CurveCuratorAppController.js",
	"/javascripts/src/DocForBatches.js",
	"/javascripts/src/DocForBatchesConfiguration.js",
	"/javascripts/src/DocUpload.js",
	"/javascripts/src/DoseResponseAnalysis.js",
	"/javascripts/src/DoseResponseFit.js",
	"/javascripts/src/ExperimentBrowser.js",
	"/javascripts/src/GeneDataQueries.js",
	"/javascripts/src/GenericDataParser.js",
	"/javascripts/src/ModuleLauncher.js",
	"/javascripts/src/ModuleMenus.js",
	"/javascripts/src/ModuleMenusConfiguration.js",
	"/javascripts/src/PrimaryScreenAppController.js",
	"/javascripts/src/TagList.js"
];

exports.jasmineScripts = [
	'src/lib/testLibraries/jasmine-jstd-adapter/jasmine/lib/jasmine-core/jasmine.js',
	'src/lib/testLibraries/jasmine-jstd-adapter/jasmine/lib/jasmine-core/jasmine-html.js',
	'src/lib/testLibraries/jasmine-jquery/lib/jasmine-jquery.js',
	'src/lib/testLibraries/sinon.js'
];

exports.specScripts = [
	'src/modules/DocForBatches/spec/testFixtures/testJSON.js',
	'javascripts/spec/ExperimentSpec.js',
	'javascripts/spec/BatchListValidatorSpec.js',
	'javascripts/spec/DocUploadSpec.js',
	'javascripts/spec/DocForBatchesSpec.js',
	"/src/modules/Components/spec/testFixtures/TagListTestJSON.js",
	"/src/modules/Components/spec/testFixtures/projectServiceTestJSON.js",
	"/src/modules/DocForBatches/spec/testFixtures/testJSON.js",
	"/javascripts/spec/testFixtures/CodeTableJSON.js",
	"/javascripts/spec/testFixtures/CurveAnalysisCodeTableTestJSON.js",
	"/javascripts/spec/testFixtures/CurveFitTestFixtures.js",
	"/javascripts/spec/testFixtures/CurveFitTestJSON.js",
	"/javascripts/spec/testFixtures/ExperimentCodeTableTestJSON.js",
	"/javascripts/spec/testFixtures/ExperimentServiceTestJSON.js",
	"/javascripts/spec/testFixtures/FullPKTestJSON.js",
	"/javascripts/spec/testFixtures/GeneDataQueriesTestJson.js",
	"/javascripts/spec/testFixtures/LoginTestJSON.js",
	"/javascripts/spec/testFixtures/MetStabTestJSON.js",
	"/javascripts/spec/testFixtures/MicroSolTestJSON.js",
	"/javascripts/spec/testFixtures/ModuleMenusTestJSON.js",
	"/javascripts/spec/testFixtures/PampaTestJSON.js",
	"/javascripts/spec/testFixtures/PrimaryScreenCodeTableTestJSON.js",
	"/javascripts/spec/testFixtures/PrimaryScreenTestJSON.js",
	"/javascripts/spec/testFixtures/ProtocolServiceTestJSON.js",
	"/javascripts/spec/testFixtures/curveCuratorTestFixtures.js",
	"/src/modules/DocForBatches/spec/DocForBatchesSpec.js",
	"/src/modules/ExperimentBrowser/spec/ProtocolStub.js",
	"/javascripts/spec/AbstractFormControllerSpec.js",
	"/javascripts/spec/AnalysisGroupSpec.js",
	"/javascripts/spec/AuthenticationServiceSpec.js",
	"/javascripts/spec/BulkLoadContainersFromSDFServerSpec.js",
	"/javascripts/spec/BulkLoadContainersFromSDFSpec.js",
	"/javascripts/spec/BulkLoadSampleTransfersServerSpec.js",
	"/javascripts/spec/BulkLoadSampleTransfersSpec.js",
	"/javascripts/spec/CodeTableServiceSpec.js",
	"/javascripts/spec/CurveCuratorServiceSpec.js",
	"/javascripts/spec/CurveCuratorSpec.js",
	"/javascripts/spec/DocForBatchesServiceSpec.js",
	"/javascripts/spec/DoseResponseAnalysisSpec.js",
	"/javascripts/spec/DoseResponseFitServiceSpec.js",
	"/javascripts/spec/DoseResponseFitSpec.js",
	"/javascripts/spec/ExperimentBrowserSpec.js",
	"/javascripts/spec/ExperimentServiceSpec.js",
	"/javascripts/spec/GeneDataQueriesServiceSpec.js",
	"/javascripts/spec/GeneDataQueriesSpec.js",
	"/javascripts/spec/GenericDataParserServiceSpec.js",
	"/javascripts/spec/GenericDataParserSpec.js",
	"/javascripts/spec/LSErrorNotificationSpec.js",
	"/javascripts/spec/LSFileChooserSpec.js",
	"/javascripts/spec/LSFileInputSpec.js",
	"/javascripts/spec/LabelSpec.js",
	"/javascripts/spec/ModuleLauncherSpec.js",
	"/javascripts/spec/ModuleMenusSpec.js",
	"/javascripts/spec/PickListSpec.js",
	"/javascripts/spec/PreferredBatchIdServiceSpec.js",
	"/javascripts/spec/PrimaryScreenExperimentSpec.js",
	"/javascripts/spec/ProjectsServiceSpec.js",
	"/javascripts/spec/ProtocolServiceSpec.js",
	"/javascripts/spec/ProtocolSpec.js",
	"/javascripts/spec/RunPrimaryScreenAnalysisServiceSpec.js",
	"/javascripts/spec/ServerUtilityFunctionsSpec.js",
	"/javascripts/spec/TagListSpec.js",
	"/javascripts/spec/UtilityFunctionsSpec.js",
	"/javascripts/spec/dnsAuthenticationServiceSpec.js"
]

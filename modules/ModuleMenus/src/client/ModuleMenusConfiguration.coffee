window.ModuleMenusConfiguration =
	[
		isHeader: true
		menuName: "Load Data"
	,
		isHeader: false
		menuName: "Load Experiment"
		mainControllerClassName: "GenericDataParserController"
		autoLaunchName:"generic_data_parser"
	,
		isHeader: false
		menuName: "Dose-Response Fit"
		mainControllerClassName: "DoseResponseFitWorkflowController"
	,
		isHeader: false
		menuName: "Protocol Base"
		mainControllerClassName: "ProtocolBaseController"
		autoLaunchName:"protocol_base"
	,
		isHeader: false
		menuName: "Primary Screen Protocol"
		mainControllerClassName: "PrimaryScreenProtocolModuleController"
		autoLaunchName:"primary_screen_protocol"
	,
		isHeader: false
		menuName: "Experiment Base"
		mainControllerClassName: "ExperimentBaseController"
		autoLaunchName:"experiment_base"
	,
		isHeader: false
		menuName: "Primary Screen Experiment"
		mainControllerClassName: "PrimaryScreenExperimentController"
		autoLaunchName:"primary_screen_experiment"
	,
		isHeader: false
		menuName: "Data Viewer"
#		mainControllerClassName: "PrimaryScreenExperimentController"
		autoLaunchName:"dataViewer"
	,
		isHeader: false, menuName: "Example Thing"
		mainControllerClassName: "ExampleThingController"
		autoLaunchName:"cationic_block"
	,
		isHeader: true
		menuName: "Inventory"
	,
		isHeader: false
		menuName: "Load Containers From SDF"
		mainControllerClassName: "BulkLoadContainersFromSDFController"
	,
		isHeader: false
		menuName: "Load Sample Transfer Log"
		mainControllerClassName: "BulkLoadSampleTransfersController"
	,
		isHeader: true
		menuName: "Search and Edit"
	,
		isHeader: false, menuName: "Protocol Browser"
		mainControllerClassName: "ProtocolBrowserController"
	,
		isHeader: false, menuName: "Experiment Browser"
		mainControllerClassName: "ExperimentBrowserController"
	,
		isHeader: true
		menuName: "Admin"
	,
		isHeader: false
		menuName: "Admin Panel"
		mainControllerClassName: "AdminPanelController"
		autoLaunchName: "admin_panel"
	,
		isHeader: false, menuName: "Logging"
		mainControllerClassName: "LoggingController"
	]
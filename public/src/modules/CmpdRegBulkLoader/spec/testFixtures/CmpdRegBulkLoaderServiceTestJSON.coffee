((exports) ->
	exports.propertiesList =
	{
		"sdfProperties":[
			{"name":"prop1", "dataType":"double"},
			{"name":"prop2", "dataType":"text"},
			{"name":"prop3", "dataType":"date"},
			{"name":"prop4", "dataType":"integer"},
			{"name":"prop5", "dataType":"double"}
		]
		,
		"dbProperties":
			[
				{"name":"db1", "dataType":"double", "required": true, "displayOrder":1},
				{"name":"db2", "dataType":"text", "required": true, "displayOrder":2},
				{"name":"db3", "dataType":"date", "required": true, "displayOrder":3},
				{"name":"db4", "dataType":"integer", "required": true, "displayOrder":4},
				{"name":"db5", "dataType":"double", "required": false, "displayOrder":5}
			]
		,
		"autoMagicProperties":[
			{"dbProperty": "db1", "sdfProperty":"prop1" , required: true },
			{"dbProperty": "db2", "sdfProperty":"prop2" , required: true }
		]
	}

	exports.propertiesList2 =
	{
		"sdfProperties":[
			{"name":"prop1", "dataType":"double"},
			{"name":"prop2", "dataType":"text"},
			{"name":"prop3", "dataType":"date"},
			{"name":"prop4", "dataType":"integer"},
			{"name":"prop5", "dataType":"double"}
			{"name":"prop6", "dataType":"double"},
			{"name":"prop7", "dataType":"text"},
			{"name":"prop8", "dataType":"date"},
			{"name":"prop9", "dataType":"integer"},
			{"name":"prop10", "dataType":"double"}
		]
		,
		"dbProperties":
			[
				{"name":"db1", "dataType":"double", "required": true, "displayOrder":1},
				{"name":"db2", "dataType":"text", "required": true, "displayOrder":2},
				{"name":"db3", "dataType":"date", "required": true, "displayOrder":3},
				{"name":"db4", "dataType":"integer", "required": true, "displayOrder":4},
				{"name":"db5", "dataType":"double", "required": false, "displayOrder":5}
				{"name":"db6", "dataType":"double", "required": false, "displayOrder":1},
				{"name":"db7", "dataType":"text", "required": false, "displayOrder":2},
				{"name":"db8", "dataType":"date", "required": false, "displayOrder":3},
				{"name":"db9", "dataType":"integer", "required": true, "displayOrder":4},
				{"name":"db10", "dataType":"double", "required": true, "displayOrder":5}
			]
		,
		"autoMagicProperties":[
			{"dbProperty": "db1", "sdfProperty":"prop1" , required: true },
			{"dbProperty": "db2", "sdfProperty":"prop2" , required: true }
			{"dbProperty": "db9", "sdfProperty":"prop9" , required: true },
			{"dbProperty": "db10", "sdfProperty":"prop10" , required: true }
		]
	}

	exports.propertiesList3 =
	{
		"sdfProperties":[
			{"name":"prop1", "dataType":"double"},
			{"name":"prop2", "dataType":"text"},
			{"name":"prop3", "dataType":"date"},
			{"name":"prop4", "dataType":"integer"},
			{"name":"prop5", "dataType":"double"}
			{"name":"prop6", "dataType":"double"},
			{"name":"prop7", "dataType":"text"},
			{"name":"prop8", "dataType":"date"},
			{"name":"prop9", "dataType":"integer"},
			{"name":"prop10", "dataType":"double"}
		]
		,
		"dbProperties":
			[
				{"name":"db1", "dataType":"double", "required": true, "displayOrder":1},
				{"name":"db2", "dataType":"text", "required": true, "displayOrder":2},
				{"name":"db3", "dataType":"date", "required": true, "displayOrder":3},
				{"name":"db4", "dataType":"integer", "required": true, "displayOrder":4},
				{"name":"db5", "dataType":"double", "required": true, "displayOrder":5}
				{"name":"db6", "dataType":"double", "required": true, "displayOrder":1},
				{"name":"db7", "dataType":"text", "required": false, "displayOrder":2},
				{"name":"db8", "dataType":"date", "required": false, "displayOrder":3},
				{"name":"db9", "dataType":"integer", "required": false, "displayOrder":4},
				{"name":"db10", "dataType":"double", "required": false, "displayOrder":5}
			]
		,
		"autoMagicProperties":[
			{"dbProperty": "db1", "sdfProperty":"prop1" , required: true },
			{"dbProperty": "db2", "sdfProperty":"prop2" , required: true }
			{"dbProperty": "db9", "sdfProperty":"prop9" , required: false },
			{"dbProperty": "db10", "sdfProperty":"prop10" , required: false }
		]
	}

) (if (typeof process is "undefined" or not process.versions) then window.cmpdRegBulkLoaderServiceTestJSON = window.cmpdRegBulkLoaderServiceTestJSON or {} else exports)

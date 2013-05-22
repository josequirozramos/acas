((exports) ->
	exports.experimentLabels = [
		id: 43
		ignored: false
		imageFile: null
		labelKind: "experiment name"
		labelText: "FLIPR target A biochemical"
		labelType: "name"
		labelTypeAndKind: "name_experiment name"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 47
			recordedDate: 1362435677000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: true
		recordedBy: "userName"
		recordedDate: 1362435678000
		version: 0
	,
		id: 42
		ignored: true
		imageFile: null
		labelKind: "experiment name"
		labelText: "FLIPR target A biochemical old"
		labelType: "name"
		labelTypeAndKind: "name_experiment name"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 48
			recordedDate: 1362435677000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: true
		recordedBy: "userName"
		recordedDate: 1361435678000
		version: 0
	,
		id: 45
		ignored: false
		imageFile: null
		labelKind: "experiment full name"
		labelText: "FLIPR target A biochemical with additional name awesomness"
		labelType: "name"
		labelTypeAndKind: "name_experiment full name"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 49
			recordedDate: 1362435677000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: false
		recordedBy: "userName"
		recordedDate: 1362435678001
		version: 0
	,
		id: 49
		ignored: false
		imageFile: null
		labelKind: ""
		labelText: "AAABBD13343434"
		labelType: "barcode"
		labelTypeAndKind: "barcode_"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 50
			recordedDate: 1362435679000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: false
		recordedBy: "userName"
		recordedDate: 1362435679001
		version: 0
	]

	exports.experimentLabelsNoPreferred = [
		id: 43
		ignored: false
		imageFile: null
		labelKind: "experiment name"
		labelText: "FLIPR target A biochemical"
		labelType: "name"
		labelTypeAndKind: "name_experiment name"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 47
			recordedDate: 1362435677000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: false
		recordedBy: "userName"
		recordedDate: 1362435678000
		version: 0
	,
		id: 42
		ignored: true
		imageFile: null
		labelKind: "experiment name"
		labelText: "FLIPR target A biochemical old"
		labelType: "name"
		labelTypeAndKind: "name_experiment name"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 48
			recordedDate: 1362435677000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: false
		recordedBy: "userName"
		recordedDate: 1361435678000
		version: 0
	,
		id: 45
		ignored: false
		imageFile: null
		labelKind: "experiment full name"
		labelText: "FLIPR target A biochemical with additional name awesomness"
		labelType: "name"
		labelTypeAndKind: "name_experiment full name"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 49
			recordedDate: 1362435677000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: false
		recordedBy: "userName"
		recordedDate: 1362435678001
		version: 0
	,
		id: 49
		ignored: false
		imageFile: null
		labelKind: ""
		labelText: "AAABBD13343434"
		labelType: "barcode"
		labelTypeAndKind: "barcode_"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 50
			recordedDate: 1362435679000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: false
		recordedBy: "userName"
		recordedDate: 1362435679001
		version: 0
	]

	exports.experimentLabelsNoPreferredNoNames = [
		id: 45
		ignored: false
		imageFile: null
		labelKind: "experiment full name"
		labelText: "FLIPR target A biochemical with additional name awesomness"
		labelType: "barcode"
		labelTypeAndKind: "name_experiment full name"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 49
			recordedDate: 1362435677000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: false
		recordedBy: "userName"
		recordedDate: 1362435678001
		version: 0
	,
		id: 49
		ignored: false
		imageFile: null
		labelKind: ""
		labelText: "AAABBD13343434"
		labelType: "barcode"
		labelTypeAndKind: "barcode_"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 50
			recordedDate: 1362435679000
			version: 0
		modifiedDate: null
		physicallyLabled: false
		preferred: false
		recordedBy: "userName"
		recordedDate: 1362435679001
		version: 0
	]

	exports.stubSavedExperiment = [
		codeName: "EXPT-00000046"
		id: 270
		ignored: false
		kind: null
		lsTransaction:
			comments: "protocol 201 transactions"
			id: 179
			recordedDate: 1361600825000
			version: 0

		modifiedBy: null
		modifiedDate: null
		recordedBy: "jmcneil"
		recordedDate: 1361600860000
		shortDescription: "experiment short description goes here"
		version: 0
	]

	exports.experimentToSave =
		ignored: false
		kind: "primary screen experiment"
		modifiedBy: null
		modifiedDate: null
		recordedBy: "jmcneil"
		recordedDate: 1361600860000
		shortDescription: "experiment short description goes here"
		experimentLabels: [
			ignored: false
			imageFile: null
			labelKind: "experiment name"
			labelText: "FLIPR target A biochemical"
			labelType: "name"
			labelTypeAndKind: "name_experiment name"
			modifiedDate: null
			physicallyLabled: false
			preferred: true
			recordedBy: "jmcneil"
			recordedDate: 1362435678000
			version: 0
		]




	exports.fullExperimentFromServer =
		analysisGroups: [
			analysisGroupLabels: []
			analysisGroupStates: [
				analysisGroupValues: [
					clobValue: null
					codeValue: null
					comments: "ok"
					dateValue: null
					fileValue: "exampleUploadedFile.txt"
					id: 258587
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "annotation"
					valueOperator: null
					valueType: "fileValue"
					valueTypeAndKind: "fileValue_annotation"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: "CMPD_1112"
					comments: null
					dateValue: null
					fileValue: null
					id: 258588
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "batch code"
					valueOperator: null
					valueType: "codeValue"
					valueTypeAndKind: "codeValue_batch code"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: null
					comments: null
					dateValue: null
					fileValue: null
					id: 258586
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "document kind"
					valueOperator: null
					valueType: "stringValue"
					valueTypeAndKind: "stringValue_document kind"
					valueUnit: null
					version: 0
				]
				comments: null
				id: 85510
				ignored: false
				lsTransaction:
					comments: "docForBatches upload"
					id: 423
					recordedDate: 1367455531000
					version: 0

				modifiedBy: null
				modifiedDate: null
				recordedBy: "jmcneil"
				recordedDate: 1367455532000
				stateKind: "Document for Batch"
				stateType: "results"
				stateTypeAndKind: "results_Document for Batch"
				version: 0
			,
				analysisGroupValues: [
					clobValue: null
					codeValue: null
					comments: null
					dateValue: null
					fileValue: null
					id: 258591
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "document kind"
					valueOperator: null
					valueType: "stringValue"
					valueTypeAndKind: "stringValue_document kind"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: null
					comments: "good"
					dateValue: null
					fileValue: "exampleUploadedFile.txt"
					id: 258589
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "annotation"
					valueOperator: null
					valueType: "fileValue"
					valueTypeAndKind: "fileValue_annotation"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: "CMPD-0000007-01"
					comments: null
					dateValue: null
					fileValue: null
					id: 258590
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "batch code"
					valueOperator: null
					valueType: "codeValue"
					valueTypeAndKind: "codeValue_batch code"
					valueUnit: null
					version: 0
				]
				comments: null
				id: 85511
				ignored: false
				lsTransaction:
					comments: "docForBatches upload"
					id: 423
					recordedDate: 1367455531000
					version: 0

				modifiedBy: null
				modifiedDate: null
				recordedBy: "jmcneil"
				recordedDate: 1367455532000
				stateKind: "Document for Batch"
				stateType: "results"
				stateTypeAndKind: "results_Document for Batch"
				version: 0
			,
				analysisGroupValues: [
					clobValue: null
					codeValue: "CMPD_1113"
					comments: null
					dateValue: null
					fileValue: null
					id: 258585
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "batch code"
					valueOperator: null
					valueType: "codeValue"
					valueTypeAndKind: "codeValue_batch code"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: null
					comments: null
					dateValue: null
					fileValue: null
					id: 258584
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "document kind"
					valueOperator: null
					valueType: "stringValue"
					valueTypeAndKind: "stringValue_document kind"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: null
					comments: "bad"
					dateValue: null
					fileValue: "exampleUploadedFile.txt"
					id: 258583
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "annotation"
					valueOperator: null
					valueType: "fileValue"
					valueTypeAndKind: "fileValue_annotation"
					valueUnit: null
					version: 0
				]
				comments: null
				id: 85509
				ignored: false
				lsTransaction:
					comments: "docForBatches upload"
					id: 423
					recordedDate: 1367455531000
					version: 0

				modifiedBy: null
				modifiedDate: null
				recordedBy: "jmcneil"
				recordedDate: 1367455532000
				stateKind: "Document for Batch"
				stateType: "results"
				stateTypeAndKind: "results_Document for Batch"
				version: 0
			]
			codeName: "AG-00037424"
			id: 64782
			ignored: false
			recordedBy: "jmcneil"
			recordedDate: 1367455531000
			kind: "ACAS doc for batches"
			lsTransaction:
				comments: "docForBatches upload"
				id: 423
				recordedDate: 1367455531000
				version: 0
		]
		codeName: "EXPT-00000046"
		experimentLabels: [
			id: 43
			ignored: false
			imageFile: null
			labelKind: "experiment name"
			labelText: "FLIPR target A biochemical"
			labelType: "name"
			labelTypeAndKind: "name_experiment name"
			lsTransaction:
				comments: "experiment 502 transactions"
				id: 47
				recordedDate: 1362435677000
				version: 0
			modifiedDate: null
			physicallyLabled: false
			preferred: true
			recordedBy: "userName"
			recordedDate: 1362435678000
			version: 0
		]
		experimentStates: [
			comments: null
			experimentValues: [
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 801
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "(maximum-minimum)/minimum"
				uncertainty: null
				urlValue: null
				valueKind: "data transformation rule"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_data transformation rule"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 803
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "plate order"
				uncertainty: null
				urlValue: null
				valueKind: "normalization rule"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_normalization rule"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 807
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: 0.7
				publicData: true
				recordedDate: 1362435677000
				sigFigs: 1
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "active efficacy threshold"
				valueOperator: null
				valueType: "numericValue"
				valueTypeAndKind: "numericValue_active efficacy threshold"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 805
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "Molecular Dynamics FLIPR"
				uncertainty: null
				urlValue: null
				valueKind: "reader instrument"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_reader instrument"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 806
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: 0.0
				publicData: true
				recordedDate: 1362435677000
				sigFigs: 2
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "curve min"
				valueOperator: null
				valueType: "numericValue"
				valueTypeAndKind: "numericValue_curve min"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 800
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: 100.0
				publicData: true
				recordedDate: 1362435677000
				sigFigs: 2
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "curve max"
				valueOperator: null
				valueType: "numericValue"
				valueTypeAndKind: "numericValue_curve max"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 804
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "FLIPR Min Max"
				uncertainty: null
				urlValue: null
				valueKind: "data source"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_data source"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 802
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: -5.0
				publicData: true
				recordedDate: 1362435677000
				sigFigs: 1
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "active SD threshold"
				valueOperator: null
				valueType: "numericValue"
				valueTypeAndKind: "numericValue_active SD threshold"
				valueUnit: null
				version: 0
			]
			id: 338
			ignored: false
			lsTransaction:
				comments: "experiment 502 transactions"
				id: 47
				recordedDate: 1362435677000
				version: 0

			modifiedBy: null
			modifiedDate: null
			recordedBy: "userName"
			recordedDate: 1362435677000
			stateKind: "experiment analysis parameters"
			stateType: "metadata"
			stateTypeAndKind: "metadata_experiment analysis parameters"
			version: 0
		,
			comments: null
			experimentValues: [
				clobValue: null
				codeValue: "CMPD0000001-1"
				comments: null
				dateValue: null
				fileValue: null
				id: 810
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "batch code"
				valueOperator: null
				valueType: "codeValue"
				valueTypeAndKind: "codeValue_batch code"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 808
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: 0.0
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "control tested concentration"
				valueOperator: null
				valueType: "numericValue"
				valueTypeAndKind: "numericValue_control tested concentration"
				valueUnit: "uM"
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 809
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "vehicle control"
				uncertainty: null
				urlValue: null
				valueKind: "control type"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_control type"
				valueUnit: null
				version: 0
			]
			id: 339
			ignored: false
			lsTransaction:
				comments: "experiment 502 transactions"
				id: 47
				recordedDate: 1362435677000
				version: 0

			modifiedBy: null
			modifiedDate: null
			recordedBy: "userName"
			recordedDate: 1362435677000
			stateKind: "experiment controls"
			stateType: "metadata"
			stateTypeAndKind: "metadata_experiment controls"
			version: 0
		,
			comments: null
			experimentValues: [
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 813
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "negative control"
				uncertainty: null
				urlValue: null
				valueKind: "control type"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_control type"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 811
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: 1.0
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "control tested concentration"
				valueOperator: null
				valueType: "numericValue"
				valueTypeAndKind: "numericValue_control tested concentration"
				valueUnit: "uM"
				version: 0
			,
				clobValue: null
				codeValue: "CMPD0000002-1"
				comments: null
				dateValue: null
				fileValue: null
				id: 812
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "batch code"
				valueOperator: null
				valueType: "codeValue"
				valueTypeAndKind: "codeValue_batch code"
				valueUnit: null
				version: 0
			]
			id: 340
			ignored: false
			lsTransaction:
				comments: "experiment 502 transactions"
				id: 47
				recordedDate: 1362435677000
				version: 0

			modifiedBy: null
			modifiedDate: null
			recordedBy: "userName"
			recordedDate: 1362435677000
			stateKind: "experiment controls"
			stateType: "metadata"
			stateTypeAndKind: "metadata_experiment controls"
			version: 0
		,
			comments: null
			experimentValues: [
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 799
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: 10.0
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "control tested concentration"
				valueOperator: null
				valueType: "numericValue"
				valueTypeAndKind: "numericValue_control tested concentration"
				valueUnit: "uM"
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 798
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "positive control"
				uncertainty: null
				urlValue: null
				valueKind: "control type"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_control type"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: "CMPD1234567-1"
				comments: null
				dateValue: null
				fileValue: null
				id: 797
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				valueKind: "batch code"
				valueOperator: null
				valueType: "codeValue"
				valueTypeAndKind: "codeValue_batch code"
				valueUnit: null
				version: 0
			]
			id: 337
			ignored: false
			lsTransaction:
				comments: "experiment 502 transactions"
				id: 47
				recordedDate: 1362435677000
				version: 0

			modifiedBy: null
			modifiedDate: null
			recordedBy: "userName"
			recordedDate: 1362435677000
			stateKind: "experiment controls"
			stateType: "metadata"
			stateTypeAndKind: "metadata_experiment controls"
			version: 0
		,
			comments: null
			experimentValues: [
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 814
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "target A"
				uncertainty: null
				urlValue: null
				valueKind: "target"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_target"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 816
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "active"
				uncertainty: null
				urlValue: null
				valueKind: "experiment status"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_experiment status"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 817
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "biochemical"
				uncertainty: null
				urlValue: null
				valueKind: "assay format"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_assay format"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 815
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "NB 1234-123"
				uncertainty: null
				urlValue: null
				valueKind: "notebook"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_notebook"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 2815
				ignored: false
				lsTransaction:
					comments: "experiment 502 transactions"
					id: 47
					recordedDate: 1362435677000
					version: 0

				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1362435677000
				sigFigs: null
				stringValue: "My eloquent description"
				uncertainty: null
				urlValue: null
				valueKind: "description"
				valueOperator: null
				valueType: "stringValue"
				valueTypeAndKind: "stringValue_description"
				valueUnit: null
				version: 0
			]
			id: 341
			ignored: false
			lsTransaction:
				comments: "experiment 502 transactions"
				id: 47
				recordedDate: 1362435677000
				version: 0

			modifiedBy: null
			modifiedDate: null
			recordedBy: "userName"
			recordedDate: 1362435677000
			stateKind: "experiment info"
			stateType: "metadata"
			stateTypeAndKind: "metadata_experiment info"
			version: 0
		]
		id: 270
		ignored: false
		kind: "primary screen experiment"
		lsTransaction:
			comments: "experiment 502 transactions"
			id: 47
			recordedDate: 1362435677000
			version: 0

		modifiedBy: null
		modifiedDate: null
		protocol:
			codeName: "PROT-00000033"
			id: 269
			ignored: false
			kind: null
			lsTransaction:
				comments: "protocol 501 transactions"
				id: 46
				recordedDate: 1362435559000
				version: 0

			modifiedBy: null
			modifiedDate: null
			recordedBy: "jmcneil"
			recordedDate: 1362435560000
			shortDescription: "protocol short description goes here"
			version: 0

		recordedBy: "jmcneil"
		recordedDate: 1362435679000
		shortDescription: "experiment short description goes here"
		version: 0

	exports.savedExperimentWithTreatmentGroup =
		codeName: "EXPT-00000222"
		experimentLabels: [
			id: 31876
			ignored: false
			imageFile: null
			labelKind: "experiment name"
			labelText: "EXPT-00000221"
			labelType: "name"
			labelTypeAndKind: "name_experiment name"
			lsTransaction:
				comments: "docForBatches upload"
				id: 423
				recordedDate: 1367455531000
				version: 0

			modifiedDate: null
			physicallyLabled: false
			preferred: true
			recordedBy: "jmcneil"
			recordedDate: 1367455532000
			version: 0
		]
		experimentStates: []
		id: 64781
		ignored: false
		kind: "ACAS doc for batches"
		lsTransaction:
			comments: "docForBatches upload"
			id: 423
			recordedDate: 1367455531000
			version: 0

		modifiedBy: null
		modifiedDate: null
		protocol:
			codeName: "ACASdocForBatches"
			id: 2403
			ignored: false
			kind: null
			lsTransaction:
				comments: "docForBatches upload"
				id: 38
				recordedDate: 1362677322000
				version: 0

			modifiedBy: null
			modifiedDate: null
			recordedBy: "jmcneil"
			recordedDate: 1362677322000
			shortDescription: "ACAS Doc For Batches"
			version: 0

		recordedBy: "jmcneil"
		recordedDate: null
		shortDescription: "test description"
		version: 0
		analysisGroups: [
			analysisGroupLabels: []
			analysisGroupStates: [
				analysisGroupValues: [
					clobValue: null
					codeValue: null
					comments: "ok"
					dateValue: null
					fileValue: "exampleUploadedFile.txt"
					id: 258587
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "annotation"
					valueOperator: null
					valueType: "fileValue"
					valueTypeAndKind: "fileValue_annotation"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: "CMPD_1112"
					comments: null
					dateValue: null
					fileValue: null
					id: 258588
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "batch code"
					valueOperator: null
					valueType: "codeValue"
					valueTypeAndKind: "codeValue_batch code"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: null
					comments: null
					dateValue: null
					fileValue: null
					id: 258586
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "document kind"
					valueOperator: null
					valueType: "stringValue"
					valueTypeAndKind: "stringValue_document kind"
					valueUnit: null
					version: 0
				]
				comments: null
				id: 85510
				ignored: false
				lsTransaction:
					comments: "docForBatches upload"
					id: 423
					recordedDate: 1367455531000
					version: 0

				modifiedBy: null
				modifiedDate: null
				recordedBy: "jmcneil"
				recordedDate: 1367455532000
				stateKind: "Document for Batch"
				stateType: "results"
				stateTypeAndKind: "results_Document for Batch"
				version: 0
			,
				analysisGroupValues: [
					clobValue: null
					codeValue: null
					comments: null
					dateValue: null
					fileValue: null
					id: 258591
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "document kind"
					valueOperator: null
					valueType: "stringValue"
					valueTypeAndKind: "stringValue_document kind"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: null
					comments: "good"
					dateValue: null
					fileValue: "exampleUploadedFile.txt"
					id: 258589
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "annotation"
					valueOperator: null
					valueType: "fileValue"
					valueTypeAndKind: "fileValue_annotation"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: "CMPD-0000007-01"
					comments: null
					dateValue: null
					fileValue: null
					id: 258590
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "batch code"
					valueOperator: null
					valueType: "codeValue"
					valueTypeAndKind: "codeValue_batch code"
					valueUnit: null
					version: 0
				]
				comments: null
				id: 85511
				ignored: false
				lsTransaction:
					comments: "docForBatches upload"
					id: 423
					recordedDate: 1367455531000
					version: 0

				modifiedBy: null
				modifiedDate: null
				recordedBy: "jmcneil"
				recordedDate: 1367455532000
				stateKind: "Document for Batch"
				stateType: "results"
				stateTypeAndKind: "results_Document for Batch"
				version: 0
			,
				analysisGroupValues: [
					clobValue: null
					codeValue: "CMPD_1113"
					comments: null
					dateValue: null
					fileValue: null
					id: 258585
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "batch code"
					valueOperator: null
					valueType: "codeValue"
					valueTypeAndKind: "codeValue_batch code"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: null
					comments: null
					dateValue: null
					fileValue: null
					id: 258584
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "document kind"
					valueOperator: null
					valueType: "stringValue"
					valueTypeAndKind: "stringValue_document kind"
					valueUnit: null
					version: 0
				,
					clobValue: null
					codeValue: null
					comments: "bad"
					dateValue: null
					fileValue: "exampleUploadedFile.txt"
					id: 258583
					ignored: false
					lsTransaction: null
					modifiedDate: null
					numberOfReplicates: null
					numericValue: null
					publicData: true
					recordedDate: 1367455532000
					sigFigs: null
					stringValue: null
					uncertainty: null
					uncertaintyType: null
					urlValue: null
					valueKind: "annotation"
					valueOperator: null
					valueType: "fileValue"
					valueTypeAndKind: "fileValue_annotation"
					valueUnit: null
					version: 0
				]
				comments: null
				id: 85509
				ignored: false
				lsTransaction:
					comments: "docForBatches upload"
					id: 423
					recordedDate: 1367455531000
					version: 0

				modifiedBy: null
				modifiedDate: null
				recordedBy: "jmcneil"
				recordedDate: 1367455532000
				stateKind: "Document for Batch"
				stateType: "results"
				stateTypeAndKind: "results_Document for Batch"
				version: 0
			]
			codeName: "AG-00037424"
			id: 64782
			ignored: false
			recordedBy: "jmcneil"
			recordedDate: 1367455531000
			kind: "ACAS doc for batches"
			lsTransaction:
				comments: "docForBatches upload"
				id: 423
				recordedDate: 1367455531000
				version: 0
		]


) (if (typeof process is "undefined" or not process.versions) then window.experimentServiceTestJSON = window.experimentServiceTestJSON or {} else exports)




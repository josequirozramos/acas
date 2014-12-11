((exports) ->
	exports.dataDictValues =
		[
			type: "experiment metadata"
			kind: "instrument reader"
			codes:
				[
					code: "flipr"
					name: "FLIPR"
					ignored: false
				]
		,
			type: "experiment metadata"
			kind: "signal direction"
			codes:
				[
					code: "increasing"
					name: "Increasing Signal (highest = 100%)"
					ignored: false
				]
		,
			type: "experiment metadata"
			kind: "aggregate by"
			codes:
				[
					code: "compound batch concentration"
					name: "Compound Batch Concentration"
					ignored: false
				]
		,
			type: "experiment metadata"
			kind: "aggregation method"
			codes:
				[
					code: "median"
					name: "Median"
					ignored: false
				,
					code: "mean"
					name: "Mean"
					ignored: false
				]
		,
			type: "experiment metadata"
			kind: "transformation"
			codes:
				[
					code: "% efficacy"
					name: "% Efficacy"
					ignored: false
				,
					code: "sd"
					name: "SD"
					ignored: false
				,
					code: "null"
					name: "Not Set"
					ignored: false
				]
		,
			type: "experiment metadata"
			kind: "normalization"
			codes:
				[
					code: "plate order only",
					name: "Plate Order Only",
					ignored: false
				,
					code: "plate order and row",
					name: "Plate Order And Row",
					ignored: false
				,
					code: "plate order and tip",
					name: "Plate Order And Tip",
					ignored: false
				,
					code: "none"
					name: "None"
					ignored: false
				]
		,
			type: "experiment metadata"
			kind: "read name"
			codes:
				[
					code: "luminescence"
					name: "Luminescence"
					ignored: false
				,
					code: "fluorescence"
					name: "Fluorescence"
					ignored: false
				,
					code: "none"
					name: "None"
					ignored: false
				]
		]
) (if (typeof process is "undefined" or not process.versions) then window.primaryScreenCodeTableTestJSON = window.primaryScreenCodeTableTestJSON or {} else exports)

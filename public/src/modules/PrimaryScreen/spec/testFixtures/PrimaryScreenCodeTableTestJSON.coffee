((exports) ->
	exports.dataDictValues =
		[
			"instrument reader":
				[
					code: "flipr"
					name: "FLIPR"
					ignored: false
				]
		,
			"signal direction":
				[
					code: "increasing"
					name: "Increasing Signal (highest = 100%)"
					ignored: false
				]
		,
			"aggregate by1":
				[
					code: "compound batch concentration"
					name: "Compound Batch Concentration"
					ignored: false
				]
		,
			"aggregate by2":
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
			"transformation":
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
			"normalization":
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
			"read name":
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

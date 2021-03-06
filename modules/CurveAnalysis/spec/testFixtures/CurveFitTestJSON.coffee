((exports) ->
	exports.doseResponseBulkFitOptions =
		fixedParameters:
			min:
				parameter: "min"
				value: 0
			max:
				parameter: "max"
				value: 100
			slope:
				parameter: "slope"
				value: null
			ec50:
				parameter: "ec50"
				value: null
		inactiveRule:
			type: "threshold"
			value: 20
			activeDoses: 1
		parameterRules:
			goodnessOfFits:
				maxUncertaintyRule:
					parameter: "max"
					type: "stdErr"
					value: 5
					operator: ">"
					displayName: "Max uncertainty exceeded"
				ec50PValue:
					parameter: "ec50"
					type: "pValue"
					value: 1
					operator: ">"
					displayName: "EC50 uncertainty exceeded"
			limits:
				maxThreshold:
					parameter: "max"
					type: "threshold"
					value: 100
					operator: ">"
					displayName: "Max threshold exceeded"
				minThreshold:
					parameter: "min"
					type: "threshold"
					value: 0
					operator: "<"
					displayName: "Min threshold exceeded"
				ec50Threshold:
					parameter: "ec50"
					type: "logAboveReference"
					reference: "dose.max"
					value: 0.5
					operator: ">"
					displayName: "EC50 threshold exceeded"

	exports.doseResponseSimpleBulkFitOptions =
		max:
			limitType: "pin"# none, pin or limit
			value: 100
		min:
			limitType: "none"# none, pin or limit
			value: null
		slope:
			limitType: "limit"# none, pin or limit
			value: 1.5
		smartMode: true
		inactiveThresholdMode: true
		inactiveThreshold: 20
		theoreticalMaxMode: true
		theoreticalMax: "120"
		inverseAgonistMode: true


) (if (typeof process is "undefined" or not process.versions) then window.CurveFitTestJSON = window.CurveFitTestJSON or {} else exports)

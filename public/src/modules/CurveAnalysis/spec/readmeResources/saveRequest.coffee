saveRequest =
  action: "save"
  algorithmFlagStatus: ""
  category: "sigmoid"
  compoundCode: "CMPD-0000011-01A"
  curveAttributes:
    EC50: 0.65127595194333
    Operator: null
    SSE: 1015.56814479592
    SST: 31360.52054307
    compoundCode: "CMPD-0000011-01A"
    rSquared: 0.967616349243911

  curveErrors: "<table >  <tr> <td align=\"right\"> R^2 </td> <td align=\"right\"> 0.97 </td> </tr>  <tr> <td align=\"right\"> SSE </td> <td align=\"right\"> 1015.57 </td> </tr>  <tr> <td align=\"right\"> SST </td> <td align=\"right\"> 31360.52 </td> </tr>   </table>"
  curveid: "AG-00000001_2"
  dirty: true
  fitSettings:
    inactiveThreshold: 20
    inactiveThresholdMode: true
    inverseAgonistMode: false
    max:
      limitType: "none"

    min:
      limitType: "none"

    slope:
      limitType: "none"

    smartMode: true

  fitSummary: "Model fitted: Log-logistic (ED50 as parameter)<br><br>Parameter Estimates: <br><br><table table-bordered'><tr> <th>  </th> <th> Estimate </th> <th> Std. Error </th> <th> t-value </th> <th> p-value </th>  </tr>  <tr> <td align=\"right\"> ec50:(Intercept) </td> <td align=\"right\"> 0.651276 </td> <td align=\"right\"> 0.136201 </td> <td align=\"right\"> 4.78174 </td> <td align=\"right\"> 0.0000465173 </td> </tr>  <tr> <td align=\"right\"> max:(Intercept) </td> <td align=\"right\"> 104.772 </td> <td align=\"right\"> 7.41678 </td> <td align=\"right\"> 14.1264 </td> <td align=\"right\"> 1.55847e-14 </td> </tr>  <tr> <td align=\"right\"> min:(Intercept) </td> <td align=\"right\"> 11.3258 </td> <td align=\"right\"> 7.44326 </td> <td align=\"right\"> 1.52162 </td> <td align=\"right\"> 0.138934 </td> </tr>  <tr> <td align=\"right\"> slope:(Intercept) </td> <td align=\"right\"> -0.876441 </td> <td align=\"right\"> 0.21108 </td> <td align=\"right\"> -4.15218 </td> <td align=\"right\"> 0.000264263 </td> </tr>   </table><br>Residual standard error:<br><br>5.91773531005396(29 degrees of freedom)<br>"
  id: "AG-00000001_2"
  parameterStdErrors: "<table ><tr> <th> name </th> <th> pValue </th> <th> stdErr </th> <th> tValue </th>  </tr>  <tr> <td align=\"right\"> ec50 </td> <td align=\"right\"> 0.00004652 </td> <td align=\"right\"> 0.1362 </td> <td align=\"right\"> 4.782 </td> </tr>  <tr> <td align=\"right\"> max </td> <td align=\"right\"> 1.558e-14 </td> <td align=\"right\"> 7.417 </td> <td align=\"right\"> 14.13 </td> </tr>  <tr> <td align=\"right\"> min </td> <td align=\"right\"> 0.1389 </td> <td align=\"right\"> 7.443 </td> <td align=\"right\"> 1.522 </td> </tr>  <tr> <td align=\"right\"> slope </td> <td align=\"right\"> 0.0002643 </td> <td align=\"right\"> 0.2111 </td> <td align=\"right\"> -4.152 </td> </tr>   </table>"
  plotData:
    curve:
      curveAttributes:
        EC50: 0.65127595194333
        Operator: null
        SSE: 1015.56814479592
        SST: 31360.52054307
        compoundCode: "CMPD-0000011-01A"
        rSquared: 0.967616349243911

      ec50: 0.65127595194333
      max: 104.772340315567
      min: 11.325836843033
      slope: -0.876440685937927
      type: "4 parameter D-R"

    plotWindow: [ -1.90823440637806, 108.17261, 1.80102999566398, -2.83471 ]
    points: [
      algorithmFlagCause: "curvefit ko"
      algorithmFlagComment: "Biphasic"
      algorithmFlagObservation: "biphasic"
      algorithmFlagStatus: "knocked out"
      curveId: "AG-00000001_2"
      dose: 20
      doseUnits: "uM"
      flagchanged: true
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 88.51
      responseKind: "efficacy"
      responseSubjectValueId: 541
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 10
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: "sel ko"
      preprocessFlagComment: "spilled"
      preprocessFlagObservation: "sel ko"
      preprocessFlagStatus: "knocked out"
      recordedBy: "bob"
      response: 89.826
      responseKind: "efficacy"
      responseSubjectValueId: 542
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 5
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 89.883
      responseKind: "efficacy"
      responseSubjectValueId: 547
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 2.5
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 79.299
      responseKind: "efficacy"
      responseSubjectValueId: 548
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 1.25
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 67.286
      responseKind: "efficacy"
      responseSubjectValueId: 549
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.625
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 44.002
      responseKind: "efficacy"
      responseSubjectValueId: 550
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.3125
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 38.853
      responseKind: "efficacy"
      responseSubjectValueId: 551
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.15625
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 23.75
      responseKind: "efficacy"
      responseSubjectValueId: 552
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.078125
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 32.331
      responseKind: "efficacy"
      responseSubjectValueId: 553
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.039063
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 11.565
      responseKind: "efficacy"
      responseSubjectValueId: 554
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: "curvefit ko"
      algorithmFlagComment: "Biphasic"
      algorithmFlagObservation: "biphasic"
      algorithmFlagStatus: "knocked out"
      curveId: "AG-00000001_2"
      dose: 20
      doseUnits: "uM"
      flagchanged: true
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 80
      responseKind: "efficacy"
      responseSubjectValueId: 555
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 10
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 95.546
      responseKind: "efficacy"
      responseSubjectValueId: 556
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 5
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 92.743
      responseKind: "efficacy"
      responseSubjectValueId: 557
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 2.5
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 89.54
      responseKind: "efficacy"
      responseSubjectValueId: 558
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 1.25
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 71.805
      responseKind: "efficacy"
      responseSubjectValueId: 559
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.625
      doseUnits: "uM"
      flagchanged: true
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 60.993
      responseKind: "efficacy"
      responseSubjectValueId: 560
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: "curvefit ko"
      userFlagComment: "Too High"
      userFlagObservation: "too high"
      userFlagStatus: "knocked out"
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.3125
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 49.322
      responseKind: "efficacy"
      responseSubjectValueId: 561
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.15625
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 32.789
      responseKind: "efficacy"
      responseSubjectValueId: 562
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.078125
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 20.146
      responseKind: "efficacy"
      responseSubjectValueId: 563
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.039063
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 27.354
      responseKind: "efficacy"
      responseSubjectValueId: 564
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: "curvefit ko"
      algorithmFlagComment: "Biphasic"
      algorithmFlagObservation: "biphasic"
      algorithmFlagStatus: "knocked out"
      curveId: "AG-00000001_2"
      dose: 20
      doseUnits: "uM"
      flagchanged: true
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 82
      responseKind: "efficacy"
      responseSubjectValueId: 565
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 10
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 92.286
      responseKind: "efficacy"
      responseSubjectValueId: 566
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 5
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 90.112
      responseKind: "efficacy"
      responseSubjectValueId: 567
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 2.5
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 87.423
      responseKind: "efficacy"
      responseSubjectValueId: 568
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 1.25
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 75.924
      responseKind: "efficacy"
      responseSubjectValueId: 569
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.625
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 50.581
      responseKind: "efficacy"
      responseSubjectValueId: 570
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.3125
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 48.864
      responseKind: "efficacy"
      responseSubjectValueId: 571
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.15625
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 37.48
      responseKind: "efficacy"
      responseSubjectValueId: 572
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.078125
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 31.015
      responseKind: "efficacy"
      responseSubjectValueId: 573
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.039063
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 6.4159
      responseKind: "efficacy"
      responseSubjectValueId: 574
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: "curvefit ko"
      algorithmFlagComment: "Biphasic"
      algorithmFlagObservation: "biphasic"
      algorithmFlagStatus: "knocked out"
      curveId: "AG-00000001_2"
      dose: 20
      doseUnits: "uM"
      flagchanged: true
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 79
      responseKind: "efficacy"
      responseSubjectValueId: 575
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 10
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 98.922
      responseKind: "efficacy"
      responseSubjectValueId: 576
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 5
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 91.256
      responseKind: "efficacy"
      responseSubjectValueId: 577
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 2.5
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 85.077
      responseKind: "efficacy"
      responseSubjectValueId: 578
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 1.25
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 75.295
      responseKind: "efficacy"
      responseSubjectValueId: 579
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.625
      doseUnits: "uM"
      flagchanged: true
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 60.821
      responseKind: "efficacy"
      responseSubjectValueId: 580
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: "curvefit ko"
      userFlagComment: "Too High"
      userFlagObservation: "too high"
      userFlagStatus: "knocked out"
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.3125
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 41.656
      responseKind: "efficacy"
      responseSubjectValueId: 581
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.15625
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 36.965
      responseKind: "efficacy"
      responseSubjectValueId: 582
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.078125
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 25.295
      responseKind: "efficacy"
      responseSubjectValueId: 583
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
    ,
      algorithmFlagCause: ""
      algorithmFlagComment: ""
      algorithmFlagObservation: ""
      algorithmFlagStatus: ""
      curveId: "AG-00000001_2"
      dose: 0.039063
      doseUnits: "uM"
      flagchanged: false
      lsTransaction: 1
      preprocessFlagCause: ""
      preprocessFlagComment: ""
      preprocessFlagObservation: ""
      preprocessFlagStatus: ""
      recordedBy: "bob"
      response: 18.086
      responseKind: "efficacy"
      responseSubjectValueId: 584
      responseUnits: "efficacy"
      tempFlagStatus: ""
      userFlagCause: ""
      userFlagComment: ""
      userFlagObservation: ""
      userFlagStatus: ""
     ]

  renderingHint: "4 parameter D-R"
  reportedValues: "<table >  <tr> <td> ec50 </td> <td> 0.6513 </td> <td> uM </td> </tr>  <tr> <td> max </td> <td> 104.8 </td> <td> efficacy </td> </tr>  <tr> <td> min </td> <td> 11.33 </td> <td> efficacy </td> </tr>  <tr> <td> slope </td> <td> 0.8764 </td> <td>  </td> </tr>   </table>"
  sessionID: "/tmp/rSe-bb73099e5d"
  user: "bob"
  userFlagStatus: ""

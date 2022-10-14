import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TanahChart extends StatefulWidget {
  final Widget child;

  TanahChart({Key key, this.child}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<TanahChart> {
  List<charts.Series<Sales, int>> _seriesLineData;

  _generateData() {
    var linesalesdata = [
      new Sales(0, 62),
      new Sales(1, 61),
      new Sales(2, 61),
      new Sales(3, 58),
      new Sales(4, 43),
      new Sales(5, 40),
      new Sales(6, 39),
      new Sales(7, 39),
      new Sales(8, 38),
      new Sales(9, 39),
      new Sales(10, 40),
      new Sales(11, 43),
      new Sales(12, 41),
      new Sales(13, 43),
      new Sales(14, 42),
      new Sales(15, 42),
      new Sales(16, 40),
      new Sales(17, 41),
      new Sales(18, 46),
      new Sales(19, 45),
      new Sales(20, 43),
      new Sales(21, 45),
      new Sales(22, 47),
      new Sales(23, 47),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xfff2be79)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
//      decoration: BoxDecoration(color: Colors.black),
      padding: EdgeInsets.only(top: 50, bottom: 0),
      margin: EdgeInsets.only(top: 1030, bottom: 0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: charts.LineChart(_seriesLineData,
                defaultRenderer: new charts.LineRendererConfig(
                    includeArea: true, stacked: true),
                animate: true,
                animationDuration: Duration(seconds: 5),
                behaviors: [
                  new charts.ChartTitle('Waktu',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                  new charts.ChartTitle('Kelembaban Tanah (%)',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                ]),
          ),
        ],
      ),
    );
  }
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}

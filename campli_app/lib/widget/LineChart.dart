import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineChart extends StatefulWidget {
  final Widget child;

  LineChart({Key key, this.child}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  List<charts.Series<Sales, int>> _seriesLineData;

  _generateData() {
    var linesalesdata1 = [
      new Sales(0, 26),
      new Sales(1, 26),
      new Sales(2, 26),
      new Sales(3, 26),
      new Sales(4, 26),
      new Sales(5, 25),
      new Sales(6, 26),
      new Sales(7, 26),
      new Sales(8, 26),
      new Sales(9, 28),
      new Sales(10, 29),
      new Sales(11, 29),
      new Sales(12, 29),
      new Sales(13, 29),
      new Sales(14, 28),
      new Sales(15, 28),
      new Sales(16, 28),
      new Sales(17, 28),
      new Sales(18, 28),
      new Sales(19, 27),
      new Sales(20, 27),
      new Sales(21, 27),
      new Sales(22, 26),
      new Sales(23, 26),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xfff2be79)),
        id: 'Temperature',
        data: linesalesdata1,
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
      padding: EdgeInsets.only(top: 30, bottom: 0, right: 0),
      margin: EdgeInsets.only(top: 230, bottom: 300),
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
                  new charts.ChartTitle('Suhu (°C)',
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

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TesChart extends StatefulWidget {
  final Widget child;

  TesChart({Key key, this.child}) : super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<TesChart> {
  List<charts.Series<Sales, int>> _seriesLineData;

  _generateData() {
    var linesalesdata = [
      new Sales(0, 92),
      new Sales(1, 90),
      new Sales(2, 84),
      new Sales(3, 79),
      new Sales(4, 78),
      new Sales(5, 76),
      new Sales(6, 79),
      new Sales(7, 79),
      new Sales(8, 83),
      new Sales(9, 85),
      new Sales(10, 87),
      new Sales(11, 88),
      new Sales(12, 90),
      new Sales(13, 92),
      new Sales(14, 94),
      new Sales(15, 93),
      new Sales(16, 93),
      new Sales(17, 93),
      new Sales(18, 95),
      new Sales(19, 95),
      new Sales(20, 91),
      new Sales(21, 89),
      new Sales(22, 91),
      new Sales(23, 93),
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
      padding: EdgeInsets.only(top: 50, bottom: 0, right: 0),
      margin: EdgeInsets.only(top: 630, bottom: 330),
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
                  new charts.ChartTitle('Kelembaban Udara (%)',
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

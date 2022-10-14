import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/model/dataSensorSuhu.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:flutter_icons/entypo.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class SensorSuhuCard extends StatefulWidget {
  final String id;

  SensorSuhuCard(this.id);
  @override
  _SensorSuhuCardState createState() => _SensorSuhuCardState();
}

class _SensorSuhuCardState extends State<SensorSuhuCard> {
  Future<List<DataSensorSuhuTerkini>> futureDataSensorSuhu;
  Map data;

  List<DataSensorSuhuTerkini> dataSensorSuhubyId;
  BuildContext context;

  Future<List<DataSensorSuhuTerkini>> fetchDataSensorSuhu(String id) async {
    final response =
        await http.get(url + "/tiang/sensorsuhuterkini/" + id.toString());

//    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';

    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse =
          json.decode(response.body)['data_sensor_suhu_terkini'];
//      print(jsonResponse);
      return jsonResponse
          .map((data) => new DataSensorSuhuTerkini.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
    futureDataSensorSuhu = fetchDataSensorSuhu(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 5),
      child: FutureBuilder<List<DataSensorSuhuTerkini>>(
          future: futureDataSensorSuhu,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, left: 45),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: ((_, index) =>
//                  DataSensor DataSensor = DataSensor[index];
                    Stack(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 8.0),
//                            height: 80,
//                            decoration: BoxDecoration(
//                              color: Colors.black,
//                            ),
                            child: Row(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        new Container(
                                          height: 42.0,
                                          width: 38.0,
                                          decoration: new BoxDecoration(
                                            gradient: GRADIEN_2,
                                            border: new Border.all(
                                                color: kTextLightColor,
                                                width: 1.0),
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                          child: Icon(
                                              Typicons.weather_partly_sunny,
                                              color: kTextDarkColor,
                                              size: 30),
//                                          Icon(
//                                              "${snapshot.data[index].jenis}" ==
//                                                      "Suhu"
//                                                  ? Typicons
//                                                      .weather_partly_sunny
//                                                  : Entypo.getIconData("air"),
//                                              color: kTextDarkColor,
//                                              size: 30),
                                        ),
                                        Container(
//                                      decoration:
//                                          BoxDecoration(color: Colors.black),
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  "${snapshot.data[index].jenis}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                      "${snapshot.data[index].nilai}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16)),
                                                  Text(" °C",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ])),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

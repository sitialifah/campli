///
/// Widget yang berisi sebuah card yang menjelaskan kondisi rata-rata tanaman.
/// kondisi tanaman dibagi menjadi 3 parameter, yaitu suhu, kbb udara, kbb tanah
/// Terdiri dari 1 widget: tombol masuk.
///

import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/model/dataRataanSensor.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class CardKondisiTanaman extends StatefulWidget {
  @override
  _CardKondisiTanamanState createState() => _CardKondisiTanamanState();
}

class _CardKondisiTanamanState extends State<CardKondisiTanaman> {
  Future<List<DataRataanSensor>> futureDataRataanSensor;
  Map data;

  List<DataRataanSensor> dataRataanSensor;
  BuildContext context;

  Future<List<DataRataanSensor>> fetchDataRataanSensor() async {
    final response = await http.get(Uri.parse(url + '/bacaan_suhu/list'));
    print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<DataRataanSensor>((json) => DataRataanSensor.fromJson(json))
          .toList();
//      print(jsonResponse);
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();

    futureDataRataanSensor = fetchDataRataanSensor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 100,
//      decoration: BoxDecoration(color: Colors.black),
      child: FutureBuilder<List<DataRataanSensor>>(
          future: futureDataRataanSensor,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 5),
                itemCount: snapshot.data.length,
                itemBuilder: ((_, index) => Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(10.0),
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          width: 920,
                          height: 90,
                        ),
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 30, left: 5.5),
                                  child: Image.asset(
                                    "${snapshot.data[index].jenis}" ==
                                            "Kelembaban Udara"
                                        ? "assets/img/humidity-01.png"
                                        : "${snapshot.data[index].jenis}" ==
                                                "Suhu"
                                            ? "assets/img/suhu-01.png"
                                            : "assets/img/tanah-01.png",
                                    width: 30,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "${snapshot.data[index].nilai}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    LABEL_NILAI_PARAMETER_BERANDA,
                                                color: Color(0xff63d0a4),
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data[index].jenis}" ==
                                                      "Kelembaban Udara"
                                                  ? "%"
                                                  : "${snapshot.data[index].jenis}" ==
                                                          "Suhu"
                                                      ? "°C"
                                                      : "%",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize:
                                                    LABEL_NILAI_PARAMETER_BERANDA,
                                                color: Color(0xff63d0a4),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data[index].jenis}" ==
                                                "Kelembaban Udara"
                                            ? "Kelembaban \n Udara"
                                            : "${snapshot.data[index].jenis}" ==
                                                    "Suhu"
                                                ? "Suhu"
                                                : "Kelembaban \n Tanah",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

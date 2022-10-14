import 'package:campli_app/model/dataPingSensorKelembabanTanah.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_card.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/color.dart';
import '../../Animation/FadeAnimation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class PingSensorKelembabanTanahCard extends StatefulWidget {
  final String id;
//  final String namaLantai;

  PingSensorKelembabanTanahCard(this.id);
  @override
  _PingSensorKelembabanTanahCardState createState() =>
      _PingSensorKelembabanTanahCardState();
}

class _PingSensorKelembabanTanahCardState
    extends State<PingSensorKelembabanTanahCard> {
  Future<List<DataPingsensorkelembabantanah>>
      _futureDataPingSensorKelembabanTanah;
  Map data;

  List<DataPingsensorkelembabantanah> dataDataPingSensorKelembabanTanahbyId;
  BuildContext context;

  Future<List<DataPingsensorkelembabantanah>>
      _fetchDataPingSensorKelembabanTanah(String id) async {
    final response = await http
        .get(url + "/lantai/pingsensorkelembabantanah/" + id.toString());

//    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';

    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse =
          json.decode(response.body)['data_pingsensorkelembabantanah'];
      jsonResponse.sort((a, b) => a['nama_pot'].compareTo(b['nama_pot']));
//      print(jsonResponse);

      return jsonResponse
          .map((data) => new DataPingsensorkelembabantanah.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
//    print(widget.id);
    _futureDataPingSensorKelembabanTanah =
        _fetchDataPingSensorKelembabanTanah(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
      height: 1000,
      width: double.infinity,
      child: FutureBuilder<List<DataPingsensorkelembabantanah>>(
          future: _futureDataPingSensorKelembabanTanah,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
//                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 20.0),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: ((_, index) =>
//                  DataLantai dataLantai = datalantai[index];

                    Container(
                      margin: EdgeInsets.only(
                          top: 0, bottom: 15, left: 18, right: 10),
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 5),
                      height: 78,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BOX_SHADOW_CARD,
                        ],
                        borderRadius: RADIUS_SUDUT_CARD,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 5, left: 10, bottom: 5),
                                  child:
//                                  Image.asset(
//                                    "assets/img/kelembabanhijaukuning.png",
//                                    width: 50,
//                                  ),
                                      Container(
                                    height: 45,
                                    width: 45,
                                    decoration: new BoxDecoration(
//                                      border: Border.all(
//                                          color: kPrimaryColor, width: 2),
                                      color: kLightColor,
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    child: Image.asset(
                                      "assets/img/tanah-putih.png",
                                      width: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 1.0),
                                Padding(
                                  padding: EdgeInsets.only(top: 20, left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${snapshot.data[index].namaPot}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
//                            Spacer(),
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      top: 5, left: 5, right: 13),
                                  child: FlatButton(
                                    color: kLightColor,
                                    splashColor: kSplashColor,
                                    onPressed: () {/*...*/},
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(
                                            color: kPrimaryColor, width: 2)),
                                    child: GestureDetector(
                                      child: Text("PING",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          )),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => AlertDialog(
                                            title: FadeAnimation(
                                              1,
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    height: 50.0,
                                                    width: 50.0,
                                                    decoration:
                                                        new BoxDecoration(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(60.0),
                                                      border: Border.all(
                                                          color: kPrimaryColor,
                                                          width: 3),
                                                    ),
                                                    child:
                                                        //FontAwesomeIcons.temperatureHigh,
                                                        Icon(
                                                            "${snapshot.data[index].status}" ==
                                                                    "Aktif"
                                                                ? Icons.check
                                                                : Icons.clear,
                                                            color:
                                                                kPrimaryColor,
                                                            size: 27),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    child: Text(
                                                        "${snapshot.data[index].namaPot}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 23,
                                                            color:
                                                                kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            content: Text(
                                                'Sensor  ${snapshot.data[index].jenis} \n sedang dalam kondisi \n ${snapshot.data[index].status}!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 18)),
                                            actions: <Widget>[
                                              Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 100),
                                                child: FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('OKE');
                                                  },
                                                  color: kPrimaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      side: BorderSide(
                                                          color: kPrimaryColor,
                                                          width: 2)),
                                                  child: Text('OKE',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              kTextLightColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ).then((result) {
                                          print(result);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

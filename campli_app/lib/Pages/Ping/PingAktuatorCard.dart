import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Aktuator/Konfigurasi/KonfigurasiPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_card.dart';
import 'package:campli_app/model/dataPingAktuator.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/konfigurasi/icon.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import '../../Animation/FadeAnimation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class PingAktuatorCard extends StatefulWidget {
  final String id;

//
//  PingAktuatorCard(this.id, this.idRefAktuator, this.namaPengenalAktuator);
  PingAktuatorCard(this.id);
  @override
  _PingAktuatorCardState createState() => _PingAktuatorCardState();
}

class _PingAktuatorCardState extends State<PingAktuatorCard> {
  Future<List<DataPingaktuator>> futureDataPingAktuator;
  Map data;

  List<DataPingaktuator> dataPingAktuatorbyId;
  BuildContext context;

  Future<List<DataPingaktuator>> fetchDataPingAktuator(String id) async {
    final response =
        await http.get(url + "/tiang/pingaktuator/" + id.toString());

//    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';

    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data_pingaktuator'];
//      print(jsonResponse);

      return jsonResponse
          .map((data) => new DataPingaktuator.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
    futureDataPingAktuator = fetchDataPingAktuator(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0, left: 5, right: 5),
      height: 215,
      width: double.infinity,
      child: FutureBuilder<List<DataPingaktuator>>(
          future: futureDataPingAktuator,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 10.0),
//                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: ((_, index) =>
//                  DataLantai dataLantai = datalantai[index];

                    Container(
                      margin: EdgeInsets.only(
                          top: 5, bottom: 2, left: 18, right: 10),
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                      height: 60,
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
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: new BoxDecoration(
//                                      gradient: GRADIEN_3,
                                      color: kLightColor,
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    child: Icon(
                                        "${snapshot.data[index].jenisAktuator}" ==
                                                "Siram Air"
                                            ? AIR
                                            : "${snapshot.data[index].jenisAktuator}" ==
                                                    "Putar Tiang"
                                                ? PUTAR
                                                : PUPUK,
                                        color: Colors.white,
                                        size: 20),
                                  ),
                                ),
                                SizedBox(width: 1.0),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          "Aktuator ${snapshot.data[index].jenisAktuator}",
                                          style: STYLE_PING_PAGE),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
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
//                                            color: kTextLightColor,
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
//                                                          color: kLightColorDua,
                                                          color: kPrimaryColor,
                                                          width: 3),
                                                    ),
                                                    child:
                                                        //FontAwesomeIcons.temperatureHigh,
                                                        Icon(
                                                            "${snapshot.data[index].idRefStatus}" ==
                                                                    "Aktif"
                                                                ? Icons.check
                                                                : Icons.clear,
                                                            color:
//                                                                kLightColorDua,
                                                                kPrimaryColor,
                                                            size: 27),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    child: Text(
                                                        "STATUS AKTUATOR",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            content: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0.0),
                                              child: Text(
                                                  'Aktuator ${snapshot.data[index].jenisAktuator}\ndalam kondisi\n${snapshot.data[index].idRefStatus}!',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                            ),
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

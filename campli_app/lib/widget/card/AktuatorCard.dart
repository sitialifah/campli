import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Aktuator/Konfigurasi/KonfigurasiPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_card.dart';
import 'package:campli_app/model/dataAktuator.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/icon.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class AktuatorCard extends StatefulWidget {
  final String id;
//  final String idRefAktuator;
  final String namaPengenalAktuator;
//  final GoogleSignInAccount user;

//
//  AktuatorCard(this.id, this.idRefAktuator, this.namaPengenalAktuator);
  AktuatorCard(this.id, this.namaPengenalAktuator);
  @override
  _AktuatorCardState createState() => _AktuatorCardState();
}

class _AktuatorCardState extends State<AktuatorCard> {
  Future<List<DataAktuatorElement>> futureDataAktuator;
  Map data;
  var email;

  List<DataAktuatorElement> dataAktuatorbyId;
  BuildContext context;

  Future<List<DataAktuatorElement>> fetchDataAktuator(String id) async {
    final response = await http.get(url + "/tiang/aktuator/" + id.toString());

//    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';

    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data_aktuator'];
//      print(jsonResponse);

      return jsonResponse
          .map((data) => new DataAktuatorElement.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
    futureDataAktuator = fetchDataAktuator(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 280, left: 2),
      child: FutureBuilder<List<DataAktuatorElement>>(
          future: futureDataAktuator,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: ((_, index) =>
//                  DataLantai dataLantai = datalantai[index];

                    GestureDetector(
                      child: Container(
                        margin: MARGIN_CARD,
                        padding: PADDING_CARD,
                        height: 75,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: WARNA_CARD,
                          boxShadow: [
                            BOX_SHADOW_CARD,
                          ],
                          borderRadius: RADIUS_SUDUT_CARD,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 5.0),
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: new BoxDecoration(
                                                color: kLightColor,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0),
                                              ),
                                              child: Icon(
                                                  "${snapshot.data[index].idRefAktuator}" ==
                                                          "5079418695319552"
                                                      ? AIR
                                                      : "${snapshot.data[index].idRefAktuator}" ==
                                                              "4797943718608896"
                                                          ? PUTAR
                                                          : PUPUK,
                                                  color: kTextDarkColor,
                                                  size: 25),
                                            ),
                                          ),
                                          SizedBox(width: 5.0),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "${snapshot.data[index].jenisAktuator}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
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
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KonfigurasiPage(
                                    snapshot.data[index].id.toString(),
                                    snapshot.data[index].namaPengenalAktuator,
                                    snapshot.data[index].idRefAktuator,
                                  )),
                        );
                      },
                    )),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

import 'package:campli_app/konfigurasi/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/model/dataPot.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/style_card.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class PotCard extends StatefulWidget {
  final String id;

  PotCard(this.id);
  @override
  _PotCardState createState() => _PotCardState();
}

class _PotCardState extends State<PotCard> {
  Future<List<DataPotElement>> futureDataPot;
  Map data;

  List<DataPotElement> dataPotbyId;
  BuildContext context;

  Future<List<DataPotElement>> fetchDataPot(String id) async {
    final response = await http.get(url + "/lantai/pot/" + id.toString());
    //   final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data_pot'];
      jsonResponse.sort((a, b) => a['id_pot'].compareTo(b['id_pot']));
//      print(jsonResponse);

      return jsonResponse
          .map((data) => new DataPotElement.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
    futureDataPot = fetchDataPot(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 285, left: 10, right: 10, bottom: 5),
      child: FutureBuilder<List<DataPotElement>>(
          future: futureDataPot,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: ((_, index) => Stack(
                      children: <Widget>[
                        Container(
                          margin: MARGIN_CARD,
                          padding: PADDING_CARD,
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: WARNA_CARD,
                            boxShadow: [
                              BOX_SHADOW_CARD,
                            ],
                            borderRadius: RADIUS_SUDUT_CARD,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 5.0, left: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image.asset(
                                                        "assets/img/kelembabanhijaukuning.png",
                                                        width: 47,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    TANAH,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  Text(
                                                    "${snapshot.data[index].nilai} %",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: kTextDarkColor,
                                                        fontSize: 15),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Kategori :",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: kTextNilai,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        "${snapshot.data[index].kondisi}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: kTextNilai,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 13, left: 15),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            decoration: new BoxDecoration(
//                                                gradient: GRADIEN_3,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0),
                                                border: Border.all(
                                                    color: kLightColorDua,
                                                    width: 2)),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
//                                                    "${snapshot.data[index].id.toString()}",
                                                    "${snapshot.data[index].idPot}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15)),

//                                          Text(dataPot.id_pot,
//                                              style: TextStyle(
//                                                  color: kTextLightColor,
//                                                  fontSize: 15)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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

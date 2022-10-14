import 'package:campli_app/Pages/Ping/PingSensorKelembabanTanahPage.dart';
import 'package:campli_app/model/dataLantai.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class LantaiPingCard extends StatefulWidget {
  final String id;
  final String namaTiang;

  LantaiPingCard(this.id, this.namaTiang);

  @override
  _LantaiCardState createState() => _LantaiCardState();
}

class _LantaiCardState extends State<LantaiPingCard> {
  Map data;
  Future<List<DataLantaiElement>> futureDataLantai;
  List<DataLantaiElement> dataLantaibyId;
  BuildContext context;

  Future<List<DataLantaiElement>> fetchDataLantai(String id) async {
    final response = await http.get(url + "/tiang/lantai/" + id.toString());

//    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';

    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data_lantai'];
//      print(jsonResponse);
      jsonResponse.sort((a, b) => a['nama_lantai'].compareTo(b['nama_lantai']));
      return jsonResponse
          .map((data) => new DataLantaiElement.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
    futureDataLantai = fetchDataLantai(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0, left: 18, right: 5),
      child: FutureBuilder<List<DataLantaiElement>>(
          future: futureDataLantai,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 3.0),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: ((_, index) =>
//                  DataLantai dataLantai = datalantai[index];

                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 35),
//                        padding: EdgeInsets.only(
//                            left: 5, right: 5, top: 0, bottom: 5),
                        height: 30,
                        width: 120,

//                          width: double.infinity,
//                        decoration: BoxDecoration(
//                          color: Colors.white,
//                          boxShadow: [
//                            BOX_SHADOW_CARD,
//                          ],
//                          borderRadius: RADIUS_SUDUT_CARD,
//                        ),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(7.0),
                            padding: EdgeInsets.only(left: 5, right: 2, top: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
//                                    Container(
//                                      padding:
//                                          EdgeInsets.symmetric(vertical: 5.0),
//                                      child: Container(
//                                        height: 35,
//                                        width: 35,
//                                        decoration: new BoxDecoration(
//                                          gradient: GRADIEN_3,
//                                          borderRadius:
//                                              new BorderRadius.circular(30.0),
//                                        ),
//                                        child: Icon(FontAwesomeIcons.boxes,
//                                            color: kTextDarkColor, size: 15),
//                                      ),
//                                    ),
//                                    SizedBox(width: 1.0),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              "${snapshot.data[index].namaLantai}",
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PingSensorKelembabanTanahPage(
                                        snapshot.data[index].id.toString(),
                                        snapshot.data[index].namaLantai)));
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

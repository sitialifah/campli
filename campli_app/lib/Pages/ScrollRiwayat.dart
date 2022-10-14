import 'package:campli_app/konfigurasi/color.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/icon.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/model/dataRiwayat.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScrollRiwayat extends StatefulWidget {
//  final GoogleSignInAccount user;

//  const ScrollRiwayat(this.user, {Key key}) : super(key: key);
  @override
  _ScrollRiwayatState createState() => _ScrollRiwayatState();
}

class _ScrollRiwayatState extends State<ScrollRiwayat> {
  Future<List<DaftarKonfigurasiSelesai>> futureDataRiwayat;
  Map data;
//  var email;

  List<DaftarKonfigurasiSelesai> listRiwayat;
  BuildContext context;

  Future<List<DaftarKonfigurasiSelesai>> fetchDataRiwayat() async {
    final response =
        await http.get(Uri.parse(url + '/konfigurasi/daftarselesai'));
//    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse =
          json.decode(response.body)['daftar konfigurasi selesai'];
      jsonResponse.sort((a, b) => b['kapan'].compareTo(a['kapan']));
      return jsonResponse
          .map((data) => new DaftarKonfigurasiSelesai.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    futureDataRiwayat = fetchDataRiwayat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1450, left: 15, right: 15, bottom: 0),
      child: FutureBuilder<List<DaftarKonfigurasiSelesai>>(
          future: futureDataRiwayat,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: ((_, index) => Container(
                      width: 195,
                      height: 30,
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          height: 40,
//                                          decoration: BoxDecoration(
//                                              color: Colors.black),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "${snapshot.data[index].idAktuator}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
//
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 15.0,
                                                      left: 25,
                                                      right: 25),
                                                  child: Container(
                                                    height: 30,
                                                    width: 90,
                                                    decoration:
                                                        new BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xfff2be79),
                                                          Color(0xff66d9b8)
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(15.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: Text(
                                                        "Selesai",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: Text("Riwayat",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          10.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    WidgetSpan(
                                                                        child: Icon(
                                                                            Icons
                                                                                .brightness_1,
                                                                            color:
                                                                                Color(0xff4EBF9F),
                                                                            size: 15)),
                                                                    TextSpan(
                                                                        text:
                                                                            "Aktuator\t:\t\t",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16)),
                                                                    TextSpan(
                                                                        text:
                                                                            "${snapshot.data[index].idAktuator}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          10.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    WidgetSpan(
                                                                        child: Icon(
                                                                            Icons
                                                                                .brightness_1,
                                                                            color:
                                                                                Color(0xff4EBF9F),
                                                                            size: 15)),
                                                                    TextSpan(
                                                                        text:
                                                                            "Kondisi\t:\t\t",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16)),
                                                                    TextSpan(
                                                                        text:
                                                                            "baik",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          10.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    WidgetSpan(
                                                                        child: Icon(
                                                                            Icons
                                                                                .brightness_1,
                                                                            color:
                                                                                Color(0xff4EBF9F),
                                                                            size: 15)),
                                                                    TextSpan(
                                                                        text:
                                                                            "Waktu terakhir :",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 8.0,
                                                                      left:
                                                                          30.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    WidgetSpan(
                                                                        child: Icon(
                                                                            FontAwesomeIcons
                                                                                .clock,
                                                                            color:
                                                                                Color(0xff4EBF9F),
                                                                            size: 15)),
                                                                    TextSpan(
                                                                        text:
                                                                            "${DateFormat('dd/MM/yyyy - HH:mm').format(DateTime.fromMillisecondsSinceEpoch((snapshot.data[index].kapan).toInt() * 1000))}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 5.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    WidgetSpan(
                                                                        child: Icon(
                                                                            Icons
                                                                                .brightness_1,
                                                                            color:
                                                                                Color(0xff4EBF9F),
                                                                            size: 15)),
                                                                    TextSpan(
                                                                        text:
                                                                            "${snapshot.data[index].idAktuator} telah berhasil dikerjakan",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 16)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop('Oke');
                                                          },
                                                          color:
                                                              Color(0xfff2be79),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: Text('Oke',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      18)),
                                                        ),
                                                      ],
                                                    ),
                                                  ).then((result) {
                                                    print(result);
                                                  });
                                                }),
                                            SizedBox(width: 10.0),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
//                                  Column(
//                                    crossAxisAlignment:
//                                    CrossAxisAlignment.end,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            top: 15, left: 5),
//                                        child: Container(
//                                          padding: EdgeInsets.only(
//                                              left: 10.0,
//                                              right: 10.0,
//                                              top: 8.0,
//                                              bottom: 8.0),
//                                          width: 80,
//                                          decoration: BoxDecoration(
//                                            color: kLightColor,
//                                            borderRadius:
//                                            BorderRadius.circular(15),
//                                          ),
//                                          child: Row(
//                                            children: <Widget>[
//                                              Text(
////                                                    "${snapshot.data[index].id.toString()}",
//                                                  "Selesai",
//                                                  style: TextStyle(
//                                                      color:
//                                                      kTextLightColor,
//                                                      fontSize: 17)),
//
////                                          Text(dataPot.id_pot,
////                                              style: TextStyle(
////                                                  color: kTextLightColor,
////                                                  fontSize: 15)),
//                                            ],
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

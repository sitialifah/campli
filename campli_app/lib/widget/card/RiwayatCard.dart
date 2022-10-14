import 'package:campli_app/konfigurasi/color.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/icon.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/model/dataRiwayat.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatCard extends StatefulWidget {
//  final GoogleSignInAccount user;

//  const RiwayatCard(this.user, {Key key}) : super(key: key);
  @override
  _RiwayatCardState createState() => _RiwayatCardState();
}

class _RiwayatCardState extends State<RiwayatCard> {
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
      padding: EdgeInsets.only(top: 180, left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<DaftarKonfigurasiSelesai>>(
          future: futureDataRiwayat,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: ((_, index) => Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    top: 0,
                                    left: 15.0,
                                    right: 10.0,
                                    bottom: 15),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 220,
//                                          decoration: BoxDecoration(
//                                              color: Colors.black),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 15.0),
                                                child: Text(
                                                  "${snapshot.data[index].idAktuator}",
                                                  style: TextStyle(
                                                      color: kPrimaryColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 7),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          WidgetSpan(
                                                              child:
                                                                  ICON_DATETIME),
                                                          TextSpan(
                                                            text: "..",
                                                            style: TextStyle(
                                                                color:
                                                                    kBackgroundColor,
                                                                fontSize: 18),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "${DateFormat('dd/MM/yyyy - HH:mm').format(DateTime.fromMillisecondsSinceEpoch((snapshot.data[index].kapan).toInt() * 1000))}",
                                                            style: TextStyle(
                                                                color:
                                                                    kTextDarkColor,
                                                                fontSize: 17),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15, left: 5),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 8.0,
                                                    bottom: 8.0),
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: kLightColor,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
//                                                    "${snapshot.data[index].id.toString()}",
                                                        "Selesai",
                                                        style: TextStyle(
                                                            color:
                                                                kTextLightColor,
                                                            fontSize: 17)),

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
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Lantai/Pot/PotPage.dart';
import 'package:campli_app/Pages/Lantai/hapusLantai.dart';
import 'package:campli_app/Pages/TabBarPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_card.dart';
import 'package:campli_app/model/dataLantai.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/icon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class LantaiCard extends StatefulWidget {
  final String id;
  final String namaTiang;
//  final GoogleSignInAccount user;

  LantaiCard(this.id, this.namaTiang);
  @override
  _LantaiCardState createState() => _LantaiCardState();
}

class _LantaiCardState extends State<LantaiCard> {
  Future<List<DataLantaiElement>> futureDataLantai;
  Map data;
//  var email;

  List<DataLantaiElement> dataLantaibyId;
  BuildContext context;
  hapusLantai hapus_data_lantai;

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
    hapus_data_lantai = hapusLantai();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 380, left: 2),
      child: FutureBuilder<List<DataLantaiElement>>(
          future: futureDataLantai,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: ((_, index) =>
//                  DataLantai dataLantai = datalantai[index];

                    Stack(children: <Widget>[
                      GestureDetector(
                        child: Container(
                          margin: MARGIN_CARD,
                          padding: PADDING_CARD,
                          height: 70,
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
                                padding: EdgeInsets.only(left: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 185,
//                                      decoration:
//                                          BoxDecoration(color: Colors.black),
                                      padding: EdgeInsets.only(
                                          top: 15.0, left: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              "${snapshot.data[index].namaLantai}",
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 10.0, left: 55),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20, left: 10),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                children: <Widget>[
//                                                  Column(
//                                                    children: <Widget>[
//                                                      Padding(
//                                                        padding:
//                                                            EdgeInsets.only(
//                                                                left: 10),
//                                                        child: Column(
//                                                          children: <Widget>[
//                                                            ICON_EDIT1,
//                                                            GestureDetector(
//                                                              child: Text(EDIT,
//                                                                  style: TextStyle(
//                                                                      color:
//                                                                          kPrimaryColor,
//                                                                      fontSize:
//                                                                          15)),
//                                                              onTap: () {
//                                                                int id = snapshot
//                                                                    .data[index]
//                                                                    .id;
//                                                                String
//                                                                    namaLantai =
//                                                                    snapshot
//                                                                        .data[
//                                                                            index]
//                                                                        .namaLantai;
//                                                                int jumlahPot =
//                                                                    snapshot
//                                                                        .data[
//                                                                            index]
//                                                                        .jumlahPot;
//                                                                String idTiang =
//                                                                    snapshot
//                                                                        .data[
//                                                                            index]
//                                                                        .idTiang;
//
//                                                                Navigator.push(
//                                                                    context,
//                                                                    MaterialPageRoute(
//                                                                        builder: (context) => EditLantai(
//                                                                            id.toString(),
//                                                                            namaLantai,
//                                                                            jumlahPot,
//                                                                            idTiang,
//                                                                            widget.namaTiang)));
//                                                              },
//                                                            ),
//                                                          ],
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15,
                                                                right: 10),
                                                        child: Column(
                                                          children: <Widget>[
                                                            ICON_HAPUS1,
                                                            GestureDetector(
                                                              child: Text(HAPUS,
                                                                  style: TextStyle(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      fontSize:
                                                                          15)),
                                                              onTap: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                    title: Text(
                                                                        'Hapus Lantai',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                23,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                    content: Text(
                                                                        'Kamu yakin akan menghapus \nlantai ini? ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18)),
                                                                    actions: <
                                                                        Widget>[
                                                                      FlatButton(
                                                                        child: Text(
                                                                            'HAPUS',
                                                                            style:
                                                                                TextStyle(color: Colors.teal, fontSize: 18)),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => TabBarPage(widget.id, widget.namaTiang)));
                                                                          hapus_data_lantai
                                                                              .hapusDataLantai(snapshot.data[index].id)
                                                                              .then((isSuccess) {
                                                                            if (isSuccess) {
                                                                              setState(() {
//                                                                                CircularProgressIndicator();
//                                                                                fetchDataLantai(widget.id);
                                                                              });
                                                                              Fluttertoast.showToast(msg: "Lantai berhasil dihapus", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.white, textColor: Colors.black, fontSize: 16.0);
                                                                            } else {
                                                                              Scaffold.of(this.context).showSnackBar(SnackBar(content: Text("Lantai gagal dihapus")));
                                                                            }
                                                                          });

//                                                                          Navigator.of(context)
//                                                                              .pop('HAPUS');
                                                                        },
                                                                      ),
                                                                      FlatButton(
                                                                        child: Text(
                                                                            'TIDAK',
                                                                            style:
                                                                                TextStyle(color: Colors.teal, fontSize: 18)),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ).then(
                                                                    (result) {
                                                                  print(result);
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0,
                                          ),
                                        ],
                                      ),
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
                                builder: (context) => PotPage(
                                    snapshot.data[index].id.toString(),
                                    snapshot.data[index].namaLantai)),
                          );
                        },
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

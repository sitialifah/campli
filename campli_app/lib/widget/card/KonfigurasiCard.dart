import 'package:campli_app/Pages/Aktuator/Konfigurasi/KonfigurasiPage.dart';
import 'package:campli_app/konfigurasi/icon.dart';
import 'package:campli_app/model/dataKonfigurasi.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:campli_app/Pages/Aktuator/Konfigurasi/hapusKonfigurasi.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class KonfigurasiCard extends StatefulWidget {
  final String id;
  final String idRefAktuator;
  final String namaPengenalAktuator;

  KonfigurasiCard(this.id, this.idRefAktuator, this.namaPengenalAktuator);
  @override
  _KonfigurasiCardState createState() => _KonfigurasiCardState();
}

class _KonfigurasiCardState extends State<KonfigurasiCard> {
  Future<List<DataKonfigurasiElement>> futureDataKonfigurasi;
  Map data;

  List<DataKonfigurasiElement> dataKonfigurasibyIdAktuator;
  BuildContext context;
  hapusKonfigurasi hapus_data_konfigurasi;

  Future<List<DataKonfigurasiElement>> fetchDataKonfigurasi(String id) async {
    final response =
        await http.get(url + "/aktuator/konfigurasi/" + id.toString());

//    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';

    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data_konfigurasi'];
      jsonResponse.sort((a, b) => b['kapan'].compareTo(a['kapan']));
//      print(jsonResponse);

      return jsonResponse
          .map((data) => new DataKonfigurasiElement.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
//    print(futureDataKonfigurasi.then((value) => print(value)));
    super.initState();
    print(widget.id);
    futureDataKonfigurasi = fetchDataKonfigurasi(widget.id);
    hapus_data_konfigurasi = hapusKonfigurasi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 300, left: 5, right: 5),
      child: FutureBuilder<List<DataKonfigurasiElement>>(
          future: futureDataKonfigurasi,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                shrinkWrap: true,
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
//                                      ICON UNTUK MUNCULIN JENIS AKTUATOR : perlu ga?
//                                      Container(
//                                        padding: EdgeInsets.symmetric(
//                                            vertical: 10.0, horizontal: 5.0),
//                                        child: Container(
//                                          height: 30,
//                                          width: 30,
//                                          decoration: new BoxDecoration(
//                                            color: kLightColor,
//                                            borderRadius:
//                                                new BorderRadius.circular(30.0),
//                                          ),
//                                          child: Icon(
//                                              widget.idRefAktuator ==
//                                                      "5079418695319552"
//                                                  ? AIR
//                                                  : widget.idRefAktuator ==
//                                                          "4797943718608896"
//                                                      ? PUTAR
//                                                      : PUPUK,
//                                              color: kTextDarkColor,
//                                              size: 20),
//                                        ),
//                                      ),
                                      SizedBox(width: 5.0),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                "${DateFormat('dd/MM/yyyy - HH:mm').format(DateTime.fromMillisecondsSinceEpoch((snapshot.data[index].kapan).toInt() * 1000))}",
                                                style: TextStyle(
                                                    color: kLightColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal)),
//
//                                            Text("status: selesai",
//                                                style: TextStyle(
//                                                    color: kShadowColor,
//                                                    fontWeight: FontWeight.bold,
//                                                    fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 5, right: 5),
                                            child: Column(
                                              children: <Widget>[
                                                ICON_HAPUS2,
                                                GestureDetector(
                                                  child: Text(
                                                    HAPUS,
                                                    style: TextStyle(
                                                      color: kLightColor,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text('Warning',
                                                            style: TextStyle(
                                                                fontSize: 23,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        content: Text(
                                                            'Kamu yakin akan menghapus \nkonfigurasi ini? ',
                                                            style: TextStyle(
                                                                fontSize: 18)),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text('HAPUS',
                                                                style: TextStyle(
                                                                    color:
                                                                        kLightColor,
                                                                    fontSize:
                                                                        18)),
                                                            onPressed: () {
//                                                              Navigator.push(
//                                                                  context,
//                                                                  MaterialPageRoute(
//                                                                      builder: (context) => KonfigurasiPage(
//                                                                          widget
//                                                                              .id,
//                                                                          widget
//                                                                              .namaPengenalAktuator,
//                                                                          widget
//                                                                              .idRefAktuator)));
                                                              hapus_data_konfigurasi
                                                                  .hapusDataKonfigurasi(
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .id)
                                                                  .then(
                                                                      (isSuccess) {
                                                                if (isSuccess) {
                                                                  setState(() {
//                                                                                    fetchDataTiang();
                                                                  });
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Konfigurasi berhasil dihapus",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      textColor:
                                                                          Colors
                                                                              .black,
                                                                      fontSize:
                                                                          16.0);
//                                                                                  Scaffold.of(this.context).showSnackBar(SnackBar(content: Text("Tiang berhasil dihapus")));
                                                                } else {
                                                                  Scaffold.of(this
                                                                          .context)
                                                                      .showSnackBar(SnackBar(
                                                                          content:
                                                                              Text("Konfigurasi gagal dihapus")));
                                                                }
                                                              });

//                                                                              Navigator.of(context).pop('HAPUS');
                                                            },
                                                          ),
                                                          FlatButton(
                                                            child: Text('TIDAK',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .teal,
                                                                    fontSize:
                                                                        18)),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ).then((result) {
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
                                ],
                              ),
                            ),
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

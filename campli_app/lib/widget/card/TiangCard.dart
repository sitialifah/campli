import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Tiang/EditTiang.dart';
import 'package:campli_app/Pages/Page.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/Pages/Tiang/hapusTiang.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../Pages/TabBarPage.dart';
import 'package:campli_app/konfigurasi/style_card.dart';
import 'package:campli_app/model/dataTiang.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/konfigurasi/icon.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TiangCard extends StatefulWidget {
  @override
  _TiangCardState createState() => _TiangCardState();
}

class _TiangCardState extends State<TiangCard> {
//  bool isDescending = false;
  Future<List<DataTiang>> futureDataTiang;
  Map data;
  var email;

  List<DataTiang> listDaftar;
  BuildContext context;
  hapusTiang hapus_data_tiang;

  Future<List<DataTiang>> fetchDataTiang() async {
    SharedPreferences sessionRole = await SharedPreferences.getInstance();
    email = sessionRole.getString('email') ?? '';
    final response =
        await http.get(Uri.parse(url + '/tiang/daftartiang/' + email));
//    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['daftar'];
      jsonResponse.sort((a, b) => a['nama_tiang'].compareTo(b['nama_tiang']));
      return jsonResponse.map((data) => new DataTiang.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    futureDataTiang = fetchDataTiang();
    hapus_data_tiang = hapusTiang();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      padding: EdgeInsets.only(top: 170, left: 5, right: 5),
      child: FutureBuilder<List<DataTiang>>(
        future: futureDataTiang,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: fetchDataTiang,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: ((_, index) => Stack(
                      children: <Widget>[
                        Container(
                          margin: MARGIN_CARD,
                          padding: PADDING_CARD,
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: RADIUS_SUDUT_CARD,
                            color: WARNA_CARD,
                            boxShadow: [
                              BOX_SHADOW_CARD,
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10.0, left: 20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          //nama dan status tiang
                                          Row(
                                            children: <Widget>[
                                              //nama tiang
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: Text(
                                                    "${snapshot.data[index].namaTiang}",
                                                    style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 19)),
                                              ),
                                              //status

//                                          tarok bottom selanjutnya
                                            ],
                                          ),
                                          //jumlah lantai
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 5.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                          child: Icon(
                                                              FontAwesomeIcons
                                                                  .boxes,
                                                              color:
                                                                  kAccentColor,
                                                              size: 20)),
                                                      TextSpan(
                                                          text: '\t\t',
                                                          style: TextStyle(
                                                              color:
                                                                  kTextDarkColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                      TextSpan(
                                                          text:
                                                              "${snapshot.data[index].jumlahLantai} lantai",
                                                          style: TextStyle(
                                                              color:
                                                                  kTextDarkColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 8.0, left: 18.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                          child: ICON_TITIK),
                                                      TextSpan(
                                                        text:
                                                            "  ${snapshot.data[index].idRefStatus}",
                                                        style: TextStyle(
                                                            color:
                                                                kTextDarkColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //waktu instalasi
                                          Container(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 15.0, bottom: 10.0),
                                                  child: Text("Waktu Instalasi",
                                                      style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16)),
                                                ),
                                                Text(
                                                    '${snapshot.data[index].waktuPemasangan}',
                                                    style: TextStyle(
                                                        color: kTextDarkColor,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // edit hapus
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, left: 80.0),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              left: 10.0,
                                              top: 5.0,
                                              bottom: 5.0,
                                              right: 10.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3.0),
                                              child: GestureDetector(
                                                child:
                                                    Column(children: <Widget>[
                                                  Icon(Icons.arrow_forward,
                                                      color: kTextLightColor,
                                                      size: 27),
                                                ]),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TabBarPage(
                                                              snapshot
                                                                  .data[index]
                                                                  .id
                                                                  .toString(),
                                                              snapshot
                                                                  .data[index]
                                                                  .namaTiang,

//                                              widget.namaLantai,
//                                              widget.jumlahPot,
//                                              widget.idTiang
                                                            )),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 5.0,
                                            top: 60.0,
//                                          right: 15.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0, left: 40),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        // START TOMBOL EDIT
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Column(
                                                            children: <Widget>[
                                                              ICON_EDIT1,
                                                              GestureDetector(
                                                                child: Text(
                                                                    EDIT,
                                                                    style: TextStyle(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        fontSize:
                                                                            15)),
                                                                onTap: () {
                                                                  int id = snapshot
                                                                      .data[
                                                                          index]
                                                                      .id;
                                                                  String
                                                                      namaTiang =
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .namaTiang;
                                                                  int jumlahLantai =
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .jumlahLantai;
                                                                  String
                                                                      keterangan =
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .keterangan;
                                                                  String
                                                                      idRefStatus =
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .idRefStatus;
                                                                  String
                                                                      waktuPemasangan =
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .waktuPemasangan;
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => EditTiang(
                                                                              id,
                                                                              namaTiang,
                                                                              jumlahLantai,
                                                                              keterangan,
                                                                              idRefStatus,
                                                                              waktuPemasangan)));
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 5),
                                                          child: Column(
                                                            children: <Widget>[
                                                              ICON_HAPUS1,
                                                              GestureDetector(
                                                                child: Text(
                                                                  HAPUS,
                                                                  style: TextStyle(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
//                                                                    barrierDismissible:
//                                                                        false,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title: Text(
                                                                              'Warning',
                                                                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                                                                          content: Text(
                                                                              'Kamu yakin akan menghapus \ndata tiang ini? ',
                                                                              style: TextStyle(fontSize: 18)),
                                                                          actions: <
                                                                              Widget>[
                                                                            FlatButton(
                                                                              child: Text('HAPUS', style: TextStyle(color: Colors.teal, fontSize: 18)),
                                                                              onPressed: () {
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => TiangPageTwo()));
                                                                                hapus_data_tiang.hapusDataTiang(snapshot.data[index].id).then((isSuccess) {
                                                                                  if (isSuccess) {
                                                                                    setState(() {
//                                                                                    fetchDataTiang();
                                                                                    });
                                                                                    Fluttertoast.showToast(msg: "Tiang berhasil dihapus", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.white, textColor: Colors.black, fontSize: 16.0);
//                                                                                  Scaffold.of(this.context).showSnackBar(SnackBar(content: Text("Tiang berhasil dihapus")));
                                                                                  } else {
                                                                                    Scaffold.of(this.context).showSnackBar(SnackBar(content: Text("Tiang gagal dihapus")));
                                                                                  }
                                                                                });

//                                                                              Navigator.of(context).pop('HAPUS');
                                                                              },
                                                                            ),
                                                                            FlatButton(
                                                                              child: Text('TIDAK', style: TextStyle(color: Colors.teal, fontSize: 18)),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }).then((result) {
                                                                    print(
                                                                        result);
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
                                              SizedBox(
                                                height: 0,
                                              ),
                                            ],
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
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

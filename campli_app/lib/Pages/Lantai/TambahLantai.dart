import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Lantai/LantaiPage.dart';
import 'package:campli_app/Pages/TabBarPage.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_button.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Animation/FadeAnimation.dart';
import 'package:campli_app/konfigurasi/style_container_body.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TambahLantai extends StatefulWidget {
  final String id;
  final String namaTiang;
//  final GoogleSignInAccount user;
//  final String namaLantai;
//  final String jumlahPot;
//  final String idTiang;
  const TambahLantai(this.id, this.namaTiang, {Key key}) : super(key: key);
  @override
  _TambahLantaiState createState() => _TambahLantaiState();
}

Future<String> submitLantai(
    String id, String nama_lantai, String id_tiang) async {
  var body = {"id": id, "nama_lantai": nama_lantai, "id_tiang": id_tiang};
  var response = await http.post(Uri.parse(url + '/lantai/tambah'), body: body);
  print(body);
  var data = response.body;
  String responseString;
  print(data);

  if (response.statusCode == 200) {
    responseString = response.body;
//    detailTiangFromJson(responseString);
  } else
    return responseString;
}

class _TambahLantaiState extends State<TambahLantai> {
  String data_lantai;
  var email;
  TextEditingController idController = TextEditingController();
  TextEditingController namaLantaiController = TextEditingController();
//  TextEditingController idTiangController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("tambah ${widget.id}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ClipPathHeader(),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/img/tambahLantai.png",
                  width: 280,
                ),
              ),
            ),
            Positioned(
              child: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TabBarPage(widget.id, widget.namaTiang)),
                  ),
                ),
                iconTheme: IconThemeData(
                  color: kTextDarkColor,
                ),
                centerTitle: true,
                title: new Text(
                  "Tambah Lantai",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTextDarkColor, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 30),
              margin: EdgeInsets.only(top: 300),
              constraints: BoxConstraints.expand(height: 300),
              decoration: BoxDecoration(
                color: WARNA_CONTAINER,
                borderRadius: RADIUS_SUDUT_CONTAINER,
                boxShadow: [
                  SHADOW_CONTAINER,
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 350, left: 40, bottom: 15, right: 40),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                          1,
                          Column(
                            children: <Widget>[
                              Text(
                                "Lengkapi data lantai sesuai intruksi tim CAMPLI ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        new TextField(
                          decoration: new InputDecoration(
                            labelText: "Masukkan nama lantai",
                          ),
                          controller: namaLantaiController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text('Id Tiang',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black45)),
                              ),
                            ),
                          ],
                        ),
                        new TextField(
                          decoration: new InputDecoration(
                            hintText: widget.id,
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
//                        makeInput(label: "Nama Tiang"),
//                        makeInput(label: "Keterangan"),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: TINGGI_BUTTON,
                        child: RaisedButton(
                          onPressed: () async {
                            String id = idController.text;
                            String nama_lantai = namaLantaiController.text;
                            String id_tiang = widget.id;

                            String data =
                                await submitLantai(id, nama_lantai, id_tiang);

                            setState(() {
                              data_lantai = data;
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TabBarPage(widget.id, widget.namaTiang)),
                            );
                            Fluttertoast.showToast(
                                msg: "Lantai berhasil ditambah",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: RADIUS_SUDUT_BUTTON,
                          ),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: GRADIEN_1,
                              borderRadius: RADIUS_SUDUT_BUTTON,
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 250.0,
                                minHeight: 10.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                LABEL_TOMBOL_TAMBAH,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kTextLightColor,
                                  fontSize: LABEL_BUTTON_UKURAN_FONT,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: kTextInput,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
//            border: InputBorder.none,
          ),
        ),
        //mengatur jarak antar form
        SizedBox(height: 10),
      ],
    );
  }
}

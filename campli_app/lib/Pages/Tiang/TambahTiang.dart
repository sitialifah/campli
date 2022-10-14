import 'dart:ui';
import 'package:campli_app/Pages/Page.dart';
import 'package:campli_app/model/dataTiang.dart';
import 'package:campli_app/konfigurasi/style_button.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/konfigurasi/style_container_body.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Animation/FadeAnimation.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TambahTiang extends StatefulWidget {
  final GoogleSignInAccount user;
  TambahTiang({Key key, final this.user}) : super(key: key);

  @override
  _TambahTiangState createState() => _TambahTiangState();
}

class _TambahTiangState extends State<TambahTiang> {
  var email;
  DataTiang data_tiang;

  TextEditingController idController = TextEditingController();
  TextEditingController namaTiangController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<DataTiang> submitTiang(
      String id, String nama_tiang, String keterangan, String email) async {
    SharedPreferences sessionRole = await SharedPreferences.getInstance();
    email = sessionRole.getString('email') ?? '';
    final response = await http.post(Uri.parse(url + '/tiang/tambah'), body: {
      "id": id,
      "nama_tiang": nama_tiang,
      "keterangan": keterangan,
      "email": email,
    });
    var data = response.body;
    print(data);
    print(response.body);

    if (response.statusCode == 200) {
      print("Success");
    } else
      print("error");
  }

  @override
  Widget build(BuildContext context) {
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
                  "assets/img/tambahTiang.png",
                  width: 280,
                ),
              ),
            ),
            Positioned(
              child: AppBar(
                iconTheme: IconThemeData(
                  color: kTextDarkColor,
                ),
                centerTitle: true,
                title: new Text(
                  "Tambah Tiang",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTextDarkColor, fontWeight: FontWeight.bold),
                ),
                backgroundColor: kTransparentColor,
                elevation: 0,
              ),
            ),
//          BgHeader1(),

            Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
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
                                "Lengkapi informasi berikut dengan benar untuk menambah tiang baru ",
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
                          height: 40,
                        ),
                        new TextField(
                          decoration: new InputDecoration(
                            labelText: "Masukkan nama tiang",
                          ),
                          controller: namaTiangController,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        new TextField(
                          decoration: new InputDecoration(
                            labelText: "Masukkan keterangan tiang",
                          ),
                          controller: keteranganController,
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
                            String nama_tiang = namaTiangController.text;
                            String keterangan = keteranganController.text;

                            DataTiang data = await submitTiang(
                                id, nama_tiang, keterangan, email);

                            setState(() {
                              data_tiang = data;
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TiangPageTwo()),
                            );
                            Fluttertoast.showToast(
                                msg: "Tiang berhasil ditambah",
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

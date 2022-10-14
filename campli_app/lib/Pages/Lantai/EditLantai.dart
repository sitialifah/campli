import 'package:campli_app/Pages/Lantai/LantaiPage.dart';
import 'package:campli_app/Pages/TabBarPage.dart';
import 'package:campli_app/konfigurasi/style_button.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/model/dataNested.dart';
import 'package:campli_app/widget/bg_clipPath.dart';
import 'package:campli_app/widget/container_body.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class EditLantai extends StatefulWidget {
  final String id;
  final String namaLantai;
  final int jumlahPot;
  final String idTiang;
  final String namaTiang;
  final GoogleSignInAccount user;

  EditLantai(this.id, this.namaLantai, this.jumlahPot, this.idTiang,
      this.namaTiang, this.user);

  @override
  _EditLantaiState createState() => _EditLantaiState();
}

class _EditLantaiState extends State<EditLantai> {
  DataLantai data_Lantai;
  var email;
  TextEditingController idController = TextEditingController();
  TextEditingController namaLantaiController = TextEditingController();
  TextEditingController jumlahPotController = TextEditingController();
//  TextEditingController idTiangController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      namaLantaiController.text = widget.namaLantai;
      jumlahPotController.text = widget.jumlahPot.toString();
//      idTiangController.text = widget.idTiang;
    });
  }

  Future<DataLantai> updateData(String nama_lantai, String jumlah_pot) async {
    print(nama_lantai + "tesssss");
    try {
      var response =
          await http.put(Uri.parse(url + '/lantai/ubah/${widget.id}'), body: {
        "nama_lantai": nama_lantai,
        "jumlah_pot": jumlah_pot,
//          "id_tiang": id_tiang
      });
      var data = response.body;
      print(data);

      if (response.statusCode == 200) {
        print("success");
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ClipPathHeader(),
            Positioned(
              child: AppBar(
                iconTheme: IconThemeData(
                  color: kTextDarkColor,
                ),
                centerTitle: true,
                title: new Text(
                  "Edit Lantai",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTextDarkColor, fontWeight: FontWeight.bold),
                ),
                backgroundColor: kTransparentColor,
                elevation: 0,
              ),
            ),
            BgHeader1(),
            ContainerBody1(),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 210, left: 40, bottom: 15, right: 40),
                    child: Column(
                      children: <Widget>[
                        new TextField(
                          decoration: new InputDecoration(
                              labelText: "Ubah nama Lantai"),
                          controller: namaLantaiController,
                        ),
//                        new TextField(
//                          decoration: new InputDecoration(
//                              enabled: false, labelText: "Id Tiang"),
//                        ),
                        new TextField(
                          decoration: new InputDecoration(
                              enabled: false, labelText: "Jumlah Pot"),
                          controller: jumlahPotController,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: TINGGI_BUTTON,
                        child: RaisedButton(
                          onPressed: () async {
                            String nama_Lantai = namaLantaiController.text;
                            String jumlah_pot = jumlahPotController.text;
                            print("${widget.id} klik");
                            DataLantai data =
                                await updateData(nama_Lantai, jumlah_pot);

                            setState(() {
                              data_Lantai = data;
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TabBarPage(widget.id, widget.namaTiang)),
                            );
                            Fluttertoast.showToast(
                                msg: "Lantai berhasil diedit",
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

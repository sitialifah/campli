import 'package:campli_app/Pages/Page.dart';
import 'package:campli_app/model/dataTiang.dart';
import 'package:campli_app/konfigurasi/style_button.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/konfigurasi/style_container_body.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class EditTiang extends StatefulWidget {
  final int id;
  final String namaTiang;
  final int jumlahLantai;
  final String keterangan;
  final String idRefStatus;
  final String waktuPemasangan;

  EditTiang(this.id, this.namaTiang, this.jumlahLantai, this.keterangan,
      this.idRefStatus, this.waktuPemasangan);
//  EditTiang(this.id, this.namaTiang, this.jumlahLantai, this.keterangan,
//      this.idRefStatus);

  @override
  _EditTiangState createState() => _EditTiangState();
}

class _EditTiangState extends State<EditTiang> {
  var email;
  DataTiang data_tiang;
  TextEditingController idController = TextEditingController();
  TextEditingController namaTiangController = TextEditingController();
  TextEditingController jumlahLantaiController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController idRefStatusController = TextEditingController();
  TextEditingController waktuPemasanganController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      namaTiangController.text = widget.namaTiang;
      jumlahLantaiController.text = widget.jumlahLantai.toString();
      keteranganController.text = widget.keterangan;
      idRefStatusController.text = widget.idRefStatus;
      waktuPemasanganController.text = widget.waktuPemasangan;
    });
  }

  Future<DataTiang> updateData(String nama_tiang, String jumlah_lantai,
      String keterangan, String id_ref_status, String waktu_pemasangan) async {
    SharedPreferences sessionRole = await SharedPreferences.getInstance();
    email = sessionRole.getString('email') ?? '';
    final response =
        await http.put(Uri.parse(url + '/tiang/ubah/${widget.id}'), body: {
      "nama_tiang": nama_tiang,
      "jumlah_lantai": jumlah_lantai,
      "keterangan": keterangan,
      "id_ref_status": id_ref_status,
      "waktu_pemasangan": waktu_pemasangan,
      "email": email,
    });
    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      print("success");
    } else {
      print("error");
    }
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
                  "assets/img/editTiang.png",
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
                  "Edit Tiang",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTextDarkColor, fontWeight: FontWeight.bold),
                ),
                backgroundColor: kTransparentColor,
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
                        new TextField(
                          decoration:
                              new InputDecoration(labelText: "Ubah nama tiang"),
                          controller: namaTiangController,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        new TextField(
                          enabled: false,
                          decoration: new InputDecoration(
                              labelText: "Jumlah lantai pada tiang"),
                          controller: jumlahLantaiController,
                        ),
                        new TextField(
                          decoration: new InputDecoration(
                              labelText: "Ubah keterangan tiang"),
                          controller: keteranganController,
                        ),

                        SizedBox(
                          height: 15,
                        ),
//                        new TextField(
//                          enabled: false,
//                          decoration:
//                              new InputDecoration(labelText: "Keadaan tiang"),
//                          controller: idRefStatusController,
//                        ),
                        SizedBox(
                          height: 1,
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
                            String nama_tiang = namaTiangController.text;
                            String jumlah_lantai = jumlahLantaiController.text;
                            String keterangan = keteranganController.text;
                            String id_ref_status = idRefStatusController.text;
                            String waktu_pemasangan =
                                waktuPemasanganController.text;

                            DataTiang data = await updateData(
                                nama_tiang,
                                jumlah_lantai,
                                keterangan,
                                id_ref_status,
                                waktu_pemasangan);

                            setState(() {
                              data_tiang = data;
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TiangPageTwo()),
                            );
                            Fluttertoast.showToast(
                                msg: "Tiang berhasil diedit",
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

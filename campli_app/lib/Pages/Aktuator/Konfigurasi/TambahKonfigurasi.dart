import 'package:campli_app/Animation/FadeAnimation.dart';
import 'package:campli_app/Pages/Aktuator/Konfigurasi/KonfigurasiPage.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_button.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/widget/bg_clipPath.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/widget/container_body.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class TambahKonfigurasi extends StatefulWidget {
  final String id;
  final String namaPengenalAktuator;
  final String idRefAktuator;
//  final GoogleSignInAccount user;

  const TambahKonfigurasi(
//      this.id, this.namaPengenalAktuator, this.idRefAktuator, this.user,
//      {Key key})
//      : super(key: key);
      this.id,
      this.namaPengenalAktuator,
      this.idRefAktuator,
      {Key key})
      : super(key: key);

  @override
  _TambahKonfigurasiState createState() => _TambahKonfigurasiState();
}

Future<String> submitKonfigurasi(
    String id, String kapan, String id_aktuator) async {
//  SharedPreferences sessionRole = await SharedPreferences.getInstance();
//  email = sessionRole.getString('email') ?? '';
  var body = {
    "id": id,
    "kapan": kapan,
    "id_aktuator": id_aktuator,
//    "email": email
  };
  var response = await http.post(
      Uri.parse(url +
          '/konfigurasi/tambah'), //ini tadi k gedekkk ya Allah. nasib sekaliii. sekali lagi makasih ya kkk hahahha hahahahha okeey, selamat tidur nyenyakk
      body: body);

  //coba lagi pah :)))))))) kek nya bisa ya kk? jkeknya salah huruf kecil :))) dah bisaa kakk.. itu tadi diubahnya bagian mana kakk cryy hahaha
  print(body);
  print(response.statusCode);
  var data = response.body;
  String responseString;
  print(data);

  if (response.statusCode == 200) {
    responseString = response.body;
  } else
    return responseString;
}

class _TambahKonfigurasiState extends State<TambahKonfigurasi> {
  String data_Konfigurasi;
  var email;
  TextEditingController idController = TextEditingController();
  TextEditingController kapanController = TextEditingController();
//  DateTime _selectedDate;
  final format = DateFormat("yyy-MM-ddTHH:mm");

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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: GRADIEN_1,
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: AppBar(
                  iconTheme: IconThemeData(
                    color: kTextDarkColor,
                  ),
                  centerTitle: true,
                  title: new Text(
                    "Tambah Konfigurasi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kTextDarkColor, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.transparent,
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
                          FadeAnimation(
                            1,
                            Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Tambah jadwal konfigurasi untuk aktuator",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(widget.namaPengenalAktuator,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black45,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text('Id Aktuator',
                                      style: TextStyle(fontSize: 15)),
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
                          new Text(
                              'Pilih tanggal & waktu konfigurasi(${format.pattern})'),
                          DateTimeField(
                            controller: kapanController,
                            format: format,
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100),
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: ThemeData(
                                        primarySwatch: Colors.teal,
                                        primaryColor: kPrimaryColor,
                                        accentColor: kAccentColor,
                                      ),
                                      child: child,
                                    );
                                  });
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                return DateTimeField.combine(date, time);
                              } else {
                                return currentValue;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
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
                              String id = idController.text;
                              String kapan = kapanController.text;
                              String id_aktuator = widget.id;

                              String data = await submitKonfigurasi(
                                  id, kapan, id_aktuator);

                              setState(() {
                                data_Konfigurasi = data;
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KonfigurasiPage(
                                          widget.id,
                                          widget.namaPengenalAktuator,
                                          widget.idRefAktuator,
                                        )),
                              );
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
      ),
    );
  }
}

Widget _buildAppBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => KonfigurasiPage()),
//            );
        },
      ),
    ],
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

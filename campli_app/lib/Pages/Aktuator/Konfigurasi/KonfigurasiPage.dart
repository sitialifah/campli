import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/widget/card/KonfigurasiCard.dart';
import 'package:campli_app/Pages/Aktuator/Konfigurasi/TambahKonfigurasi.dart';
import 'package:campli_app/Pages/TabBarPage.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:campli_app/konfigurasi/gambar.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class KonfigurasiPage extends StatefulWidget {
  final String id;
  final String namaPengenalAktuator;
  final String idRefAktuator;

  const KonfigurasiPage(this.id, this.namaPengenalAktuator, this.idRefAktuator,
      {Key key})
      : super(key: key);
  @override
  _KonfigurasiPageState createState() => _KonfigurasiPageState();
}

class _KonfigurasiPageState extends State<KonfigurasiPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  var email;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kTextLightColor,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: ClipPathHeader2(),
          ),
          SizedBox(height: 25),
          Positioned(
            child: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
//              leading: IconButton(
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => Home()),
//                    );
//                  },
//                  icon: Icon(Icons.arrow_back)),
              centerTitle: false,
              title: new Text(
                widget.namaPengenalAktuator,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 30),
            margin: EdgeInsets.only(top: 170),
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                new BoxShadow(
                  color: Colors.white10,
                  blurRadius: 100.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                GAMBAR_KONFIGURASI_PAGE,
                width: 350,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140, left: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Jadwal\nKonfigurasi\nTanaman",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Konfigurasi yang akan dikerjakan',
                        style: TextStyle(
                          fontSize: 18,
                          color: kTextDarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 300),
          KonfigurasiCard(
              widget.id, widget.namaPengenalAktuator, widget.idRefAktuator),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Color(0xff004d4f),
        child: Icon(Icons.add),
        onPressed: () {
//          print("lantai");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TambahKonfigurasi(widget.id,
                    widget.namaPengenalAktuator, widget.idRefAktuator)),
          );
        },
      ),
    );
  }
}

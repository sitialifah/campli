import 'package:campli_app/Pages/Ping/PingSensorKelembabanTanahCard.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:campli_app/konfigurasi/gambar.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/color.dart';

class PingSensorKelembabanTanahPage extends StatefulWidget {
  final String id;
  final String namaLantai;

  const PingSensorKelembabanTanahPage(this.id, this.namaLantai, {Key key})
      : super(key: key);
  @override
  _PingSensorKelembabanTanahPageState createState() =>
      _PingSensorKelembabanTanahPageState();
}

class _PingSensorKelembabanTanahPageState
    extends State<PingSensorKelembabanTanahPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
                color: Colors.white,
              ),
              centerTitle: false,
              title: new Text(
                "     PING Sensor di " + widget.namaLantai,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, bottom: 0, right: 20, top: 30),
            margin: EdgeInsets.only(top: 220),
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(0)),
              boxShadow: [
                new BoxShadow(
                  color: Colors.white10,
                  blurRadius: 100.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 85, left: 8, right: 5),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                GAMBAR_PINGTANAH_PAGE,
                width: 360,
              ),
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.only(top: 148, left: 40),
//            child: Align(
//              alignment: Alignment.topLeft,
//              child: Text(
//                "Ping Sensor\nKelembaban\nTanah",
//                style: TextStyle(
//                    fontSize: 17,
//                    fontWeight: FontWeight.bold,
//                    color: kPrimaryColor),
//              ),
//            ),
//          ),
          Padding(
            padding: const EdgeInsets.only(top: 320, left: 40, right: 35),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Pantau kondisi sensor kelembaban tanah',
                        style: TextStyle(
                          fontSize: 17,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 330),
            child: PingSensorKelembabanTanahCard(widget.id),
          ),
        ],
      ),
    );
  }
}

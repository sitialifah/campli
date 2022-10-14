import 'package:campli_app/widget/card/SensorKelembabanUdaraCard.dart';
import 'package:flutter/material.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/widget/card/LantaiCard.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/widget/card/SensorSuhuCard.dart';
import 'package:campli_app/widget/bg_clipPath.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:campli_app/widget/container_body.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Lantai/TambahLantai.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LantaiPage extends StatefulWidget {
  final String id;
  final String namaTiang;
//  final GoogleSignInAccount user;

  const LantaiPage(this.id, this.namaTiang, {Key key}) : super(key: key);

  @override
  _LantaiPageState createState() => _LantaiPageState();
}

class _LantaiPageState extends State<LantaiPage>
    with SingleTickerProviderStateMixin {
  var email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: ClipPathHeader2(),
          ),
          SizedBox(height: 25),
          BgHeader(),
          ContainerBody(),
          Padding(
            padding: const EdgeInsets.only(top: 180, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: "Keadaan Terkini Tiang",
                            style: TextStyle(
                              fontSize: 20,
                              color: kTextDarkColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: SensorSuhuCard(widget.id),
                        ),
                        Container(
                          child: SensorKelembabanUdaraCard(widget.id),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          //munculin data sensor

          //akhir munculin data
          Padding(
            padding: const EdgeInsets.only(top: 360, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: "Daftar Lantai",
                        style: TextStyle(
                          fontSize: 20,
                          color: kTextDarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ///ganti tabs sesuai index
          LantaiCard(widget.id, widget.namaTiang),
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
                builder: (context) =>
                    TambahLantai(widget.id, widget.namaTiang)),
          );
        },
      ),
    );
  }
}

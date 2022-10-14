import 'package:flutter/material.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/widget/card/AktuatorCard.dart';
import 'package:campli_app/widget/bg_clipPath.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:campli_app/widget/container_body.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AktuatorPage extends StatefulWidget {
  final String id;
  final String namaTiang;
//  final GoogleSignInAccount user;

  const AktuatorPage(this.id, this.namaTiang, {Key key}) : super(key: key);

  @override
  _AktuatorPageState createState() => _AktuatorPageState();
}

class _AktuatorPageState extends State<AktuatorPage>
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: "Aktuator pada Tiang",
                        style: TextStyle(
                          fontSize: 20,
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
          Padding(
            padding: const EdgeInsets.only(top: 220, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text:
                            "Pilih aktuator untuk melihat konfigurasi yang sudah ditambahkan",
                        style: TextStyle(
                          fontSize: 18,
                          color: kTextDarkColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          ///ganti tabs sesuai index
          AktuatorCard(widget.id, widget.namaTiang),
        ],
      ),
    );
  }
}

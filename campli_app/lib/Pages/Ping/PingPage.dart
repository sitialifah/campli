import 'package:campli_app/Pages/Ping/LantaiPingCard.dart';
import 'package:campli_app/Pages/Ping/PingSensorKelembabanUdaraCard.dart';
import 'package:campli_app/Pages/Ping/PingSensorSuhuCard.dart';
import 'package:flutter/material.dart';
import 'PingAktuatorCard.dart';
import 'package:campli_app/widget/bg_clipPath.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:campli_app/widget/container_body.dart';

class PingPage extends StatefulWidget {
  final String id;
  final String namaTiang;

  const PingPage(this.id, this.namaTiang, {Key key}) : super(key: key);
  @override
  _PingPageState createState() => _PingPageState();
}

class _PingPageState extends State<PingPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
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
            padding: const EdgeInsets.only(top: 180, left: 25, bottom: 5),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text:
                                "Pantau kondisi aktuator dan sensor pada tiang",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 200,
            ),
            child: Column(
              children: <Widget>[
                PingAktuatorCard(widget.id),
                PingSensorSuhuCard(widget.id),
                PingSensorKelembabanUdaraCard(widget.id)
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 585, left: 25, bottom: 5, right: 5),
            child: RichText(
              text: TextSpan(
                text:
                    "Pilih lantai untuk memantau kondisi sensor \nkelembaban tanah pada pot",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 628),
            child: LantaiPingCard(widget.id, widget.namaTiang),
          ),
        ],
      ),
    );
  }
}

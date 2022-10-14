import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Aktuator/AktuatorPage.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Ping/PingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Lantai/LantaiPage.dart';
import 'package:campli_app/konfigurasi/color.dart';

class TabBarPage extends StatefulWidget {
  final String id;
  final String namaTiang;

  const TabBarPage(
    this.id,
    this.namaTiang, {
    Key key,
  }) : super(key: key);
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  var email;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: new AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TiangPageTwo()),
              );
            },
            icon: Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(
          color: kTextDarkColor,
        ),
        centerTitle: true,
        title: new Text(
          widget.namaTiang,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kTextDarkColor, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kAccentColor,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          _index == 0
              ? Lantai(context)
              : (_index == 1 ? Aktuator(context) : Ping(context)),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 80),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _index = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: _index == 0 ? kPrimaryColor : kTransparentColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Icon(
                            FontAwesomeIcons.boxes,
                            color:
                                _index == 0 ? kTextLightColor : kTextDarkColor,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                          child: Text(
                            "LANTAI",
                            style: TextStyle(
                                color: _index == 0
                                    ? kTextLightColor
                                    : kTextDarkColor,
                                fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _index = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: _index == 1 ? kPrimaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(
                            FontAwesomeIcons.cog,
                            color:
                                _index == 1 ? kTextLightColor : kTextDarkColor,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                          child: Text(
                            "AKTUATOR",
                            style: TextStyle(
                                color: _index == 1
                                    ? kTextLightColor
                                    : kTextDarkColor,
                                fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _index = 2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: _index == 2 ? kPrimaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Icon(FontAwesomeIcons.lightbulb,
                              color: _index == 2
                                  ? kTextLightColor
                                  : kTextDarkColor,
                              size: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                          child: Text(
                            "PING",
                            style: TextStyle(
                                color: _index == 2
                                    ? kTextLightColor
                                    : kTextDarkColor,
                                fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget Lantai(BuildContext context) {
    return Scaffold(
      body: LantaiPage(widget.id, widget.namaTiang
//          widget.namaLantai, widget.idTiang, widget.jumlahPot
          ),
    );
  }

  Widget Aktuator(BuildContext context) {
    return Scaffold(
      body: AktuatorPage(widget.id, widget.namaTiang),
    );
  }

  Widget Ping(BuildContext context) {
    return Scaffold(
      body: PingPage(widget.id, widget.namaTiang),
    );
  }
}

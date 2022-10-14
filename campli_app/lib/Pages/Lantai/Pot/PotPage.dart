import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/widget/card/PotCard.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/widget/card/LantaiCard.dart';
import 'package:campli_app/model/dataNested.dart';
import 'package:campli_app/konfigurasi/gambar.dart';
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/widget/clip_path.dart';

class PotPage extends StatefulWidget {
  final String id;
  final String namaLantai;
//  final List<ListPot> listPot;

  const PotPage(this.id, this.namaLantai, {Key key}) : super(key: key);
  @override
  _PotPageState createState() => _PotPageState();
}

class _PotPageState extends State<PotPage> with SingleTickerProviderStateMixin {
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
//              leading: IconButton(
//                  onPressed: () {
////                    Navigator.push(
////                      context,
////                      MaterialPageRoute(builder: (context) => TabBarPage()),
////                    );
//                  },
//                  icon: Icon(Icons.arrow_back)),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              centerTitle: false,
//              title: new Text(
//                widget.id,
//                textAlign: TextAlign.left,
//                style: TextStyle(
//                    color: Colors.black,
//                    fontSize: 22,
//                    fontWeight: FontWeight.bold),
//              ),

              title: new Text(
                widget.namaLantai,
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
                GAMBAR_POT_PAGE,
                width: 350,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 135, left: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Kondisi\nTanaman",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 260, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: "List Pot",
                        style: TextStyle(
                          fontSize: 19,
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
          PotCard(widget.id),
        ],
      ),
    );
  }
}

import 'package:campli_app/Pages/BantuanPage.dart';

/// Terdiri dari tiga halaman : Beranda, riwayat dan list tiang
///
import 'package:campli_app/model/google_signin_api.dart';
import 'package:campli_app/widget/TanahChart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/widget/card/RiwayatCard.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/widget/card/TiangCard.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Tiang/TambahTiang.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widget/LineChart.dart';
import '../widget/TesChart.dart';
import 'DropdownBeranda.dart';
import 'ScrollRiwayat.dart';
import 'package:campli_app/navigationDrawer/navigationDrawer.dart';
import 'package:campli_app/widget/clip_path.dart';
import 'package:campli_app/widget/bg_clipPath.dart';
import 'package:campli_app/widget/card/card_rataan_kondisi_tanaman_beranda.dart';
import 'package:campli_app/widget/container_body.dart';
import 'package:campli_app/konfigurasi/icon.dart';
import 'package:intl/intl.dart';

class BerandaPage extends StatefulWidget {
  final GoogleSignInAccount user;

  BerandaPage({Key key, final this.user}) : super(key: key);
  void initState() async {
    GoogleSignInAccount data = user;
    //String email = data.email;
    SharedPreferences sessionRole = await SharedPreferences.getInstance();
    var email = sessionRole.getString('email') ?? '';
    var displayName = sessionRole.getString('displayName') ?? '';
  }

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  var email;

  void initState() {
    controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
//    String formattedDate = DateFormat('EEE d MMM y, kk:mm:ss ').format(now);
    String formattedDate = DateFormat('EEE d MMM y').format(now);
    return new Scaffold(
      drawer: navigationDrawer(),
      //extendBodyBehindAppBar: true,
      appBar: new AppBar(
        backgroundColor: kAccentColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text(
            "   BERANDA",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: kTextLightColor),
          ),
        ),
        actions: <Widget>[
//          FlatButton(
//            // splashColor: Colors.red,
//            color: Colors.transparent,
//            // textColor: Colors.white,
//            child: Text(
//              'Logout',
//              style: TextStyle(
//                  fontWeight: FontWeight.normal,
//                  fontSize: 16,
//                  color: Colors.white),
//            ),
//            onPressed: () async {
//              await GoogleSignInAPI.logout();
//              Navigator.of(context).pushReplacement(MaterialPageRoute(
//                builder: (context) => LoginPage(),
//              ));
//            },
//          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 800,
          child: Stack(
            children: <Widget>[
              ClipPathHeaderBeranda(),

              ///untuk memanggil gambar2 background clippath
              BgHeader(),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(
                    "Banda Aceh, " + formattedDate,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: kTextLightColor,
                    ),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
                margin: EdgeInsets.only(top: 120),
                constraints: BoxConstraints.expand(height: 2500),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0)),
                  boxShadow: [
                    new BoxShadow(
                      color: kShadowColor,
                      blurRadius: 30.0,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 80, left: 25, right: 25),
                    child: Column(
                      children: <Widget>[
                        /// card kondisi tanaman keseluruhan dengan 3 parameter
                        /// parameter: suhu, klbb udara, klbb tanah
                        CardKondisiTanaman(),
                      ],
                    ),
                  ),
                  DropdownBeranda(),
                ],
              ),
//              sample1(),
              LineChart(),
              Padding(
                padding: const EdgeInsets.only(top: 630, left: 25),
                child: Text(
                  "Grafik Sensor Kelembaban Udara",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff004d4f),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 650, left: 25, right: 25),
                child: Divider(
                  color: Color(0xff004d4f),
                  height: 20,
                  thickness: 2,
                ),
              ),
              TesChart(),
              Padding(
                padding: const EdgeInsets.only(top: 1030, left: 25),
                child: Text(
                  "Grafik Sensor Kelembaban Tanah",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff004d4f),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1050, left: 25, right: 25),
                child: Divider(
                  color: Color(0xff004d4f),
                  height: 20,
                  thickness: 2,
                ),
              ),
              TanahChart(),

              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 1420, left: 25),
                    child: Text(
                      "Riwayat Terakhir",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1420, left: 90),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Lihat semua",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              color: kTextFadedText,
                            ),
                          ),
                          Icon(ICON_SELENGKAPNYA,
                              color: kTextFadedText, size: 21),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RiwayatPage()),
                      );
                    },
                  ),
                ],
              ),
              ScrollRiwayat(),
            ],
          ),
        ),
      ),
    );
  }
}

class TiangPageTwo extends StatefulWidget {
  @override
  _TiangPageTwoState createState() => _TiangPageTwoState();
}

class _TiangPageTwoState extends State<TiangPageTwo>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kTextLightColor,
      drawer: navigationDrawer(),
      //extendBodyBehindAppBar: true,
      appBar: new AppBar(
        backgroundColor: kAccentColor,
        elevation: 0,
        title: Text(
          "LIST TIANG",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: kTextLightColor),
        ),
      ),

      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: ClipPathHeader2(),
          ),

          BgHeader(),

//          SizedBox(height: 25),

          /// Membuat search bar untuk cari tiang
//          Container(
//            padding: EdgeInsets.only(
//                top: 70.0,
//                bottom: 20.0,
//                right: 50,
//                left: 50), //vertical = mengatur posisi atas ke bawah
//            child: Material(
//              elevation: 0,
//              color: kTextLightColor, //color of search bar
//              borderRadius: BorderRadius.all(
//                Radius.circular(30.0),
//              ),
//              child: TextField(
//                controller: TextEditingController(),
//                //style: DropdownMenuItemStyle(l),
//                cursorColor: kBodyTextColor,
//                decoration: InputDecoration(
//                  border: InputBorder.none,
//                  contentPadding:
//                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
//                  hintText: "Mencari Tiang",
//                  hintStyle:
//                      TextStyle(fontSize: 17.0, color: kTextLightColorDua),
//                  suffixIcon: Material(
//                    //letakin posisi icon
//                    color: kTransparentColor,
//                    elevation: 0,
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(10.0),
//                    ),
//                    child: Icon(
//                      ICON_CARI,
//                      color: kTextLightColorDua,
//                      size: 23,
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ),

          ContainerBody(),

          SizedBox(height: 200),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/img/listTiang.png",
                  width: 280,
                ),
              ),
            ),
          ),
          TiangCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: kPrimaryColor,
        child: Icon(ICON_TAMBAH),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahTiang()),
          );
        },
      ),
    );
  }
}

class RiwayatPage extends StatefulWidget {
//  final GoogleSignInAccount user;
//  const RiwayatPage(this.user, {Key key}) : super(key: key);
  @override
  _RiwayatPageState createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage>
    with SingleTickerProviderStateMixin {
//  var email;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kTextLightColor,
      drawer: navigationDrawer(),
      //extendBodyBehindAppBar: true,
      appBar: new AppBar(
        backgroundColor: kAccentColor,
        elevation: 0,
        title: Text(
          "RIWAYAT",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: kTextLightColor),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: ClipPathHeader2(),
          ),

          SizedBox(height: 25),
          BgHeader(),
          ContainerBodyRiwayat(),
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/img/riwayat_foto-01.png",
                width: 300,
              ),
            ),
          ),

          /// search bar riwayat

          RiwayatCard(),
        ],
      ),
    );
  }
}

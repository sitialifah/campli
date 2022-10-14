import 'package:flutter/material.dart';
import 'package:campli_app/navigationDrawer/navigationDrawer.dart';
import 'Home.dart';

class TentangCampli extends StatefulWidget {
  static const String routeName = '/TentangCampli';
  @override
  _TentangCampliState createState() => _TentangCampliState();
}

class _TentangCampliState extends State<TentangCampli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: navigationDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.clamp,
                      colors: [
                        Colors.white,
                        Colors.white12,
                        //Color(0xfff2be79),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: MyClipper2(),
                child: Container(
                  width: double.infinity,
                  height: 320,
                  decoration: BoxDecoration(
                    color: const Color(0xff66d9b8).withOpacity(0.5),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xff66d9b8),
                  ),
                ),
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 110.0, left: 30.0),
                    child: Text(
                      "Tentang Campli",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset("assets/img/tentang-01.png",
                            width: 230)),
                  ),
                ],
              ),
            ),

//            Padding(
//              padding: const EdgeInsets.only(top: 112.0, left: 20.0),
//              child: Text(
//                "Lahan terbatas,\ncabai berlimpah",
//                style: TextStyle(color: Colors.white, fontSize: 18.0),
//              ),
//            ),
            Stack(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 300.0, bottom: 60.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  width: 340,
                                  height: 200,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 320.0, left: 6.0),
                                  child: Image.asset(
                                      "assets/img/tentang02-02.png",
                                      width: 200)),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 330),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 110.0),
                                      child: Text("Tentang Campli",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 190.0, right: 30.0),
                                      child: Flexible(
                                        child: Text(
                                            "CAMPLI mulai dibangun pada tahun 2019 dengan merancang sebuah prototipe."
                                            "Kini CAMPLI dilengkapi dengan aplikasi pemantauan",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 15.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 60.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  width: 340,
                                  height: 200,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, top: 17.0),
                                  child: Image.asset(
                                      "assets/img/tentang-031.png",
                                      width: 200)),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 85.0),
                                      child: Text("Misi Campli",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 190.0, right: 30.0),
                                      child: Flexible(
                                        child: Text(
                                            "Meningkatkan produktivitas pangan dengan lahan terbatas",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 15.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  width: 340,
                                  height: 200,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, top: 17.0),
                                  child: Image.asset(
                                      "assets/img/tentang-04.png",
                                      width: 200)),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 70.0),
                                      child: Text("Tim Campli",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 190.0, right: 30.0),
                                      child: Flexible(
                                        child: Text(
                                            "Enam orang anggota yang berdedikasi untuk menciptakan perangkat CAMPLI semakin baik kedepannya",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 15.0)),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 4, size.height / 2, size.width / 2, size.height - 100);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height - 50,
        size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 4, size.height / 2, size.width / 2, size.height - 100);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height - 50,
        size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:campli_app/navigationDrawer/navigationDrawer.dart';

class KonfigurasiDefault extends StatefulWidget {
  static const String routeName = '/KonfigurasiDefault';
  @override
  _KonfigurasiDefaultState createState() => _KonfigurasiDefaultState();
}

class _KonfigurasiDefaultState extends State<KonfigurasiDefault> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Konfigurasi Default",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      drawer: navigationDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset("assets/img/konfigdef.png", width: 290)),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 30),
              margin: EdgeInsets.only(top: 185),
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height + 400),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 190, left: 20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Text("Penyiraman Air",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5fc08f),
                              )),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 10.0,
                                      left: 20,
                                      right: 20.0),
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
                                    width: 370,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 10.0,
                                      left: 20,
                                      right: 20.0),
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
                                    width: 370,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 10.0,
                                      left: 20,
                                      right: 20.0),
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
                                    width: 370,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
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
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Text("Penambahan Pupuk",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5fc08f),
                              )),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 10.0,
                                      left: 20,
                                      right: 20.0),
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
                                    width: 370,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 10.0,
                                      left: 20,
                                      right: 20.0),
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
                                    width: 370,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 10.0,
                                      left: 20,
                                      right: 20.0),
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
                                    width: 370,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
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
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Text("Pemutaran Tiang",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5fc08f),
                              )),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 10.0,
                                      left: 20,
                                      right: 20.0),
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
                                    width: 370,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 10.0,
                                      left: 20,
                                      right: 20.0),
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
                                    width: 370,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 50.0,
                                      left: 20,
                                      right: 20.0),
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
                                    width: 370,
                                    height: 70,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DropdownBeranda extends StatefulWidget {
  @override
  _DropdownBerandaState createState() => _DropdownBerandaState();
}

class _DropdownBerandaState extends State<DropdownBeranda> {
//  String parameter;
//  String waktu;
//  String level;
//  List listParameter = ["Suhu", "Kelembaban Udara", "Kelembaban Tanah"];
//  List listWaktu = ["perjam", "3 jam", "12 jam", "24 jam"];
//  List listLevel = ["per tiang", "per lantai"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 25),
                  child: Text(
                    "Grafik Sensor Suhu",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff004d4f),
                    ),
                  ),
                ),
//                Container(
//                  width: 168,
//                  height: 30,
//                  margin: EdgeInsets.only(top: 30, left: 30),
//                  decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                        colors: [Color(0xfff2be79), Color(0xff66d9b8)]),
//                    boxShadow: [
//                      new BoxShadow(
//                        color: Colors.grey[50],
//                        blurRadius: 10.0,
//                      ),
//                    ],
//                    borderRadius: BorderRadius.all(Radius.circular(20)),
//                  ),
//                  child: Row(
//                    children: <Widget>[
//                      Padding(
//                        padding: EdgeInsets.only(left: 20),
//                        child: Row(
//                          children: <Widget>[
//                            DropdownButton(
//                              hint: Text('Parameter',
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      color: Colors.black, fontSize: 13)),
//                              value: parameter,
//                              icon: Icon(Icons.keyboard_arrow_down,
//                                  color: Colors.black, size: 20),
//                              items: listParameter.map((value) {
//                                return DropdownMenuItem(
//                                  child: Text(value),
//                                  value: value,
//                                );
//                              }).toList(),
//                              onChanged: (value) {
//                                setState(() {
//                                  listParameter = value;
//                                });
//                              },
//                            ),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 25, right: 25),
            child: Divider(
              color: Color(0xff004d4f),
              height: 20,
              thickness: 2,
            ),
          ),
//          Row(
//            children: <Widget>[
//              Container(
//                width: 150,
//                height: 30,
//                margin: EdgeInsets.only(top: 0, left: 25),
//                decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                      colors: [Color(0xfff2be79), Color(0xff66d9b8)]),
//                  boxShadow: [
//                    new BoxShadow(
//                      color: Colors.grey[50],
//                      blurRadius: 10.0,
//                    ),
//                  ],
//                  borderRadius: BorderRadius.all(Radius.circular(20)),
//                ),
//                child: Row(
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.only(left: 20),
//                      child: Row(
//                        children: <Widget>[
//                          DropdownButton(
//                            hint: Text('Waktu',
//                                style: TextStyle(
//                                    color: Colors.black, fontSize: 14)),
//                            value: waktu,
//                            icon: Padding(
//                              padding: const EdgeInsets.only(left: 30),
//                              child: Icon(Icons.keyboard_arrow_down,
//                                  color: Colors.black, size: 20),
//                            ),
//                            items: listWaktu.map((value) {
//                              return DropdownMenuItem(
//                                child: Text(value),
//                                value: value,
//                              );
//                            }).toList(),
//                            onChanged: (value) {
//                              setState(() {
//                                listWaktu = value;
//                              });
//                            },
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              Container(
//                width: 150,
//                height: 30,
//                margin: EdgeInsets.only(top: 0, left: 45),
//                decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                      colors: [Color(0xfff2be79), Color(0xff66d9b8)]),
//                  boxShadow: [
//                    new BoxShadow(
//                      color: Colors.grey[50],
//                      blurRadius: 10.0,
//                    ),
//                  ],
//                  borderRadius: BorderRadius.all(Radius.circular(20)),
//                ),
//                child: Row(
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.only(left: 15),
//                      child: Row(
//                        children: <Widget>[
//                          DropdownButton(
//                            hint: Text('Parameter',
//                                style: TextStyle(
//                                    color: Colors.black, fontSize: 14)),
//                            value: level,
//                            icon: Padding(
//                              padding: const EdgeInsets.only(left: 0),
//                              child: Icon(Icons.keyboard_arrow_down,
//                                  color: Colors.black, size: 20),
//                            ),
//                            items: listParameter.map((value) {
//                              return DropdownMenuItem(
//                                child: Text(value,
//                                    style: TextStyle(
//                                        color: Colors.black, fontSize: 12)),
//                                value: value,
//                              );
//                            }).toList(),
//                            onChanged: (value) {
//                              setState(() {
//                                listParameter = value;
//                              });
//                            },
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
        ],
      ),
    );
  }
}

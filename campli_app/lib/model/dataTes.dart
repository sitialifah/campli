/// Halaman scroll untuk riwayat terkini
/// card ini digunakan di beranda
/// PUNYA RIWAYAT TERKNINI

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScrollRiwayat extends StatefulWidget {
  @override
  _ScrollRiwayatState createState() => _ScrollRiwayatState();
}

class _ScrollRiwayatState extends State<ScrollRiwayat> {
  List<String> tindakan = [
    "Segera lakukan tindakan!",
    "Aman, lakukan perawatan berkala ya!",
    "Segera lakukan tindakan!",
    "Segera lakukan tindakan!",
  ];
  List<String> riwayat = [
    "Penyiraman Air",
    "Pemutaran tiang",
    "Tanaman P01 LT301",
    "Sensor suhu",
  ];
  List<String> tanggal = [
    "\t\t21/1/2020",
    "\t\t21/1/2020",
    "\t\t21/1/2020",
    "\t\t20/1/2020",
  ];
  List<String> jam = [
    "\t\t11.00 AM",
    "\t\t09.00 AM",
    "\t\t08.00 AM",
    "\t\t07.30 AM",
  ];
  List<String> status = [
    "gagal",
    "berhasil",
    "kering",
    "mati",
  ];

  List<String> ID = [
    "TA201",
    "TB101",
    "TA205",
    "TA301",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1410, left: 15, right: 15, bottom: 0),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 40.0),
        scrollDirection: Axis.horizontal,
        itemCount: riwayat.length,
        itemBuilder: (BuildContext context, int index) => Container(
          width: 197,
          height: 80,
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 0.0),
                        child: Text(
                          riwayat[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff004d4f),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 0)),
                          Text(
                            "ID\t:\t\t",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff004d4f),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ID[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, left: 5.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Icon(FontAwesomeIcons.clock,
                                            color: Color(0xff4EBF9F),
                                            size: 17)),
                                    TextSpan(
                                      text: jam[index],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Icon(FontAwesomeIcons.calendar,
                                            color: Color(0xff4EBF9F),
                                            size: 17)),
                                    TextSpan(
                                      text: tanggal[index],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                          child: Container(
                            padding:
                            EdgeInsets.only(top: 10.0, left: 25, right: 25),
                            child: Container(
                              height: 30,
                              width: 90,
                              decoration: new BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xfff2be79),
                                    Color(0xff66d9b8)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: new BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  status[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title: Text("Riwayat",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                  child: Icon(
                                                      Icons.brightness_1,
                                                      color: Color(0xff4EBF9F),
                                                      size: 15)),
                                              TextSpan(
                                                  text: riwayat[index],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                  child: Icon(
                                                      Icons.brightness_1,
                                                      color: Color(0xff4EBF9F),
                                                      size: 15)),
                                              TextSpan(
                                                  text: "ID Tiang\t:\t\t",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                              TextSpan(
                                                  text: ID[index],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                  child: Icon(
                                                      Icons.brightness_1,
                                                      color: Color(0xff4EBF9F),
                                                      size: 15)),
                                              TextSpan(
                                                  text: "Kondisi\t:\t\t",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                              TextSpan(
                                                  text: status[index],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                  child: Icon(
                                                      Icons.brightness_1,
                                                      color: Color(0xff4EBF9F),
                                                      size: 15)),
                                              TextSpan(
                                                  text: "Waktu terakhir :",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 8.0, left: 30.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                  child: Icon(
                                                      FontAwesomeIcons.clock,
                                                      color: Color(0xff4EBF9F),
                                                      size: 15)),
                                              TextSpan(
                                                  text: (jam[index]),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 8.0, left: 30.0, bottom: 20.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                  child: Icon(
                                                      FontAwesomeIcons.calendar,
                                                      color: Color(0xff4EBF9F),
                                                      size: 15)),
                                              TextSpan(
                                                  text: (tanggal[index]),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 5.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                  child: Icon(
                                                      Icons.brightness_1,
                                                      color: Color(0xff4EBF9F),
                                                      size: 15)),
                                              TextSpan(
                                                  text: tindakan[index],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop('Atasi');
                                    },
                                    color: Color(0xfff2be79),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Text('Atasi',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18)),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop('Tutup');
                                    },
                                    color: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Text('Tutup',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18)),
                                  ),
                                ],
                              ),
                            ).then((result) {
                              print(result);
                            });
                          }),
                      SizedBox(width: 10.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

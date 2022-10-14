import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Tiang/TambahTiang.dart';
import 'package:campli_app/model/dataTiang.dart';

///
/// Widget untuk tombol Landing Page.
/// Gabungan dua widget: tombol dan tulisan keterangan dibawahnya.
///
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_button.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/Pages/Page.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Aktuator/Konfigurasi/KonfigurasiPage.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Lantai/LantaiPage.dart';
import 'package:campli_app/model/dataTiang.dart';

class TombolTambahKonfigurasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 45.0,
          child: RaisedButton(
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => KonfigurasiPage()),
//              );
//            },
            //AlertDialog end
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: GRADIEN_2,
                  borderRadius: BorderRadius.circular(25.0)),
              child: Container(
                constraints: BoxConstraints(maxWidth: 180.0, minHeight: 10.0),
                alignment: Alignment.center,
                child: Text(
                  LABEL_TOMBOL_TAMBAH,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTextLightColor,
                      fontSize: LABEL_BUTTON_UKURAN_FONT),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TombolTambahLantai extends StatelessWidget {
  final String id;
  final String namaTiang;
  const TombolTambahLantai(this.id, this.namaTiang, {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: TINGGI_BUTTON,
          //margin: const EdgeInsets.only(top: 150.0),
          child: RaisedButton(
            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => LantaiPage()),
//              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: RADIUS_SUDUT_BUTTON,
            ),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: GRADIEN_1,
                borderRadius: RADIUS_SUDUT_BUTTON,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 250.0,
                  minHeight: 10.0,
                ),
                alignment: Alignment.center,
                child: Text(
                  LABEL_TOMBOL_TAMBAH,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextLightColor,
                    fontSize: LABEL_BUTTON_UKURAN_FONT,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

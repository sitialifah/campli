///
/// Widget untuk tombol Landing Page.
/// Gabungan dua widget: tombol dan tulisan keterangan dibawahnya.
///
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_button.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/Pages/LoginPage.dart';

class TombolLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: TINGGI_BUTTON,
          //margin: const EdgeInsets.only(top: 150.0),
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
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
                  maxWidth: 330.0,
                  minHeight: 10.0,
                ),
                alignment: Alignment.center,
                child: Text(
                  LABEL_TOMBOL_MULAI,
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

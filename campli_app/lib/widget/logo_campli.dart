///
/// Widget untuk Logo CAMPLI.
/// Terdiri atas gambar logo.
///
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/gambar.dart';

class LogoCampli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          GAMBAR_LOGO_CAMPLI,
          width: 250,
          height: 150,
        ),
      ],
    );
  }
}

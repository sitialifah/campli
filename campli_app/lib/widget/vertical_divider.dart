/// vertical divider untuk pembatas
/// digunakan dibeberapa halaman, seperti beranda
///

import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_vertical_divider.dart';

class VerticalDividerBeranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: TINGGI_VERTICAL_DIVIDER_BERANDA,
      width: LEBAR_VERTICAL_DIVIDER,
      color: WARNA_VERTICAL_DIVIDER,
      margin: const EdgeInsets.only(left: 5.0, top: 5, bottom: 5),
    );
  }
}

class VerticalDividerTiangLantai extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: LEBAR_VERTICAL_DIVIDER,
      color: WARNA_VERTICAL_DIVIDER,
      margin: const EdgeInsets.only(left: 8.0, top: 0, bottom: 0),
    );
  }
}

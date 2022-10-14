///
/// Widget untuk Background CLIPPATH.
/// Terdiri atas banyak gambar.
/// Terdapat beberapa class sesuai kebutuhan per halaman
///
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/gambar.dart';

class BgBeranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
//          child: Align(
//              alignment: Alignment.topLeft,
//              child: Image.asset(GAMBAR_POHON_BERANDA, width: 700)),
//        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 140, right: 0),
          child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(GAMBAR_LINGKARAN_SEDANG, width: 140)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50, right: 70),
          child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(GAMBAR_LINGKARAN_SEDANG, width: 120)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 0, right: 200),
          child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(GAMBAR_LINGKARAN_BESAR, width: 250)),
        ),
      ],
    );
  }
}

/// untuk halaman tiang, lantai, riwayat, lantai, konfigurasi
/// dan ping
class BgHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
          child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(GAMBAR_LINGKARAN_SEDANG, width: 140)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(GAMBAR_LINGKARAN_KECIL, width: 200)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(GAMBAR_LINGKARAN_KECIL, width: 100)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 0, right: 200),
          child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(GAMBAR_LINGKARAN_BESAR, width: 250)),
        ),
      ],
    );
  }
}

/// untuk halaman tambah tiang, tambah lantai
class BgHeader1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.only(top: 5, left: 150, right: 20),
//          child: Align(
//              alignment: Alignment.topRight,
//              child: Image.asset(GAMBAR_POHON_KECIL, width: 125)),
//        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 140, right: 0),
          child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(GAMBAR_LINGKARAN_SEDANG, width: 140)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 0, right: 200),
          child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(GAMBAR_LINGKARAN_BESAR, width: 250)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150, left: 150, right: 78),
          child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(GAMBAR_LINGKARAN_SEDANG, width: 190)),
        ),
      ],
    );
  }
}

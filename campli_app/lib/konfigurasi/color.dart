/// Semua warna yang digunakan di app Campli ada di halaman ini
/// Halaman ini juga ada gradient untuk tombol dsb

import 'package:flutter/material.dart';

// Colors
const kBackgroundColor = Color(0xfff6f8fb);
const kTextColor = Color(0xFF303030); //warna tulisan app bar yg hitam
const kBodyTextColor = Color(0xFF9D9D9);
const kTextLightColor = Color(0xFFFEFEFE);
const kTextDarkColor = Colors.black;
const kTextInput = Colors.black87;
const kTextNilai = Colors.grey;
const kTextFadedText = Colors.black38;
const kPrimaryColor = Color(0xff004d4f);
const kLightColor = Color(0xff5fc08f);
const kTransparentColor = Colors.transparent;
const kAccentColor = Color(0xff66d9b8); //bg app bar
const kTextLightColorDua = Color(0xff4bac98);
const kLightColorDua = Color(0xfff2b47e);
const kSplashColor = Colors.red;

final kShadowColor =
    Color(0xFFB7B7B7).withOpacity(.5); //warna shadow untuk card

/// Warna button ber-gradien mengikuti warna logo.
final LinearGradient GRADIEN_1 = LinearGradient(
  colors: [Color(0xff66d9b8), Color(0xff5fc08f)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

/// Warna clipPath ber-gradien
final LinearGradient GRADIEN_CLIPPATH = LinearGradient(
  colors: [Color(0xff66d9b8), Color(0xff61c891)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  tileMode: TileMode.clamp,
);

/// Warna bgIcon ber-gradien
final LinearGradient GRADIEN_2 = LinearGradient(
  colors: [Color(0xff66d9b8), Color(0xfff2b47e)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  tileMode: TileMode.clamp,
);

/// Warna bgIcon ber-gradien untuk bagian Ping Page
final LinearGradient GRADIEN_3 = LinearGradient(
  colors: [Color(0xfff2b47e), Color(0xff63d0a4)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  tileMode: TileMode.clamp,
);

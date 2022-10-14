///
/// Konfigurasi dan Style untuk berbagai container body .
///
import 'package:flutter/material.dart';
import 'style_tulisan.dart';

/// Semua container memakai sudut lingkaran dengan style ini.
final BorderRadius RADIUS_SUDUT_CONTAINER = BorderRadius.only(
    topLeft: Radius.circular(29), topRight: Radius.circular(29));

/// Semua container memakai shadow dengan style ini.
final BoxShadow SHADOW_CONTAINER = BoxShadow(
  color: Colors.white10,
  blurRadius: 20.0,
);

/// Semua container body menggunakan style warna ini.
final Color WARNA_CONTAINER = Color(0xfff6f8fb);

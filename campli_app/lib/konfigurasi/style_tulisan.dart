import 'package:campli_app/konfigurasi/color.dart';

///
/// Style untuk berbagai tulisan di aplikasi.
///
import 'package:flutter/material.dart';

/// Ukuran font untuk tulisan keterangan di bawah button.
final double LABEL_BAWAH_BUTTON_UKURAN_FONT = 14;

/// Ukuran font untuk tulisan pada button.
final double LABEL_BUTTON_UKURAN_FONT = 20;

/// Style untuk nama aplikasi.
final TextStyle STYLE_NAMA_APLIKASI = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  height: 1.75,
  fontSize: 20.0,
);

/// Ukuran font untuk tulisan nilai parameter kondisi tanaman di beranda(misal 28°C dsb).
final double LABEL_NILAI_PARAMETER_BERANDA = 18;

/// Ukuran font untuk nama parameter kondisi tanaman di beranda(misal suhu dsb).
final double LABEL_NAMA_PARAMETER_BERANDA = 13;

/// Style untuk edit hapus di lantai page.
final TextStyle STYLE_PERINTAH_UMUM = TextStyle(
  color: kLightColor,
  fontSize: 16.0,
);

/// Style untuk tulisan aktuator dan sensor di halaman ping
final TextStyle STYLE_PING_PAGE = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 14.0,
);

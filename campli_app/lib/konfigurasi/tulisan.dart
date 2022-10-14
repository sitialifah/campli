///
/// Tulisan statis pada aplikasi.
///
import 'package:http/http.dart' as http;

/// Nama aplikasi ini.
const String NAMA_APLIKASI = "CAMPLI";

/// Label tombol Landing Page
const String LABEL_TOMBOL_MULAI = "Mulai";

/// Label tombol Login
const String LABEL_TOMBOL_LOGIN = "Masuk dengan Akun Google";

/// Label tombol Tambah
const String LABEL_TOMBOL_TAMBAH = "Simpan";

/// Tulisan untuk parameter sensor
const String SUHU = "Suhu";
const String UDARA = "Kelembaban Udara";
const String TANAH = "Kelembaban Tanah";

/// Tulisan untuk aktuator
const String A_AIR = "Aktuator Air";
const String A_PUPUK = "Aktuator Pupuk";
const String A_PUTAR = "Aktuator Putar";
const String A_SUHU_UDARA = "Sensor Suhu dan\nKelembaban Udara";
const String A_TANAH = "Sensor Kelembaban\nTanah";

/// Tulisan Perintah
const String EDIT = "Edit";
const String HAPUS = "Hapus";

var url = "https://ta-campli.et.r.appspot.com";

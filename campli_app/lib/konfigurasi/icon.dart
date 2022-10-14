import 'package:campli_app/Pages/app_icons.dart';

///
/// Icon-icon yang dipakai pada aplikasi sekaligus stylenya.
///
///

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:flutter_icons/entypo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:weather_icons/weather_icons.dart';

/// Icon umum
const IconData ICON_TAMBAH = Icons.add;
const IconData ICON_CARI = Icons.search;
const IconData ICON_SELENGKAPNYA = Icons.navigate_next;
final Icon ICON_TITIK = Icon(Icons.brightness_1, color: kAccentColor, size: 15);

///  style untuk Tiang
final Icon ICON_EDIT1 = Icon(Icons.edit, color: kPrimaryColor, size: 15);
final Icon ICON_HAPUS1 = Icon(Icons.delete, color: kPrimaryColor, size: 20);

/// style untuk lantai page
final Icon ICON_EDIT2 = Icon(Icons.edit, color: kLightColor, size: 14);
final Icon ICON_HAPUS2 = Icon(Icons.delete, color: kLightColor, size: 14);

/// style untuk Konfigurasi
final Icon ICON_BATAL = Icon(Icons.cancel, color: kLightColorDua, size: 30);

/// Icon konfigurasi waktu dan riwayat
final Icon ICON_JAM =
    Icon(FontAwesomeIcons.clock, color: kLightColor, size: 15);
final Icon ICON_TANGGAL =
    Icon(FontAwesomeIcons.calendar, color: kLightColor, size: 15);
final Icon ICON_DATETIME =
    Icon(Icons.access_alarm, color: kLightColor, size: 20);

const IconData AIR = FontAwesomeIcons.tint;
const IconData PUPUK = FontAwesomeIcons.seedling;
const IconData PUTAR = Icons.autorenew;
const IconData ICON_TANAH = WeatherIcons.humidity;
const IconData SUHU_UDARA = FontAwesomeIcons.cloudSun;

/// Icon yang dipakai di lantai page
final Icon ICON_SUHU =
    Icon(Typicons.weather_partly_sunny, color: kTextDarkColor, size: 22);
final Icon ICON_UDARA =
    Icon(Entypo.getIconData("air"), color: kTextDarkColor, size: 22);

/// Icon untuk navigationDrawer
const IconData KONFIGURASI_DEF = FontAwesomeIcons.slidersH;
const IconData TENTANG_APP = Icons.info;
const IconData BANTUAN = Icons.help;
const IconData KELUAR = FontAwesomeIcons.signOutAlt;

/// Container yang berisi Icon masalah yang dipakai di Riwayat
final Container CONTAINER_MASALAH = Container(
  height: 40,
  width: 40,
  decoration: new BoxDecoration(
    color: kLightColorDua,
    borderRadius: new BorderRadius.circular(40.0),
  ),
  child: Icon(FontAwesomeIcons.times, color: kTextDarkColor, size: 22),
);

/// Container yang berisi Icon Aman yang dipakai di Riwayat
final Container CONTAINER_AMAN = Container(
  height: 40,
  width: 40,
  decoration: new BoxDecoration(
    color: kLightColor,
    borderRadius: new BorderRadius.circular(40.0),
  ),
  child: Icon(FontAwesomeIcons.check, color: kTextDarkColor, size: 22),
);

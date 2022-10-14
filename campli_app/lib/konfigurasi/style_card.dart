import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'color.dart';

///
/// Card-card yang digunakan di Aplikasi
///

/// Padding semua card
final EdgeInsets PADDING_CARD = EdgeInsets.all(10.0);

/// Margin semua card
final EdgeInsets MARGIN_CARD = EdgeInsets.all(12.0);

/// Warna semua card
final Color WARNA_CARD = Colors.white;

/// Box Shadow untuk card
final BoxShadow BOX_SHADOW_CARD = BoxShadow(
  color: kShadowColor,
  offset: Offset(4.0, 4.0),
  spreadRadius: 2,
  blurRadius: 8.0,
);

/// Border radius card
final BorderRadius RADIUS_SUDUT_CARD = BorderRadius.circular(15.0);

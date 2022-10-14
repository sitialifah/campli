///
/// Widget untuk semua card
///

import 'package:campli_app/konfigurasi/style_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: PADDING_CARD,
          margin: MARGIN_CARD,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: RADIUS_SUDUT_CARD,
              color: WARNA_CARD,
              boxShadow: [
                BOX_SHADOW_CARD,
              ],
            ),
          ),
        )
      ],
    );
  }
}

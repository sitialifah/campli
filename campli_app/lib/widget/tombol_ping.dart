///
/// Widget untuk tombol login.
/// Terdiri dari 1 widget: tombol masuk.
///
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/color.dart';

class TombolPing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: FlatButton(
            color: kLightColorDua,
            splashColor: kSplashColor,
            onPressed: () {/*...*/},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("PING",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextLightColor,
                  fontSize: 15,
                )),
          ),
        ),
      ],
    );
  }
}

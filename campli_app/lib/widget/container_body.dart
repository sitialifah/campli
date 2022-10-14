///
/// Widget untuk Container Body.
/// Terdiri atas container yang dipakai sebagai background body di setiap halaman.
///
import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_container_body.dart';

class ContainerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 30),
      margin: EdgeInsets.only(top: 150),
      constraints:
          BoxConstraints.expand(height: MediaQuery.of(context).size.height),
      decoration: BoxDecoration(
        color: WARNA_CONTAINER,
        borderRadius: RADIUS_SUDUT_CONTAINER,
        boxShadow: [
          SHADOW_CONTAINER,
        ],
      ),
    );
  }
}

class ContainerBodyRiwayat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 30),
      margin: EdgeInsets.only(top: 100),
      constraints:
          BoxConstraints.expand(height: MediaQuery.of(context).size.height),
      decoration: BoxDecoration(
        color: WARNA_CONTAINER,
        borderRadius: RADIUS_SUDUT_CONTAINER,
        boxShadow: [
          SHADOW_CONTAINER,
        ],
      ),
    );
  }
}

/// Container untuk tambah tiang
class ContainerBody1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 30),
      margin: EdgeInsets.only(top: 180),
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height - 180),
      decoration: BoxDecoration(
        color: WARNA_CONTAINER,
        borderRadius: RADIUS_SUDUT_CONTAINER,
        boxShadow: [
          SHADOW_CONTAINER,
        ],
      ),
    );
  }
}

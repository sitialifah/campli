///
/// Screen untuk Landing Page.
///
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:campli_app/widget/tombol_landing.dart';

//1. stful buat class baru sekalian class state
//2. stless untuk buat class baru

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/landing_page.png'),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 70.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 40.0),
              child: Text(
                'Halo, \nSelamat Datang !',
                style: TextStyle(
                    color: Color(0xff004d4f),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Pantau kondisi tanaman dan kelola \nperangkat CAMPLI',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            // SizedBox(
            // height: 20,
            // ),

            //buat button mulai
            SafeArea(
              minimum: EdgeInsets.only(top: 400.0),
              child: Center(
                child: TombolLandingPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

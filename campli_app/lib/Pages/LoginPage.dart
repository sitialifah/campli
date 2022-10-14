import 'package:campli_app/Pages/Home.dart';
import 'package:campli_app/model/dataUser.dart';
import 'package:campli_app/model/google_signin_api.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Animation/FadeAnimation.dart';
import 'package:campli_app/konfigurasi/style_button.dart';
import 'package:campli_app/konfigurasi/style_tulisan.dart';
import 'package:campli_app/konfigurasi/tulisan.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:campli_app/Pages/Page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/masuk-01.png'),
                  fit: BoxFit.cover)),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 450.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                          2,
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Selamat Datang!",
                              style: TextStyle(
                                fontSize: 30,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Pantau perangkat CAMPLI dan lihat',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'kondisi tanaman dengan CAMPLI APP',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: TINGGI_BUTTON,
                                  //margin: const EdgeInsets.only(top: 150.0),
                                  child: RaisedButton(
                                    onPressed: signIn,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: RADIUS_SUDUT_BUTTON,
                                    ),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: GRADIEN_1,
                                        borderRadius: RADIUS_SUDUT_BUTTON,
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 350.0,
                                          minHeight: 50.0,
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width: 35),
                                            Icon(
                                              FontAwesomeIcons.google,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              LABEL_TOMBOL_LOGIN,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: kTextLightColor,
                                                fontSize:
                                                    LABEL_BUTTON_UKURAN_FONT,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final user = await GoogleSignInAPI.login();
    if (user == null) {
      print('test');
      Scaffold.of(this.context)
          .showSnackBar(SnackBar(content: Text('Sign In Failed')));
    } else {
      GoogleSignInAccount data = user;
      String email = data.email;
      String displayName = data.displayName;
      String photoUrl = data.photoUrl;

      final response =
          await http.get(Uri.parse(url + '/user/cariemail/' + email));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        SharedPreferences sessionRole = await SharedPreferences.getInstance();
        sessionRole.setString('role', 'user');
        sessionRole.setString('email', email);
        sessionRole.setString('displayName', displayName);
        sessionRole.setString('photoUrl', photoUrl);
        print(email);
        print(displayName);
        print(photoUrl);
        Navigator.of(this.context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(user: user),
        ));
//        return DataUser.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        await GoogleSignInAPI.logout();
        Fluttertoast.showToast(
            msg: "Email tidak terdaftar!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);

//        throw Exception('Email user tidak ditemukan');

      }
    }
  }
}

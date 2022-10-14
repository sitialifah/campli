//halaman bottom navigation yg panggil parameter halaman tiang, beranda, dan riwayat.
// ketiga halaman itu ada di Page.dart
import 'Page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:campli_app/model/google_signin_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final GoogleSignInAccount user;
  Home({Key key, final this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    TiangPageTwo(),
    BerandaPage(),
    RiwayatPage(),
  ];

//  static GoogleSignInAccount get email => null;

  Future signIn() async {
    final user = await GoogleSignInAPI.login();
    if (user == null) {
      print('test');
      Scaffold.of(this.context)
          .showSnackBar(SnackBar(content: Text('Sign In Failed')));
    } else {
      GoogleSignInAccount data = user;
      String email = data.email;
      SharedPreferences sessionRole = await SharedPreferences.getInstance();
      sessionRole.setString('role', 'user');
      sessionRole.setString('email', email);
      print(email);
      Navigator.of(this.context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home(user: user),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTapped,
          fixedColor: Color(0xff66d9b8),
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.list), title: Text('Tiang')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.home), title: Text('Beranda')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.history), title: Text('Riwayat')),
          ]),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

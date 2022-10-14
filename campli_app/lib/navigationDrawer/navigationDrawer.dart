import 'package:campli_app/Pages/LoginPage.dart';
import 'package:campli_app/konfigurasi/icon.dart';
import 'package:campli_app/model/google_signin_api.dart';
import 'package:campli_app/routes/pageRoutes.dart';
import 'package:flutter/material.dart';
import 'Pages/Page.dart';
//import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/navigationDrawer/createDrawerHeader.dart';
//import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/navigationDrawer/createDrawerBodyItem.dart';
//import 'package:campli_app/konfigurasi/icon.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:campli_app/konfigurasi/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'createDrawerBodyItem.dart';

class navigationDrawer extends StatefulWidget {
  final GoogleSignInAccount user;

  navigationDrawer({Key key, final this.user}) : super(key: key);
  @override
  _navigationDrawerState createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  SharedPreferences user;
  String email;
  String displayName;
  String photoUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    user = await SharedPreferences.getInstance();
    setState(() {
      email = user.getString('email');
      displayName = user.getString('displayName');
      photoUrl = user.getString('photoUrl');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: <Widget>[
              DrawerHeader(
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
                decoration: BoxDecoration(gradient: GRADIEN_1),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 115.0, top: 20),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(photoUrl == null
                            ? "https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png"
                            : photoUrl),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          displayName,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 90.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          email,
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              createDrawerBodyItem(
                icon: TENTANG_APP,
                text: 'Tentang Campli',
                onTap: () => Navigator.pushReplacementNamed(
                    context, pageRoutes.tentangCampli),
              ),
              createDrawerBodyItem(
                icon: BANTUAN,
                text: 'Bantuan',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, pageRoutes.bantuan),
              ),
              createDrawerBodyItem(
                icon: KELUAR,
                text: 'Logout',
                onTap: () async {
                  await GoogleSignInAPI.logout();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
                },
              ),
              Divider(),
              ListTile(
                title: Text('App version 1.0.0'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

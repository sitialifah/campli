//import 'package:campli_app/Pages/BottomNavBarPage.dart';
import 'package:campli_app/Pages/BantuanPage.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Lantai/LantaiPage.dart';
import 'package:campli_app/Pages/Page.dart';
import 'file:///F:/FLUTTER_CAMPLI/campli-mobile/Code/campli_app/lib/Pages/Ping/PingPage.dart';
import 'package:campli_app/Pages/TentangCampli.dart';
import 'package:campli_app/routes/pageRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Pages/SplashScreen.dart';
import 'Pages/KonfigursiDefault.dart';
import 'Pages/Aktuator/Konfigurasi/KonfigurasiPage.dart';
import 'konfigurasi/color.dart';

//main function = starting point for all our flutter apps
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CAMPLI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //primarySwatch: Colors.teal,
          primaryColor: Color(0xff004d4f),
          //accentIconTheme: IconThemeData(color: Colors.white),
          accentColor: Color(0xff4bac98),
        ),
//        home: BerandaPage(),
        home: SplashScreen(),
        routes: {
          pageRoutes.konfigurasiDefault: (context) => KonfigurasiDefault(),
          pageRoutes.tentangCampli: (context) => TentangCampli(),
          pageRoutes.bantuan: (context) => BantuanPage(),
        });

    //home: BottomNavPage());
  }
}

import 'package:campli_app/Pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:campli_app/widget/logo_campli.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;

  AnimationController controller;
  void initState() {
    super.initState();
    splashScreenStart();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.ease);
    animation = Tween(begin: 1.0, end: 0.2).animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        controller.reverse();
      else if (status == AnimationStatus.dismissed) controller.forward();
    });
    controller.forward();
  }

  splashScreenStart() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //color: Color(0xffb1e8c5),
      backgroundColor: Colors.white,
      body: Center(
          child: FadeTransition(opacity: animation, child: LogoCampli())),
    );
  }
}

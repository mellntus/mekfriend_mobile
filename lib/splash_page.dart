import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/home_page.dart';
import 'package:test_flutter/login_page.dart';
import 'package:test_flutter/routes/route.dart' as route;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  void _checkAuth() {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushNamedAndRemoveUntil(context, route.homePage, (route) => false);

    } else {
      Navigator.pushNamedAndRemoveUntil(context, route.loginPage, (route) => false);
    }
  }



  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Splash"),
        ),
      ),
    );
  }
}

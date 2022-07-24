import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/pages/home/home_page.dart';
import 'package:test_flutter/pages/login/login_page.dart';
import 'package:test_flutter/route.dart' as route;

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

        ),
      ),
    );
  }
}

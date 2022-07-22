import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/pages/home_page.dart';
import 'package:test_flutter/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  void _checkAuth() {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.push(context, MaterialPageRoute(builder: (builder) => HomePage()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (builder) => LoginPage()));
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

import 'package:flutter/material.dart';
import 'package:test_flutter/home_page.dart';
import 'package:test_flutter/login_page.dart';
import 'package:test_flutter/register_page.dart';

import '../splash_page.dart';

const homePage = "home_page";
const loginPage = "login_page";
const registerPage = "register_page";
const splashPage = "splash_page";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case registerPage:
      return MaterialPageRoute(builder: (context) => const RegisterPage());
    case splashPage:
      return MaterialPageRoute(builder: (context) => const SplashPage());
    default:
      throw("no such route");
  }
}


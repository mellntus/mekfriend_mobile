import 'package:flutter/material.dart';
import 'package:test_flutter/pages/login/login_page.dart';
import 'package:test_flutter/pages/register/register_page.dart';
import 'package:test_flutter/pages/home/home_page.dart';
import 'package:test_flutter/pages/comment/comment_page.dart';
import 'package:test_flutter/pages/profile/profilepage.dart';
import 'package:test_flutter/splash_page.dart';

const homePage = "home_page";
const loginPage = "login_page";
const registerPage = "register_page";
const splashPage = "splash_page";
const createPostPage = "createPost_page";
const commentPage = "comment_page";
const profilePage = "profile_page";

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
    case profilePage:
      return MaterialPageRoute(builder: (context) => const Profilepage());
    default:
      throw("no such route");
  }
}


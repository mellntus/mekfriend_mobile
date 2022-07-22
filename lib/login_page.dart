import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/pages/home_page.dart';
import 'package:test_flutter/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late FirebaseAuth firebaseAuth;


  @override
  void initState() {
    super.initState();

    firebaseAuth = FirebaseAuth.instance;
  }

  void login(String email, String password) {
    firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (builder) => HomePage()));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${error.toString()}")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email"
                ),
              ),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password"
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    login(_emailController.text, _passController.text);
                  },
                  child: const Text("Login")
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=> RegisterPage()));
                  },
                  child: const Text("Register")
              )
            ],
          ),
        ),
      ),
    );
  }
}

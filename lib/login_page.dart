import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/home_page.dart';
import 'package:test_flutter/register_page.dart';
import 'package:test_flutter/routes/route.dart' as route;

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

  void login(NavigatorState nav,String email, String password) {
    firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login successful")));
      nav.pushNamedAndRemoveUntil(route.homePage, (route) => false);
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
              Image.asset('assets/images/MekFriend.png'),
              Padding(
                padding: EdgeInsets.all(30),
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
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                login(Navigator.of(context), _emailController.text, _passController.text);
                              },
                              child: const Text("Login")
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (builder)=> RegisterPage()));
                              },
                              child: const Text("Register")
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

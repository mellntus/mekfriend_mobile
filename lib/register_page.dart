import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/pages/home/home_page.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  late FirebaseAuth firebaseAuth;
  late FirebaseDatabase firebaseDatabase;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    
    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;
  }

  void saveDataToDatabase(String email, String name) {
    firebaseDatabase.ref("users/${firebaseAuth.currentUser!.uid}/profile").set({
      "email": email,
      "name": name,
      "alamat": "not set",
      "last_login": DateFormat("d MMMM yyyy").format(DateTime.now()),
      "username": "not set"
    }).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (builder) => HomePage()));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${error.toString()}")));
    });

  }
  
  void register(String email, String password, String name) {
    firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      saveDataToDatabase(email, name);
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${error.toString()}")));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
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
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: "Name"
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        register(_emailController.text, _passController.text, _nameController.text);
                      },
                      child: const Text("Register")
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

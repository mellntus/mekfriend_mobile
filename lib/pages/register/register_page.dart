import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/route.dart' as route;
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
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;
  }

  void saveDataToDatabase(NavigatorState nav,String email, String name, String alamat) {
    firebaseDatabase.ref("users/${firebaseAuth.currentUser!.uid}/profile").set({
      "alamat": alamat,
      "email": email,
      "last_login": DateFormat("d MMMM yyyy").format(DateTime.now()),
      "username": name
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login successful")));
      nav.pushNamedAndRemoveUntil(route.homePage, (route) => false);
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${error.toString()}")));
    });

  }

  void backLogin(NavigatorState nav){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Navigating to Register...")));
    nav.pushNamedAndRemoveUntil(route.loginPage, (route) => false);
  }

  void register(NavigatorState nav, String email, String password, String name,
      String confirmPassword, String alamat) {
    if(password == confirmPassword) {
      firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password).then((value) {
        saveDataToDatabase(nav, email, name, alamat);
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${error.toString()}")));
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: Password Doesn't Match")));
    }
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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: "Username"
                      ),
                    ),
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
                      controller: _confirmPassController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Confirm Password"
                      ),
                    ),
                    TextField(
                      controller: _alamatController,
                      decoration: InputDecoration(
                          labelText: "Alamat"
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 40
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              backLogin(Navigator.of(context));
                            },
                            child: const Text("Back")
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            register(Navigator.of(context) , _emailController.text, _passController.text, _nameController.text, _confirmPassController.text, _alamatController.text);
                          },
                          child: const Text("Register")
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/widgets/appbar_widget.dart';
import 'package:test_flutter/widgets/profile_widget.dart';
import 'editprofilepage.dart';
import 'package:test_flutter/user.dart';



class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);
  @override
  _Profilepage createState() => _Profilepage();
}

class _Profilepage extends State<Profilepage> {

  late FirebaseDatabase firebaseDatabase;
  late FirebaseAuth firebaseAuth;



  late UserProfile user;

  @override
  void initState() {
    super.initState();

    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;
    user = UserProfile(imagePath: "https://i.pinimg.com/236x/9d/d0/8a/9dd08a06d6aed22b348e4a49791bbf3b.jpg", name: "", address: "", email: "");
    getNameData();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=> Editprofilepage()));
              },
            ),
            const SizedBox(height: 24),
            buildName(user),
          ],
        )
    );
  }


  Widget buildName(UserProfile user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24 ),
      ),
      const SizedBox(height: 4),
      Text(
        user.address,
        style: TextStyle(color: Colors.grey ),
      ),
    ],
  );

  void getNameData() {
    firebaseDatabase.ref("users_test/${firebaseAuth.currentUser!.uid}").get().then((value) {
      var res = value.value as Map<dynamic, dynamic>;
      user = UserProfile(imagePath: "https://i.pinimg.com/236x/9d/d0/8a/9dd08a06d6aed22b348e4a49791bbf3b.jpg", name: res["name"], address: res["alamat"], email: res["email"]);
      setState(() {

      });
    });
  }

}
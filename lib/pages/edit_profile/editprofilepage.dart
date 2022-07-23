import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/widgets/appbar_widget.dart';
import 'package:test_flutter/widgets/profile_widget.dart';
import 'package:test_flutter/widgets/textfield_widget.dart';
import 'editprofilepage.dart';
import 'package:test_flutter/user.dart';




class Editprofilepage extends StatefulWidget {
  const Editprofilepage({Key? key}) : super(key: key);

  @override
  State<Editprofilepage> createState() => _Editprofilepage();
}

class _Editprofilepage extends State<Editprofilepage> {

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
  Widget build(BuildContext context) => Scaffold(
    appBar: buildAppBar(context),
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
        ProfileWidget(
            imagePath: user.imagePath,
            isEdit: true,
            onClicked: () async {}
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Nama',
          text: user.name,
          onChanged: (name){},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Email',
          text: user.email,
          onChanged: (address){},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Alamat',
          text: user.address,
          onChanged: (about){},
        ),
      ],
    ),
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
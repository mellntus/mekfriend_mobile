import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/widgets/appbar_widget.dart';
import 'package:test_flutter/widgets/profile_widget.dart';
import 'package:test_flutter/widgets/textfield_widget.dart';
import 'package:test_flutter/model/user.dart';
import 'package:test_flutter/route.dart' as route;

class Editprofilepage extends StatefulWidget {
  const Editprofilepage({Key? key}) : super(key: key);

  @override
  State<Editprofilepage> createState() => _Editprofilepage();
}

class _Editprofilepage extends State<Editprofilepage> {

  late FirebaseDatabase firebaseDatabase;
  late FirebaseAuth firebaseAuth;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

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
          controller: _nameController,
          onChanged: (name){}, text: '',
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Email',
          controller: _emailController,
          onChanged: (email){},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Alamat',
          controller: _alamatController,
          onChanged: (address){},
        ),
        const SizedBox(height: 24),
        ElevatedButton(
            onPressed: () {
              updateProfile(Navigator.of(context));
            },
            child: const Text("Update")
        )
      ],
    ),
  );

  void getNameData() {
    firebaseDatabase.ref("users/${firebaseAuth.currentUser!.uid}/profile").get().then((value) {
      var res = value.value as Map<dynamic, dynamic>;
      debugPrint(res.toString());
      user = UserProfile(imagePath: "https://i.pinimg.com/236x/9d/d0/8a/9dd08a06d6aed22b348e4a49791bbf3b.jpg", name: res["username"], address: res["alamat"], email: res["email"]);
      _nameController.text = user.name;
      _emailController.text = user.email;
      _alamatController.text = user.address;
    });
  }


  void updateProfile(NavigatorState nav){
    firebaseDatabase.ref("users/${firebaseAuth.currentUser!.uid}/profile").update({
      "name": _nameController.text,
      "email": _emailController.text,
      "alamat": _alamatController.text
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated")));
      nav.pushNamedAndRemoveUntil(route.profilePage, (route) => false);
    });

  }


}
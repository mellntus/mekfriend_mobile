import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/model/comment.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late FirebaseDatabase firebaseDatabase;
  late FirebaseAuth firebaseAuth;


  @override
  void initState() {
    super.initState();

    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;
    
    getNameData();
    getListComment("1657040657635");
  }

  String name = "~";
  String email = "~";
  List<Comment> listComment = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(name),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: listComment.length,
                  itemBuilder: (context, position) {
                    return _buildListLayout(listComment[position]);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  void getListComment(String postId) {
    firebaseDatabase.ref("posts/$postId/comment").get().then((value) {
      List<DataSnapshot> list = value.children.toList();
      list.forEach((element) {
        Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
        listComment.add(
          Comment(name: data["user_id"], comment: data["comment_content"], date: data["comment_date"], id: element.key.toString())
        );
      });

      setState(() {

      });
    });
  }

  void getNameData() {
    firebaseDatabase.ref("users_test/${firebaseAuth.currentUser!.uid}").get().then((value) {
      var res = value.value as Map<dynamic, dynamic>;
      name = res["name"];
      email = res["email"];
      setState(() {

      });
    });
  }

  Widget _buildListLayout(Comment comment) {
    return Column(
      children: [
        Text(
          comment.name,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
            comment.comment
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
            comment.date
        ),
      ],
    );
  }
}

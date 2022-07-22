import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/model/comment.dart';
import 'package:test_flutter/model/post.dart';
import 'package:test_flutter/pages/add_post/add_post_dialog.dart';
import 'package:test_flutter/pages/home/widgets/post_widget.dart';

import 'package:test_flutter/widgets/circle_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late FirebaseDatabase firebaseDatabase;
  late FirebaseAuth firebaseAuth;

  List<Post> listPost = [];

  String name = "~";
  String email = "~";
  List<Comment> listComment = [];

  @override
  void initState() {
    super.initState();

    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;

    generateFakePost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------------------------------- App Bar
              _buildHeader(),
              // ----------------------------------------- App Bar
              const SizedBox(height: 2,),
              // ----------------------------------------- Scrollable
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // ----------------------------------------- WDYT Section
                      _buildWDYTSection(),
                      // ----------------------------------------- WDYT Section
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: listPost.length,
                          itemBuilder: (builder, position) {
                            return PostWidget(post: listPost[position]);
                          }
                      )
                    ],
                  ),
                ),
              ),
              // ----------------------------------------- Scrollable
            ],
          ),
        ),
      ),
    );
  }

  void _onPostPressed() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (builder) => AddPostDialog()
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
                alignment: AlignmentDirectional.centerStart,
                // ----------------------------------------- Image App Bar
                child: SizedBox(
                    height: 80,
                    child: Image.asset("assets/images/logo_ui.png")
                )
              // ----------------------------------------- Image App Bar
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ----------------------------------------- Home Button
              Expanded(
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.home),
                    ),
                  )
              ),
              // ----------------------------------------- Home Button
              // ----------------------------------------- Divider
              Container(
                width: 1,
                height: 24,
                color: Colors.grey,
              ),
              // ----------------------------------------- Divider
              // ----------------------------------------- Profile Button
              Expanded(
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.person),
                    ),
                  )
              ),
              // ----------------------------------------- Profile Button
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWDYTSection() {
    return GestureDetector(
      onTap: () {
        _onPostPressed();
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(
              Icons.person,
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: Colors.grey[300]
                  ),
                  child: const Text("Want to meet that girl who work at Tokopedia whose last letter name is `a` :) "),
                )
            )
          ],
        ),
      ),
    );
  }

  void generateFakePost() {
    listPost = [
      Post(
        id: "ah13k4ijh13",
        name: ".......a",
        date: "27 Dec 2024",
        content: "Finally, we meet each other",
        likeCount: 9999,
        commentCount: 9998,
      ),
      Post(
        id: "ah13k4ijh13",
        name: ".......a",
        date: "27 Dec 2024",
        content: "Finally, we meet each other",
        likeCount: 9999,
        commentCount: 9998,
      ),
      Post(
        id: "ah13k4ijh13",
        name: ".......a",
        date: "27 Dec 2024",
        content: "Finally, we meet each other",
        likeCount: 9999,
        commentCount: 9998,
      ),
      Post(
        id: "ah13k4ijh13",
        name: ".......a",
        date: "27 Dec 2024",
        content: "Finally, we meet each other",
        likeCount: 9999,
        commentCount: 9998,
      ),
    ];
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

}

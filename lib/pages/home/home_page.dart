import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/model/comment.dart';
import 'package:test_flutter/model/like.dart';
import 'package:test_flutter/model/post.dart';
import 'package:test_flutter/pages/add_post/add_post_dialog.dart';
import 'package:test_flutter/pages/home/widgets/post_widget.dart';
import 'package:test_flutter/pages/profile/profilepage.dart';
import 'package:test_flutter/route.dart' as route;
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
  List<Like> listLike = [];

  @override
  void initState() {
    super.initState();
    List<Post> listPost = [];
    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;

    getListPost();
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
                    child: Image.asset("assets/images/MekFriend.png")
                ),
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
                  ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>Profilepage()));
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
            CircleImage(
              url: "https://avatars.githubusercontent.com/u/87801994?v=4",
              size: 35,
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

  void _onPostPressed(){
    showDialog(
        context: context,
        builder: (builder) => AddPostDialog()
    );
  }

  void getListPost() {
    firebaseDatabase.ref("posts/").get().then((postValue) {
      debugPrint(postValue.value.toString());
      postValue.children.toList().forEach((elementPost) {

        getCount(elementPost.key.toString());

        Map<dynamic, dynamic> postData = elementPost.value as Map<dynamic, dynamic>;
        var postUserId = postData["userId"];
        firebaseDatabase.ref("users/$postUserId/profile").get().then((userValue) {
          var userData = userValue.value as Map<dynamic, dynamic>;
          listPost.add(
              Post(
                  id: elementPost.key.toString(),
                  uid: postData["id"],
                  name: userData["username"],
                  date: postData["post_date"],
                  imageUrl: "https://avatars.githubusercontent.com/u/57880863?v=4",
                  content: postData["post_content"],
                  likeCount: listLike.length.toString(),
                  commentCount: listComment.length.toString()
              )
          );
          if(listPost.length == postValue.children.toList().length){
            setState(() {

            });
          }
        });
      });
    });
  }

  void getCount(String postId){
    //LIKE COUNT
    firebaseDatabase.ref("posts/$postId/like").get().then((likeValue) {
      likeValue.children.toList().forEach((elementLike) {
        Map<dynamic, dynamic> postLikeData = elementLike.value as Map<dynamic, dynamic>;
        listLike.add(
          Like(
              id: elementLike.key.toString(),
              userId: postLikeData["user_id"]
          )
        );
      });
    });

  }
}

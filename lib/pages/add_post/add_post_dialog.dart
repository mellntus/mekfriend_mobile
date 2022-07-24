import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_flutter/route.dart' as route;
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddPostDialog extends StatefulWidget {
  const AddPostDialog({Key? key}) : super(key: key);

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();

}

class _AddPostDialogState extends State<AddPostDialog> {
  late FirebaseDatabase firebaseDatabase;
  late FirebaseAuth firebaseAuth;

  var uuid = Uuid();

  final TextEditingController _inputPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            margin: const EdgeInsets.all(32),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _inputPostController,
                  decoration: InputDecoration.collapsed(
                      hintText: "Want to meet that girl who work at Tokopedia whose last letter name is `a` :) "
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      savePostToDatabase(Navigator.of(context), _inputPostController.text);
                    },
                    child: Text("Post")
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void  savePostToDatabase(NavigatorState nav, String postContent){

    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;

    var postId = uuid.v1();
    var userPostId = postId;

    var postUid = DateTime.now().millisecondsSinceEpoch.toString();
    var userPostUid = postUid;

    var currentUser = firebaseAuth.currentUser!.uid;

    if(postContent != null || postContent != "") {
      firebaseDatabase.ref("posts/$postUid").set({
        "id": postId,
        "image": "",
        "post_content": postContent,
        "post_date": DateFormat("d MMMM yyyy").format(DateTime.now()),
        "userId": currentUser,
        "like" : "0",
        "comment" : "0"
      });

      firebaseDatabase.ref("users/$currentUser/post/$userPostUid").set({
        "post_id": userPostId
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Post Created")));
        nav.pushNamedAndRemoveUntil(route.homePage, (route) => false);
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${error.toString()}")));
      });
    }
  }
}
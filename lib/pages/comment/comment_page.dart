import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_flutter/model/comment.dart';
import 'package:test_flutter/pages/comment/widgets/comment_widget.dart';
import 'package:test_flutter/widgets/circle_image.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {

  final String postId;
  const CommentPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  late FirebaseDatabase firebaseDatabase;
  late FirebaseAuth firebaseAuth;

  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Comment> listComment = [];

  void _onSendButtonPressed(String postId) {
    var commentId = DateTime.now().millisecondsSinceEpoch.toString();

    if(_commentController.text != null || _commentController.text != ""){
      firebaseDatabase.ref("posts/$postId/comment/$commentId").set({
        "user_id" : firebaseAuth.currentUser!.uid,
        "comment_content" : _commentController.text,
        "comment_date" : DateFormat("d MMMM yyyy").format(DateTime.now())
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Comment Posted")));

        _commentController.text = "";

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      });
    }
  }

  void _generateDummyComments() {
    listComment = [
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a"),
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a"),
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a"),
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a"),
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a")
    ];
  }

  @override
  void initState() {
    super.initState();
    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;

    getListComment(widget.postId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: listComment.length,
                            itemBuilder: (builder, position) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: CommentWidget(
                                    comment: listComment[position],
                                  ),
                              );
                            }
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Row(
                  children: [
                    // ----------------------------------------- Image
                    CircleImage(
                      url: "https://avatars.githubusercontent.com/u/57880863?v=4",
                      size: 35,
                    ),
                    // ----------------------------------------- Image
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(width: 1, color: Colors.grey)),
                            hintText: "Want to meet that girl who work at Tokopedia whose last letter name is `a` :) "
                        ),
                      ),
                    ),
                    IconButton(onPressed: () {
                      _onSendButtonPressed(widget.postId);
                    }, icon: const Icon(Icons.send))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getListComment(String postId) {
    firebaseDatabase.ref("posts/$postId/comment").get().then((value) {
      List<DataSnapshot> listCommentData = value.children.toList();
      listCommentData.forEach((element) {
        Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
        var postUserId = data["userId"];
        firebaseDatabase.ref("users/$postUserId/profile").get().then((userValue) {
          var userData = userValue.value as Map<dynamic, dynamic>;
          listComment.add(
            Comment(
                name: userData["username"],
                comment: data["comment_content"],
                date: data["comment_date"],
                id: element.key.toString()
            )
          );
          if(listComment.length == listCommentData.length){
            setState(() {

            });
          }
        });
      });
    });
  }
}

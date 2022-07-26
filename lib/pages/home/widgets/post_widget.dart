import 'package:flutter/material.dart';
import 'package:test_flutter/model/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_flutter/pages/comment/comment_page.dart';
import 'package:test_flutter/widgets/circle_image.dart';
import 'package:uuid/uuid.dart';
import 'package:test_flutter/route.dart' as route;

class PostWidget extends StatefulWidget {

  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {

  late FirebaseDatabase firebaseDatabase;
  late FirebaseAuth firebaseAuth;

  var uuid = Uuid();

  void _onDeletePressed(String postId, NavigatorState nav) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cant Delete this Post")));
    deletePostFromDatabase(postId, nav);
  }

  void _onLikePressed(String postId) {
    addLikeToPost(postId);
  }

  void _onCommentPressed(String postUid) {
    Navigator.push(context, MaterialPageRoute(builder: (builder) => CommentPage(postId: postUid)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ----------------------------------------- Profile
              Row(
                children: [
                  // ----------------------------------------- Image
                  CircleImage(
                    url: "https://avatars.githubusercontent.com/u/87801994?v=4",
                    size: 35,
                  ),
                  // ----------------------------------------- Image
                  const SizedBox(
                    width: 16,
                  ),
                  // ----------------------------------------- Name & Date
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                  child: Text(widget.post.name)
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                    widget.post.date,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                  // ----------------------------------------- Name & Date
                  // ----------------------------------------- Trash Button
                  IconButton(
                      onPressed: () {
                        _onDeletePressed(widget.post.id, Navigator.of(context));
                      },
                      icon: const Icon(Icons.delete, size: 20,)
                  )
                  // ----------------------------------------- Trash Button
                ],
              ),
              // ----------------------------------------- Profile
              const SizedBox(
                height: 16,
              ),
              // ----------------------------------------- Content
              Row(
                children: [
                  Flexible(
                    child: Text(
                        widget.post.content
                    ),
                  )
                ],
              ),
              // ----------------------------------------- Content,
              const SizedBox(
                height: 16,
              ),
              // ----------------------------------------- Like and comment
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 16,
                      ),
                      const SizedBox(width: 8,),
                      Text(
                        "${widget.post.likeCount} orang menyukai ini",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // ----------------------------------------- Like and comment
              const SizedBox(
                height: 16,
              ),
              // ----------------------------------------- Like and comment button
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _onLikePressed(widget.post.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.thumb_up_outlined,
                                size: 16,
                              ),
                              SizedBox(width: 8,),
                              Text(
                                "Like",
                                style: TextStyle(
                                    fontSize: 12
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _onCommentPressed(widget.post.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.comment_outlined,
                                size: 16,
                              ),
                              SizedBox(width: 8,),
                              Text(
                                "Comment",
                                style: TextStyle(
                                    fontSize: 12
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  )
                ],
              ),
              // ----------------------------------------- Like and comment button
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }

  void addLikeToPost(String postId) {
    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;

    var postLikeId = uuid.v1();

    firebaseDatabase.ref("posts/$postId/like/$postLikeId").set({
      "user_id" : firebaseAuth.currentUser!.uid
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Liked Post")));
      setState(() {

      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${error.toString()}")));

    });
  }

  void deletePostFromDatabase(String postId, NavigatorState nav){
    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;

    var currentUser = firebaseAuth.currentUser!.uid;
    var userPostData = firebaseDatabase.ref("users/$currentUser/post");
    var postData = firebaseDatabase.ref("posts/").child("$postId");

    userPostData.get().then((value) {
      value.children.toList().forEach((element) {
        if (postId == element.key.toString()){
          postData.remove();
          userPostData.child("path").remove().then((value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Post Deleted")));
            setState(() {
              nav.pushNamedAndRemoveUntil(route.homePage, (route) => false);
            });
          });
        }
        // else{
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cant Delete this Post")));
        // }
      });
    });
  }
}

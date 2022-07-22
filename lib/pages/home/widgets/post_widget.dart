import 'package:flutter/material.dart';
import 'package:test_flutter/model/post.dart';
import 'package:test_flutter/pages/comment/comment_page.dart';
import 'package:test_flutter/widgets/circle_image.dart';

class PostWidget extends StatefulWidget {

  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {

  void _onDeletePressed() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Delete Pressed")));
  }

  void _onLikePressed() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Like Pressed")));
  }

  void _onCommentPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (builder) => const CommentPage(postId: "hello ...a")));
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
                    url: "https://avatars.githubusercontent.com/u/57880863?v=4",
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
                        _onDeletePressed();
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
                        "${widget.post.likeCount} jt orang menyukai ini",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.post.commentCount} jt comments",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),
                  )
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
                          _onLikePressed();
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
                          _onCommentPressed();
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
}

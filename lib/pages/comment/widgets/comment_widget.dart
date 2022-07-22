import 'package:flutter/material.dart';
import 'package:test_flutter/model/comment.dart';
import 'package:test_flutter/widgets/circle_image.dart';

class CommentWidget extends StatefulWidget {

  final Comment comment;
  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
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
                              child: Text(widget.comment.name)
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Text(
                                widget.comment.date,
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
            ],
          ),
          // ----------------------------------------- Profile
          const SizedBox(
            height: 16,
          ),
          // ----------------------------------------- Content
          Row(
            children: [
              Flexible(child: Text(widget.comment.comment)),
            ],
          )
          // ----------------------------------------- Content
        ],
      ),
    );
  }
}

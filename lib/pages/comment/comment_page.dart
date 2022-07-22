import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  final TextEditingController _commentController = TextEditingController();

  List<Comment> listComment = [];

  void _onSendButtonPressed() {
    DateFormat dtf = DateFormat("d MMMM yyyy");
    listComment.add(
      Comment(name: "Hello", comment: _commentController.text, date: dtf.format(DateTime.now()), id: "asdasdkw4a4a")
    );
    setState(() {
    });
  }

  void _generateDummyComments() {
    listComment = [
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a"),
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a"),
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a"),
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a"),
      Comment(name: "....l", comment: "Hope we meet soon. I guess we do, on an event", date: "27 July 2022", id: "asdasdkw4a4a")
    ];
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      _generateDummyComments();
    });
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
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(width: 1, color: Colors.grey))
                        ),
                      ),
                    ),
                    IconButton(onPressed: () {
                      _onSendButtonPressed();
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
}

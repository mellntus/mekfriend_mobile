import 'package:flutter/material.dart';

class AddPostDialog extends StatefulWidget {
  const AddPostDialog({Key? key}) : super(key: key);

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
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
                TextField(

                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(

                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text("Post")
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

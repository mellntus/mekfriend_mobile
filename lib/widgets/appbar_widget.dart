import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


AppBar buildAppBar(BuildContext context){
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: BackButton(color: Colors.black),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
      )
    ],
  );
}
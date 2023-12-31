import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getx_tiktok/view/screen/add_video.dart';
import 'package:getx_tiktok/view/screen/chat_user_list_screen.dart';
import 'package:getx_tiktok/view/screen/display_screen.dart';
import 'package:getx_tiktok/view/screen/login_user_profile_screen.dart';
import 'package:getx_tiktok/view/screen/search_screen.dart';

getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];
//colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

var pageindex = [
  DisplayVideoScreen(),
  SearchScreen(),
  addVideoScreen(),
 const ChatUserListScreen(),
  LoginUserProfileScreen(id: FirebaseAuth.instance.currentUser!.uid,),
];

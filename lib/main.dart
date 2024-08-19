import 'package:ahirlog_api/model/photos_api.dart';
import 'package:ahirlog_api/screens/album_Api.dart';
import 'package:ahirlog_api/screens/comment_Api.dart';
import 'package:ahirlog_api/screens/home_page02.dart';
import 'package:ahirlog_api/screens/home_screen.dart';
import 'package:ahirlog_api/screens/photo_Api.dart';
import 'package:ahirlog_api/screens/todo_Api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Text(
            'Api Integration',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff003C43),
        ),
        body: const TodoApi(),
      ),
    );
  }
}

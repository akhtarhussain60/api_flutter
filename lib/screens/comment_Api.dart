import 'dart:convert';

import 'package:ahirlog_api/model/comment_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentApi extends StatefulWidget {
  const CommentApi({super.key});

  @override
  State<CommentApi> createState() => _CommentApiState();
}

class _CommentApiState extends State<CommentApi> {
  final List<Comments> _comments = [];

  Future<List<Comments>> getData() async {
    var responce = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        _comments.add(Comments.fromJson(index));
      }
      return _comments;
    } else {
      return _comments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.35,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xff003285),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Post Id: ${_comments[index].postId}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Id: ${_comments[index].id}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Name: ${_comments[index].name}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Email: ${_comments[index].email}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Body: ${_comments[index].body}',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

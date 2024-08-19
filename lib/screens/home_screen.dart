import 'dart:convert';

import 'package:ahirlog_api/screens/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<SamplePost>> getData() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        _samplePost.add(SamplePost.fromJson(index));
      }
      return _samplePost;
    } else {
      return _samplePost;
    }
  }

  final List<SamplePost> _samplePost = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: _samplePost.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User Id : ${_samplePost[index].userId}',
                        maxLines: 1,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Id : ${_samplePost[index].id}',
                        maxLines: 1,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Tittle : ${_samplePost[index].title}',
                        maxLines: 1,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Body:${_samplePost[index].body}',
                        maxLines: 1,
                        style: const TextStyle(fontSize: 18),
                      ),
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
        });
  }
}

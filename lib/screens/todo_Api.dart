import 'dart:convert';

import 'package:ahirlog_api/model/photos_api.dart';
import 'package:ahirlog_api/model/todos_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoApi extends StatefulWidget {
  const TodoApi({super.key});

  @override
  State<TodoApi> createState() => _TodoApiState();
}

class _TodoApiState extends State<TodoApi> {
  final List<Todos> _todolist = [];

  Future<List<Todos>> getData() async {
    var responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        _todolist.add(Todos.fromJson(index));
      }
      return _todolist;
    } else {
      return _todolist;
    }
  }

  var style = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _todolist.length,
              itemBuilder: (contect, index) {
                return Card(
                  color: Colors.green,
                  elevation: 5,
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'UserID: ${_todolist[index].userId}',
                          style: style,
                        ),
                        Text(
                          'ID: ${_todolist[index].id}',
                          style: style,
                        ),
                        Text(
                          'Title: ${_todolist[index].title}',
                          style: style,
                        ),
                        Text(
                          'Completed: ${_todolist[index].completed}',
                          style: style,
                        )
                      ],
                    ),
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

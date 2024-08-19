import 'dart:convert';

import 'package:ahirlog_api/model/albums_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlbumsApi extends StatefulWidget {
  const AlbumsApi({super.key});

  @override
  State<AlbumsApi> createState() => _AlbumsApiState();
}

class _AlbumsApiState extends State<AlbumsApi> {
  final List<Albums> _albumApi = [];

  Future<List<Albums>> getData() async {
    var responce = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        _albumApi.add(Albums.fromJson(index));
      }
      return _albumApi;
    } else {
      return _albumApi;
    }
  }

  var style = const TextStyle(fontSize: 18, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: _albumApi.length,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                margin: const EdgeInsets.all(15),
                height: 10,
                color: Colors.brown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UserId: ${_albumApi[index].userId}',
                      style: style,
                    ),
                    Text(
                      'Id: ${_albumApi[index].id}',
                      style: style,
                    ),
                    Text(
                      'Titled: ${_albumApi[index].title}',
                      style: style,
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

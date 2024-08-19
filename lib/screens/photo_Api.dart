import 'dart:convert';

import 'package:ahirlog_api/model/photos_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoApi extends StatefulWidget {
  const PhotoApi({super.key});

  @override
  State<PhotoApi> createState() => _PhotoApiState();
}

class _PhotoApiState extends State<PhotoApi> {
  final List<Photos> _photosApi = [];
  Future<List<Photos>> getData() async {
    var responce = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        _photosApi.add(Photos.fromJson(index));
      }
      return _photosApi;
    } else {
      return _photosApi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: _photosApi.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(15),
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('AlbumID: ${_photosApi[index].albumId}'),
                        Text('ID: ${_photosApi[index].id}'),
                        Text('Title: ${_photosApi[index].title}'),
                        Text('URL: ${_photosApi[index].url}'),
                        Text('ThumbnailURL: ${_photosApi[index].thumbnailUrl}')
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

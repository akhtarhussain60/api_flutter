import 'dart:convert';

import 'package:ahirlog_api/screens/model_class02.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage02 extends StatefulWidget {
  const HomePage02({super.key});

  @override
  State<HomePage02> createState() => _HomePage02State();
}

class _HomePage02State extends State<HomePage02> {
  final List<UserDetails> _userdetail = [];
  Future<List<UserDetails>> getData() async {
    var responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        _userdetail.add(UserDetails.fromJson(index));
      }
      return _userdetail;
    } else {
      return _userdetail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemCount: _userdetail.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  height: 210,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                          index,
                          'ID:',
                          _userdetail[index].id.toString(),
                        ),
                        getText(
                          index,
                          'Name:',
                          _userdetail[index].name.toString(),
                        ),
                        getText(
                          index,
                          'Email:',
                          _userdetail[index].email.toString(),
                        ),
                        getText(
                          index,
                          'Phone:',
                          _userdetail[index].phone.toString(),
                        ),
                        getText(
                          index,
                          'Website:',
                          _userdetail[index].website.toString(),
                        ),
                        getText(
                          index,
                          'Company Name:',
                          _userdetail[index].company.name.toString(),
                        ),
                        getText(
                          index,
                          'Address:',
                          '${_userdetail[index].address.suite.toString()},'
                              ' ${_userdetail[index].address.street.toString()},'
                              '${_userdetail[index].address.city.toString()},'
                              '${_userdetail[index].address.zipcode.toString()}',
                        ),
                      ]),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Text getText(int index, String fieldName, String content) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: fieldName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      TextSpan(
          text: content,
          style: const TextStyle(
            fontSize: 16,
          )),
    ]));
  }
}

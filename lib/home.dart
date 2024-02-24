import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_api_demo/Models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:user_api_demo/reusable_row.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userList.clear();
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('USER API DEMO'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getUserApi(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReusableRow(
                                title: 'Name: ',
                                value: userList[index].name.toString()),
                            ReusableRow(
                                title: 'Email: ',
                                value: userList[index].email.toString()),
                            ReusableRow(
                                title: 'Contact: ',
                                value: userList[index].phone.toString()),
                            ReusableRow(
                                title: 'Company: ',
                                value:
                                    userList[index].company!.name.toString()),
                            ReusableRow(
                                title: 'City: ',
                                value:
                                    userList[index].address!.city.toString()),
                            ReusableRow(
                                title: 'Geo: ',
                                value: userList[index]
                                    .address!
                                    .geo!
                                    .lat
                                    .toString()),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}

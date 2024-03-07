import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

late List<dynamic> productList;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      setState(() {
        productList = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Store API"),
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: Center(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productList[index]['title']),
                  subtitle: Text(productList[index]['price'].toString()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final String title;
  final double price;
  final String imageUrl;

  Product({
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> productList;
  Future<void> apicall() async {
    http.Response response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      List<dynamic> productsData = json.decode(response.body);
      List<Product> products = productsData.map((data) {
        return Product(
          title: data['title'],
          price: data['price'].toDouble(),
          imageUrl: data['image'],
        );
      }).toList();

      setState(() {
        productList = products;
      });
    } else {
      // Handle non-200 status codes
      print("Failed to fetch data. Status code: ${response.statusCode}");
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
                  title: Text(productList[index].title),
                  subtitle: Text(productList[index].price.toString()),
                  leading: Image.network(productList[index].imageUrl),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

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
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> productList;
  late bool isLoading = true;
  late String errorMessage = '';

  Future<void> apicall() async {
    try {
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
          isLoading = false;
        });
      } else {
        // Handle non-200 status codes
        setState(() {
          errorMessage =
              "Failed to fetch data. Status code: ${response.statusCode}";
          isLoading = false;
        });
        print(errorMessage);
      }
    } catch (error) {
      // Handle network errors
      setState(() {
        errorMessage = "Error: $error";
        isLoading = false;
      });
      print(errorMessage);
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
          height: 600,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: isLoading
              ? CircularProgressIndicator()
              : errorMessage.isNotEmpty
                  ? Center(
                      child: Text(errorMessage),
                    )
                  : ListView.builder(
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
    );
  }
}

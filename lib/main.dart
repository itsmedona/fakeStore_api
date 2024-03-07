import 'package:api_int_mar7/presentation/HomeScreen/view/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ApiApp());
}
class ApiApp extends StatelessWidget {
  const ApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen( ),
    );
  }
}
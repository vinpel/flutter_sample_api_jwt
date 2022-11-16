import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/di/service_locator.dart';
import 'package:flutter_sample_api_jwt/pages/loading/loading_page.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
    );
  }
}

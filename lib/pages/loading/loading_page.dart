import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/data/repository/secure_storage_repository.dart';
import 'package:flutter_sample_api_jwt/di/service_locator.dart';
import 'package:flutter_sample_api_jwt/pages/home/home_page.dart';
import 'package:flutter_sample_api_jwt/pages/login/login_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final storage = getIt<SecureStorageRepository>();
  @override
  void initState() {
    super.initState();
    storage.haveAccessToken().then((data) {
      if (data == true) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            Text("Valid token in secure_storage ?"),
          ],
        ),
      ),
    );
  }
}

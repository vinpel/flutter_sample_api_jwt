import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/data/network/dio_exception.dart';
import 'package:flutter_sample_api_jwt/data/repository/my_backend_repository.dart';
import 'package:flutter_sample_api_jwt/data/repository/secure_storage_repository.dart';
import 'package:flutter_sample_api_jwt/di/service_locator.dart';
import 'package:flutter_sample_api_jwt/pages/home/home_page.dart';
import 'package:flutter_sample_api_jwt/pages/login/login_controller.dart';

import 'package:ndialog/ndialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  LoginPageState createState() => LoginPageState();
}

final myBackendRepository = getIt.get<MyBackendRepository>();
final loginController = getIt<LoginController>();

class LoginPageState extends State<LoginPage> {
  final storage = getIt<SecureStorageRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/gopher.png')),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: loginController.emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: loginController.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final token =
                        await myBackendRepository.getTokenFromUserRequested(
                      loginController.emailController.text,
                      loginController.passwordController.text,
                    );
                    storage.storeToken(token);
                    if (!mounted) return;
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  } on DioError catch (e) {
                    final errorMessage =
                        DioExceptions.fromDioError(e).toString();
                    throw errorMessage;
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Call my_backend: "),
                TextButton(
                  child: const Text('create flutter@example.com account'),
                  onPressed: () async {
                    await myBackendRepository.addNewUserRequested(
                      'flutter@example.com',
                      'demo',
                      generateRandomString(5),
                      generateRandomString(10),
                    );
                    if (!mounted) return;
                    NDialog(
                      dialogStyle: DialogStyle(titleDivider: true),
                      title: const Text("Created"),
                      content: (const Text(
                        "username: flutter@example.com / password : demo",
                      )),
                      actions: <Widget>[
                        TextButton(
                            child: const Text("OK"),
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ).show(context,
                        transitionType: DialogTransitionType.Shrink);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/data/models/auth_token_model.dart';
import 'package:flutter_sample_api_jwt/di/service_locator.dart';
import 'package:flutter_sample_api_jwt/pages/home/home_controller.dart';
import 'package:flutter_sample_api_jwt/pages/home/widgets/add_user_btn.dart';
import 'package:flutter_sample_api_jwt/pages/home/widgets/app_bar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final homeController = getIt<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      floatingActionButton: const AddUserBtn(),
      body: FutureBuilder<AuthTokenModel>(
        future: homeController.getTokenFromStorage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text(
                "Error: $error",
              ),
            );
          } else if (snapshot.hasData) {
            final tokens = snapshot.data;
            DateTime accessExpirationDate =
                JwtDecoder.getExpirationDate(tokens!.accessToken);
            return Center(
              child: Column(
                children: [
                  Text(
                    "Access Token Exp :${accessExpirationDate.toString()}",
                  ),
                  Text(
                      "Refresh Token Exp :${JwtDecoder.getExpirationDate(tokens.refreshToken).toString()}"),
                  TextButton(
                    onPressed: () async {
                      try {
                        String pingReponse = await homeController.ping();
                        homeController.resultatController.text =
                            "${DateTime.now()} : $pingReponse";
                      } catch (e) {
                        homeController.resultatController.text = e.toString();
                      }
                    },
                    child: const Text("Ping Secure"),
                  ),
                  TextField(
                    maxLines: 20,
                    controller: homeController.resultatController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            );
          }
          return Material(
            color: Colors.white,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  Text("grab token in secure_storage"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_sample_api_jwt/data/models/auth_token_model.dart';
import 'package:flutter_sample_api_jwt/data/models/user_model.dart';

import 'package:flutter_sample_api_jwt/data/models/user_new.dart';
import 'package:flutter_sample_api_jwt/data/repository/my_backend_repository.dart';
import 'package:flutter_sample_api_jwt/data/repository/secure_storage_repository.dart';

import 'package:flutter_sample_api_jwt/di/service_locator.dart';

class HomeController {
  // --------------- Repository -------------

  final myBackendRepository = getIt.get<MyBackendRepository>();
  final storage = getIt.get<SecureStorageRepository>();

  // -------------- Textfield Controller ---------------
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final nextPasswordController = TextEditingController();
  final resultatController = TextEditingController();
  bool? disconnectOtherSession = true;

  // -------------- Local Variables ---------------

  final List<UserModel> listOfUsers = [];

  // -------------- Methods ---------------
  Future<AuthTokenModel> getTokenFromStorage() async {
    final token = await storage.getTokenFromSecure();
    return token;
  }

  Future<String> ping() async {
    final reponse = await myBackendRepository.pingRequested();
    return reponse.toJson().toString();
  }

  Future<List<UserModel>> getUsers() async {
    final users = await myBackendRepository.getUsersRequested();
    listOfUsers.clear();
    listOfUsers.addAll(users);
    return users;
  }

  Future<NewUserModel> addNewUser() async {
    final newlyAddedUser = await myBackendRepository.addNewUserRequested(
      emailController.text,
      passwordController.text,
      nameController.text,
      userNameController.text,
    );

    return newlyAddedUser;
  }

  Future<String> updateUserPassword(String userName, String oldPassword,
      String newPassword, bool disconnectOtherSessions) async {
    final updatedUser = await myBackendRepository.updateUserPasswordRequested(
      userName: userName,
      oldPassword: oldPassword,
      newPassword: newPassword,
      disconnectOtherSessions: disconnectOtherSessions,
    );

    return updatedUser.toJson().toString();
  }
}

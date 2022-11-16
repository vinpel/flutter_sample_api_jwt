import 'package:dio/dio.dart';
import 'package:flutter_sample_api_jwt/data/models/auth_token_model.dart';
import 'package:flutter_sample_api_jwt/data/models/reponse_standard_model.dart';
import 'package:flutter_sample_api_jwt/data/models/user_model.dart';

import 'package:flutter_sample_api_jwt/data/models/user_new.dart';
import 'package:flutter_sample_api_jwt/data/network/api/my_backend_api.dart';

import 'package:flutter_sample_api_jwt/data/network/dio_exception.dart';

//this class retrieve a raw response from user api and map it to UserModel
class MyBackendRepository {
  final MyBackendApi golangApi;

  MyBackendRepository(this.golangApi);

  Future<AuthTokenModel> getTokenFromUserRequested(
      String email, String password) async {
    try {
      final response = await golangApi.getTokenFromUserApi(email, password);
      final tokens = AuthTokenModel.fromJson(response.data);

      return tokens;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<AuthTokenModel> getTokenFromRefreshTokenRequested(
      String accessToken) async {
    try {
      final response = await golangApi.getTokenFromRefreshApi(
        accessToken,
      );
      final tokens = AuthTokenModel.fromJson(response.data);

      return tokens;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<UserModel>> getUsersRequested() async {
    try {
      final response = await golangApi.getUsersApi();

      final users =
          (response.data as List).map((e) => UserModel.fromJson(e)).toList();

      return users;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<NewUserModel> addNewUserRequested(
      String email, String password, String name, String username) async {
    try {
      final response =
          await golangApi.addNewUserApi(email, password, name, username);
      final user = NewUserModel.fromJson(response.data);

      return user;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ReponseStandardModel> updateUserPasswordRequested(
      {required String oldPassword,
      required String newPassword,
      required bool disconnectOtherSessions,
      required String userName}) async {
    try {
      final response = await golangApi.updateUserPasswordApi(
          userName, oldPassword, newPassword, disconnectOtherSessions);
      return ReponseStandardModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ReponseStandardModel> pingRequested() async {
    final response = await golangApi.getSecuredPingApi();
    return ReponseStandardModel.fromJson(response.data);
  }
}

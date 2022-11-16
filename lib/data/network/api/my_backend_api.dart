import 'package:dio/dio.dart';
import 'package:flutter_sample_api_jwt/data/network/api/constant/my_backend_endpoints.dart';
import 'package:flutter_sample_api_jwt/data/network/dio_client.dart';

//  this class return RAW data, not mapped to user model
class MyBackendApi {
  final DioClient dioClient;

  MyBackendApi({required this.dioClient});

  Future<Response> getTokenFromUserApi(String email, String password) async {
    try {
      final Response response = await dioClient.post(
        '${MyBackendEndpoints.token}/from-user',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getTokenFromRefreshApi(String refreshToken) async {
    try {
      final Response response = await dioClient.post(
        '${MyBackendEndpoints.token}/from-refresh',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserPasswordApi(String userName, String actualPassword,
      String newPassword, bool disconnectOtherSessions) async {
    try {
      final Response response = await dioClient.post(
        '${MyBackendEndpoints.user}/change-password',
        data: {
          'new-password': newPassword,
          'actual-password': actualPassword,
          'logout-all-sesssion': disconnectOtherSessions,
          'username': userName,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getSecuredPingApi() async {
    try {
      final Response response =
          await dioClient.get(MyBackendEndpoints.securedPing,
              options: Options(
                headers: {"requiresAccessToken": true},
              ));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getUsersApi() async {
    try {
      final Response response = await dioClient.get(MyBackendEndpoints.user,
          options: Options(
            headers: {"requiresAccessToken": true},
          ));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addNewUserApi(
      String email, String password, String name, String username) async {
    try {
      final Response response = await dioClient.post(
        '${MyBackendEndpoints.user}/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'username': username,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

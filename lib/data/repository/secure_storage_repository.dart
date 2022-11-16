import 'package:flutter_sample_api_jwt/data/models/auth_token_model.dart';
import 'package:flutter_sample_api_jwt/data/models/reponse_standard_model.dart';
import 'package:flutter_sample_api_jwt/data/repository/my_backend_repository.dart';
import 'package:flutter_sample_api_jwt/di/service_locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SecureStorageRepository {
  // --------------- Repository -------------

  final myBackendRepository = getIt.get<MyBackendRepository>();
  final storage = const FlutterSecureStorage();

  // --------------- Method
  Future<AuthTokenModel> getTokenFromSecure() async {
    if (await storage.containsKey(key: "accessToken") &&
        await storage.containsKey(key: "refreshToken")) {
      AuthTokenModel token = AuthTokenModel(
        refreshToken: await storage.read(key: "refreshToken") as String,
        accessToken: await storage.read(key: "accessToken") as String,
      );
      return token;
    }
    throw "no token in secure";
  }

  Future<bool> haveAccessToken() async {
    if (await storage.containsKey(key: "accessToken") == false ||
        await storage.containsKey(key: "refreshToken") == false) {
      return false;
    }

    AuthTokenModel tokens = AuthTokenModel(
      refreshToken: await storage.read(key: "refreshToken") as String,
      accessToken: await storage.read(key: "accessToken") as String,
    );
    if (DateTime.now()
        .isAfter(JwtDecoder.getExpirationDate(tokens.refreshToken))) {
      return false;
    }

    if (DateTime.now()
        .isAfter(JwtDecoder.getExpirationDate(tokens.accessToken))) {
      return refreshAccessToken(tokens.refreshToken);
    }
    // This check allow us to verify the usage of "logout-all-sesssion"
    // during a change of password (accessToken needed)
    ReponseStandardModel pingResult = await myBackendRepository.pingRequested();
    if (pingResult.error != null) {
      return false;
    }

    return true;
  }

  void storeToken(AuthTokenModel token) async {
    storage.write(key: "accessToken", value: token.accessToken);
    storage.write(key: "refreshToken", value: token.refreshToken);
  }

  Future<bool> refreshAccessToken(String refreshToken) async {
    try {
      AuthTokenModel token = await myBackendRepository
          .getTokenFromRefreshTokenRequested(refreshToken);

      storage.write(key: "accessToken", value: token.accessToken);
      storage.write(key: "refreshToken", value: token.refreshToken);

      return true;
    } catch (e) {
      return false;
    }
  }

  void deleteToken() {
    storage.delete(key: "accessToken");
    storage.delete(key: "refreshToken");
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_sample_api_jwt/data/network/api/my_backend_api.dart';
import 'package:flutter_sample_api_jwt/data/network/dio_client.dart';
import 'package:flutter_sample_api_jwt/data/repository/my_backend_repository.dart';
import 'package:flutter_sample_api_jwt/data/repository/secure_storage_repository.dart';

import 'package:flutter_sample_api_jwt/pages/home/home_controller.dart';
import 'package:flutter_sample_api_jwt/pages/login/login_controller.dart';
import 'package:get_it/get_it.dart';

//Dependency Injection (DI)

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(MyBackendApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(MyBackendRepository(getIt.get<MyBackendApi>()));
  getIt.registerSingleton(SecureStorageRepository());
  getIt.registerSingleton(HomeController());
  getIt.registerSingleton(LoginController());
}

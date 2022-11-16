class MyBackendEndpoints {
  MyBackendEndpoints._();

  // base url
  static const String baseUrl = "http://localhost:8000/api";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String token = '/token';
  static const String user = '/user/';
  static const String securedPing = '/secured/ping';
}

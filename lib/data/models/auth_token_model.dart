class AuthTokenModel {
  String refreshToken;
  String accessToken;

  AuthTokenModel({required this.refreshToken, required this.accessToken});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
        refreshToken: json['refresh_token'] as String,
        accessToken: json['access_token'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh_token'] = refreshToken;
    data['access_token'] = accessToken;

    return data;
  }
}

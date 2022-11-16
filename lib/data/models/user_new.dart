class NewUserModel {
  int? userId;
  String? email;
  String? username;

  NewUserModel({this.userId, this.email, this.username});

  NewUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['email'] = email;
    data['username'] = username;
    return data;
  }
}

class UserModel {
  String? name;
  String? email;
  String? password;
  String? username;

  UserModel({this.name, this.email, this.password, this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['username'] = username;
    return data;
  }
}

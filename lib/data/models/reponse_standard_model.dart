class ReponseStandardModel {
  String? message;
  String? success;
  String? error;

  ReponseStandardModel({this.message, this.success, this.error});

  ReponseStandardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['error'] = error;
    data['success'] = success;

    return data;
  }
}

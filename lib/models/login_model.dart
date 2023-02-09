class LoginModel {
  bool? status;
  String? id;
  String? username;
  String? email;

  LoginModel({this.status, this.id, this.username, this.email});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}

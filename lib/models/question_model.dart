class QModel {
  String message;
  bool status;
  String id;

  QModel({this.message, this.status, this.id});

  QModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    id = json['id'];
  }
}

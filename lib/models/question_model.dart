class QModel {
  late String message;
  late bool status;
  late String id;

  QModel({required this.message,required this.status,required this.id});

  QModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    id = json['id'];
  }
}

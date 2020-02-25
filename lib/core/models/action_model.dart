
//Class yang hanya menampung action response
class ActionModel {
  int status;
  String message;

  ActionModel({this.status, this.message});
  factory ActionModel.fromJson(Map<String, dynamic> json) {
    return ActionModel(
      status: json['status'] != null ? int.parse(json['status'].toString()) : 400,
      message: json['message'] != null ? json['message'] : "Terdapat kesalahan"
    );
  }
}
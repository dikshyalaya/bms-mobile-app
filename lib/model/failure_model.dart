class FailureModel {
  String? type;
  String? title;
  int? status;
  Errors? errors;
  String? traceId;

  FailureModel({this.type, this.title, this.status, this.errors, this.traceId});

  FailureModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    status = json['status'];
    errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    traceId = json['traceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['status'] = status;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    data['traceId'] = traceId;
    return data;
  }
}

class Errors {
  List<String>? message;

  Errors({this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    message = json['message'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}

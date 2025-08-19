import 'package:spa_project/model/response/model_order_service.dart';

class ModelDetailOrderService {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelDetailOrderService({this.data, this.code, this.messages, this.totalData});

  ModelDetailOrderService.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    data['messages'] = messages;
    data['totalData'] = totalData;
    return data;
  }
}
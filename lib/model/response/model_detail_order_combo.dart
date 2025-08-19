import 'package:spa_project/model/response/model_order_combo.dart';

class ModelDetailOrderCombo {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelDetailOrderCombo({this.data, this.code, this.messages, this.totalData});

  ModelDetailOrderCombo.fromJson(Map<String, dynamic> json) {
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
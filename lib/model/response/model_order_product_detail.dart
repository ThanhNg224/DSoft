import 'package:spa_project/model/response/model_list_order_product.dart';

class ModelOrderProductDetail {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelOrderProductDetail(
      {this.data, this.code, this.messages, this.totalData});

  ModelOrderProductDetail.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    data['messages'] = messages;
    data['totalData'] = totalData;
    return data;
  }
}

class ModelBusinessReport {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelBusinessReport({this.data, this.code, this.messages, this.totalData});

  ModelBusinessReport.fromJson(Map<String, dynamic> json) {
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

class Data {
  int? totalOrderproduct;
  int? totalOrderService;
  int? totalOrderCombo;
  int? totalbook;
  List<String>? listBooking;
  int? total;

  Data(
      {this.totalOrderproduct,
        this.totalOrderService,
        this.totalOrderCombo,
        this.totalbook,
        this.listBooking,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    totalOrderproduct = json['totalOrderproduct'];
    totalOrderService = json['totalOrderService'];
    totalOrderCombo = json['totalOrderCombo'];
    totalbook = json['totalbook'];
    listBooking = json['listBooking']?.cast<String>();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalOrderproduct'] = totalOrderproduct;
    data['totalOrderService'] = totalOrderService;
    data['totalOrderCombo'] = totalOrderCombo;
    data['totalbook'] = totalbook;
    data['listBooking'] = listBooking;
    data['total'] = total;
    return data;
  }
}

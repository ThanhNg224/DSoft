class ModelStatisticalTimeLine {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelStatisticalTimeLine({this.data, this.code, this.messages, this.totalData});

  ModelStatisticalTimeLine.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['messages'] = messages;
    data['totalData'] = totalData;
    return data;
  }
}

class Data {
  int? time;
  double? value;

  Data({this.time, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    value = (json['value'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['value'] = value;
    return data;
  }
}

class ModelLogout {
  int? code;
  String? messages;
  int? totalData;

  ModelLogout({this.code, this.messages, this.totalData});

  ModelLogout.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['messages'] = messages;
    data['totalData'] = totalData;
    return data;
  }
}

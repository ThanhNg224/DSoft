import 'package:spa_project/model/response/model_list_book_calendar.dart';

class ModelDetailBookCalendar {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelDetailBookCalendar({this.data, this.code, this.messages, this.totalData});

  ModelDetailBookCalendar.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) data['data'] = this.data!.toJson();
    data['messages'] = messages;
    data['totalData'] = totalData;
    return data;
  }
}
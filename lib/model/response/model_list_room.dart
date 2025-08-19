class ModelListRoom {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListRoom({this.data, this.code, this.messages, this.totalData});

  ModelListRoom.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  int? status;
  int? idMember;
  int? idSpa;
  int? createdAt;
  int? bed;

  Data(
      {this.id,
        this.name,
        this.status,
        this.idMember,
        this.idSpa,
        this.createdAt,
        this.bed});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    createdAt = json['created_at'];
    bed = json['bed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['created_at'] = createdAt;
    data['bed'] = bed;
    return data;
  }
}

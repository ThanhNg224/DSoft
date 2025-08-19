class ModelListRepo {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListRepo({this.data, this.code, this.messages, this.totalData});

  ModelListRepo.fromJson(Map<String, dynamic> json) {
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
  dynamic description;
  int? credit;
  int? idMember;
  int? idSpa;
  int? createdAt;

  Data(
      {this.id,
        this.name,
        this.description,
        this.credit,
        this.idMember,
        this.idSpa,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    credit = json['credit'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['credit'] = credit;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['created_at'] = createdAt;
    return data;
  }
}

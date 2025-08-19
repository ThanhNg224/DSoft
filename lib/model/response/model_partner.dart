class ModelListPartner {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListPartner({this.data, this.code, this.messages, this.totalData});

  ModelListPartner.fromJson(Map<String, dynamic> json) {
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
  String? phone;
  String? email;
  String? address;
  dynamic note;
  int? idMember;
  int? createdAt;
  int? updatedAt;

  Data(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.address,
        this.note,
        this.idMember,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    note = json['note'];
    idMember = json['id_member'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['note'] = note;
    data['id_member'] = idMember;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ModelCreateEditCustomer {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelCreateEditCustomer(
      {this.data, this.code, this.messages, this.totalData});

  ModelCreateEditCustomer.fromJson(Map<String, dynamic> json) {
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
  int? createdAt;
  int? point;
  String? name;
  int? idMember;
  int? idSpa;
  String? phone;
  int? sex;
  String? email;
  String? address;
  dynamic source;
  dynamic idGroup;
  int? updatedAt;
  String? avatar;
  int? idStaff;
  String? note;
  int? id;

  Data(
      {this.createdAt,
        this.point,
        this.name,
        this.idMember,
        this.idSpa,
        this.phone,
        this.sex,
        this.email,
        this.address,
        this.source,
        this.idGroup,
        this.updatedAt,
        this.avatar,
        this.idStaff,
        this.note,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    point = json['point'];
    name = json['name'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    phone = json['phone'];
    sex = json['sex'];
    email = json['email'];
    address = json['address'];
    source = json['source'];
    idGroup = json['id_group'];
    updatedAt = json['updated_at'];
    avatar = json['avatar'];
    idStaff = json['id_staff'];
    note = json['note'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['point'] = point;
    data['name'] = name;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['phone'] = phone;
    data['sex'] = sex;
    data['email'] = email;
    data['address'] = address;
    data['source'] = source;
    data['id_group'] = idGroup;
    data['updated_at'] = updatedAt;
    data['avatar'] = avatar;
    data['id_staff'] = idStaff;
    data['note'] = note;
    data['id'] = id;
    return data;
  }
}

class ModelCreateMember {
  dynamic data;
  int? code;
  String? messages;
  int? totalData;

  ModelCreateMember(
      {this.data, this.code, this.messages, this.totalData});

  ModelCreateMember.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? avatar;
  String? phone;
  String? email;
  String? password;
  int? status;
  int? type;
  int? idMember;
  int? createdAt;
  int? updatedAt;
  int? lastLogin;
  int? datelineAt;
  int? numberSpa;
  String? address;
  int? codeOtp;
  String? module;
  int? id;

  Data(
      {this.name,
        this.avatar,
        this.phone,
        this.email,
        this.password,
        this.status,
        this.type,
        this.idMember,
        this.createdAt,
        this.updatedAt,
        this.lastLogin,
        this.datelineAt,
        this.numberSpa,
        this.address,
        this.codeOtp,
        this.module,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    type = json['type'];
    idMember = json['id_member'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastLogin = json['last_login'];
    datelineAt = json['dateline_at'];
    numberSpa = json['number_spa'];
    address = json['address'];
    codeOtp = json['code_otp'];
    module = json['module'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    data['type'] = type;
    data['id_member'] = idMember;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_login'] = lastLogin;
    data['dateline_at'] = datelineAt;
    data['number_spa'] = numberSpa;
    data['address'] = address;
    data['code_otp'] = codeOtp;
    data['module'] = module;
    data['id'] = id;
    return data;
  }
}


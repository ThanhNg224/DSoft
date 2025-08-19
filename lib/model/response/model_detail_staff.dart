

class ModelDetailStaff {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelDetailStaff({this.data, this.code, this.messages, this.totalData});

  ModelDetailStaff.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? avatar;
  String? phone;
  dynamic idCard;
  String? email;
  int? status;
  int? type;
  int? idMember;
  int? numberSpa;
  String? birthday;
  String? address;
  String? codeOtp;
  int? idGroup;
  String? password;
  int? coin;
  List<String>? permission;
  List<String>? module;
  dynamic accessTokenZalo;
  dynamic idAppZalo;
  dynamic secretAppZalo;
  dynamic idOaZalo;
  dynamic refreshTokenZaloOa;
  dynamic codeZaloOa;
  dynamic deadlineTokenZaloOa;
  dynamic accessTokenZaloOa;
  int? updatedAt;
  int? createdAt;
  int? lastLogin;
  int? datelineAt;
  int? idSpa;
  int? fixedSalary;
  int? allowance;
  int? insurance;
  String? accountBank;
  String? codeBank;

  Data(
      {this.id,
        this.name,
        this.avatar,
        this.phone,
        this.idCard,
        this.email,
        this.status,
        this.type,
        this.idMember,
        this.numberSpa,
        this.birthday,
        this.address,
        this.codeOtp,
        this.idGroup,
        this.password,
        this.coin,
        this.permission,
        this.module,
        this.accessTokenZalo,
        this.idAppZalo,
        this.secretAppZalo,
        this.idOaZalo,
        this.refreshTokenZaloOa,
        this.codeZaloOa,
        this.deadlineTokenZaloOa,
        this.accessTokenZaloOa,
        this.updatedAt,
        this.createdAt,
        this.lastLogin,
        this.datelineAt,
        this.idSpa,
        this.fixedSalary,
        this.allowance,
        this.insurance,
        this.accountBank,
        this.codeBank});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    phone = json['phone'];
    idCard = json['id_card'];
    email = json['email'];
    status = json['status'];
    type = json['type'];
    idMember = json['id_member'];
    numberSpa = json['number_spa'];
    birthday = json['birthday'];
    address = json['address'];
    codeOtp = json['code_otp'];
    idGroup = json['id_group'];
    password = json['password'];
    coin = json['coin'];
    permission = json['permission']?.cast<String>();
    module = json['module']?.cast<String>();
    accessTokenZalo = json['access_token_zalo'];
    idAppZalo = json['id_app_zalo'];
    secretAppZalo = json['secret_app_zalo'];
    idOaZalo = json['id_oa_zalo'];
    refreshTokenZaloOa = json['refresh_token_zalo_oa'];
    codeZaloOa = json['code_zalo_oa'];
    deadlineTokenZaloOa = json['deadline_token_zalo_oa'];
    accessTokenZaloOa = json['access_token_zalo_oa'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    lastLogin = json['last_login'];
    datelineAt = json['dateline_at'];
    idSpa = json['id_spa'];
    fixedSalary = json['fixed_salary'];
    allowance = json['allowance'];
    insurance = json['insurance'];
    accountBank = json['account_bank'];
    codeBank = json['code_bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    data['phone'] = phone;
    data['id_card'] = idCard;
    data['email'] = email;
    data['status'] = status;
    data['type'] = type;
    data['id_member'] = idMember;
    data['number_spa'] = numberSpa;
    data['birthday'] = birthday;
    data['address'] = address;
    data['code_otp'] = codeOtp;
    data['id_group'] = idGroup;
    data['password'] = password;
    data['coin'] = coin;
    data['permission'] = permission;
    data['module'] = module;
    data['access_token_zalo'] = accessTokenZalo;
    data['id_app_zalo'] = idAppZalo;
    data['secret_app_zalo'] = secretAppZalo;
    data['id_oa_zalo'] = idOaZalo;
    data['refresh_token_zalo_oa'] = refreshTokenZaloOa;
    data['code_zalo_oa'] = codeZaloOa;
    data['deadline_token_zalo_oa'] = deadlineTokenZaloOa;
    data['access_token_zalo_oa'] = accessTokenZaloOa;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['last_login'] = lastLogin;
    data['dateline_at'] = datelineAt;
    data['id_spa'] = idSpa;
    data['fixed_salary'] = fixedSalary;
    data['allowance'] = allowance;
    data['insurance'] = insurance;
    data['account_bank'] = accountBank;
    data['code_bank'] = codeBank;
    return data;
  }
}


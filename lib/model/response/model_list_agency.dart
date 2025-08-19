class ModelListAgency {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListAgency({this.data, this.code, this.messages, this.totalData});

  ModelListAgency.fromJson(Map<String, dynamic> json) {
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
  int? idMember;
  int? idSpa;
  int? idStaff;
  int? idService;
  int? money;
  String? note;
  int? idOrderDetail;
  int? status;
  int? idOrder;
  String? type;
  int? idUserService;
  int? createdAt;
  Staff? staff;
  String? service;
  Order? order;

  Data(
      {this.id,
        this.idMember,
        this.idSpa,
        this.idStaff,
        this.idService,
        this.money,
        this.note,
        this.idOrderDetail,
        this.status,
        this.idOrder,
        this.type,
        this.idUserService,
        this.createdAt,
        this.staff,
        this.service,
        this.order});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    idStaff = json['id_staff'];
    idService = json['id_service'];
    money = json['money'];
    note = json['note'];
    idOrderDetail = json['id_order_detail'];
    status = json['status'];
    idOrder = json['id_order'];
    type = json['type'];
    idUserService = json['id_user_service'];
    createdAt = json['created_at'];
    staff = json['staff'] != null ? Staff.fromJson(json['staff']) : null;
    service = json['service'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['id_staff'] = idStaff;
    data['id_service'] = idService;
    data['money'] = money;
    data['note'] = note;
    data['id_order_detail'] = idOrderDetail;
    data['status'] = status;
    data['id_order'] = idOrder;
    data['type'] = type;
    data['id_user_service'] = idUserService;
    data['created_at'] = createdAt;
    if (staff != null) {
      data['staff'] = staff!.toJson();
    }
    data['service'] = service;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Staff {
  int? id;
  String? name;
  String? avatar;
  String? phone;
  String? idCard;
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
  String? permission;
  String? module;
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
  dynamic lastLogin;
  int? datelineAt;
  int? idSpa;
  int? fixedSalary;
  int? allowance;
  int? insurance;
  String? accountBank;
  String? codeBank;

  Staff(
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

  Staff.fromJson(Map<String, dynamic> json) {
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
    permission = json['permission'];
    module = json['module'];
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

class Order {
  int? id;
  int? idMember;
  int? idSpa;
  int? idStaff;
  int? idCustomer;
  String? fullName;
  dynamic idBed;
  String? note;
  int? time;
  int? status;
  int? total;
  dynamic promotion;
  int? totalPay;
  int? typeOrder;
  dynamic checkIn;
  dynamic checkOut;
  dynamic idWarehouse;
  String? type;
  int? createdAt;
  int? updatedAt;
  Customer? customer;

  Order(
      {this.id,
        this.idMember,
        this.idSpa,
        this.idStaff,
        this.idCustomer,
        this.fullName,
        this.idBed,
        this.note,
        this.time,
        this.status,
        this.total,
        this.promotion,
        this.totalPay,
        this.typeOrder,
        this.checkIn,
        this.checkOut,
        this.idWarehouse,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.customer});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    idStaff = json['id_staff'];
    idCustomer = json['id_customer'];
    fullName = json['full_name'];
    idBed = json['id_bed'];
    note = json['note'];
    time = json['time'];
    status = json['status'];
    total = json['total'];
    promotion = json['promotion'];
    totalPay = json['total_pay'];
    typeOrder = json['type_order'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    idWarehouse = json['id_warehouse'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['id_staff'] = idStaff;
    data['id_customer'] = idCustomer;
    data['full_name'] = fullName;
    data['id_bed'] = idBed;
    data['note'] = note;
    data['time'] = time;
    data['status'] = status;
    data['total'] = total;
    data['promotion'] = promotion;
    data['total_pay'] = totalPay;
    data['type_order'] = typeOrder;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['id_warehouse'] = idWarehouse;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  int? idMember;
  int? idSpa;
  String? phone;
  String? email;
  String? address;
  int? sex;
  String? avatar;
  String? birthday;
  String? cmnd;
  String? linkFacebook;
  dynamic referralCode;
  int? idStaff;
  int? source;
  int? idGroup;
  int? idService;
  String? medicalHistory;
  String? drugAllergyHistory;
  String? requestCurrent;
  String? advisory;
  String? adviseTowards;
  String? note;
  String? job;
  int? idProduct;
  int? point;
  int? idCustomerAff;
  dynamic idTelegram;
  int? createdAt;
  int? updatedAt;

  Customer(
      {this.id,
        this.name,
        this.idMember,
        this.idSpa,
        this.phone,
        this.email,
        this.address,
        this.sex,
        this.avatar,
        this.birthday,
        this.cmnd,
        this.linkFacebook,
        this.referralCode,
        this.idStaff,
        this.source,
        this.idGroup,
        this.idService,
        this.medicalHistory,
        this.drugAllergyHistory,
        this.requestCurrent,
        this.advisory,
        this.adviseTowards,
        this.note,
        this.job,
        this.idProduct,
        this.point,
        this.idCustomerAff,
        this.idTelegram,
        this.createdAt,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    sex = json['sex'];
    avatar = json['avatar'];
    birthday = json['birthday'];
    cmnd = json['cmnd'];
    linkFacebook = json['link_facebook'];
    referralCode = json['referral_code'];
    idStaff = json['id_staff'];
    source = json['source'];
    idGroup = json['id_group'];
    idService = json['id_service'];
    medicalHistory = json['medical_history'];
    drugAllergyHistory = json['drug_allergy_history'];
    requestCurrent = json['request_current'];
    advisory = json['advisory'];
    adviseTowards = json['advise_towards'];
    note = json['note'];
    job = json['job'];
    idProduct = json['id_product'];
    point = json['point'];
    idCustomerAff = json['id_customer_aff'];
    idTelegram = json['idTelegram'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['sex'] = sex;
    data['avatar'] = avatar;
    data['birthday'] = birthday;
    data['cmnd'] = cmnd;
    data['link_facebook'] = linkFacebook;
    data['referral_code'] = referralCode;
    data['id_staff'] = idStaff;
    data['source'] = source;
    data['id_group'] = idGroup;
    data['id_service'] = idService;
    data['medical_history'] = medicalHistory;
    data['drug_allergy_history'] = drugAllergyHistory;
    data['request_current'] = requestCurrent;
    data['advisory'] = advisory;
    data['advise_towards'] = adviseTowards;
    data['note'] = note;
    data['job'] = job;
    data['id_product'] = idProduct;
    data['point'] = point;
    data['id_customer_aff'] = idCustomerAff;
    data['idTelegram'] = idTelegram;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

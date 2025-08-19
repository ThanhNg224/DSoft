class ModelActiveBed {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelActiveBed({this.data, this.code, this.messages, this.totalData});

  ModelActiveBed.fromJson(Map<String, dynamic> json) {
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
  int? status;
  int? idMember;
  int? idSpa;
  int? idRoom;
  int? createdAt;
  int? idStaff;
  int? idOrder;
  int? idCustomer;
  String? idUserservice;
  int? timeCheckin;
  List<Userservice>? userservice;
  Customer? customer;
  String? fullName;
  Order? order;
  Staff? staff;

  Data(
      {this.id,
        this.name,
        this.status,
        this.idMember,
        this.idSpa,
        this.idRoom,
        this.createdAt,
        this.idStaff,
        this.idOrder,
        this.idCustomer,
        this.idUserservice,
        this.timeCheckin,
        this.userservice,
        this.customer,
        this.fullName,
        this.order,
        this.staff});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    idRoom = json['id_room'];
    createdAt = json['created_at'];
    idStaff = json['id_staff'];
    idOrder = json['id_order'];
    idCustomer = json['id_customer'];
    idUserservice = json['id_userservice'];
    timeCheckin = json['time_checkin'];
    if (json['userservice'] != null) {
      userservice = <Userservice>[];
      json['userservice'].forEach((v) {
        userservice!.add(Userservice.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    fullName = json['full_name'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    staff = json['staff'] != null ? Staff.fromJson(json['staff']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['id_room'] = idRoom;
    data['created_at'] = createdAt;
    data['id_staff'] = idStaff;
    data['id_order'] = idOrder;
    data['id_customer'] = idCustomer;
    data['id_userservice'] = idUserservice;
    data['time_checkin'] = timeCheckin;
    if (userservice != null) {
      data['userservice'] = userservice!.map((v) => v.toJson()).toList();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['full_name'] = fullName;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (staff != null) {
      data['staff'] = staff!.toJson();
    }
    return data;
  }
}

class Userservice {
  int? id;
  int? idMember;
  int? idOrderDetails;
  int? idOrder;
  int? idSpa;
  int? idServices;
  int? idStaff;
  int? createdAt;
  String? note;
  int? idBed;
  int? idCustomer;
  int? status;
  dynamic checkOut;
  OrderDetail? orderDetail;
  Service? service;

  Userservice(
      {this.id,
        this.idMember,
        this.idOrderDetails,
        this.idOrder,
        this.idSpa,
        this.idServices,
        this.idStaff,
        this.createdAt,
        this.note,
        this.idBed,
        this.idCustomer,
        this.status,
        this.checkOut,
        this.orderDetail,
        this.service});

  Userservice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMember = json['id_member'];
    idOrderDetails = json['id_order_details'];
    idOrder = json['id_order'];
    idSpa = json['id_spa'];
    idServices = json['id_services'];
    idStaff = json['id_staff'];
    createdAt = json['created_at'];
    note = json['note'];
    idBed = json['id_bed'];
    idCustomer = json['id_customer'];
    status = json['status'];
    checkOut = json['check_out'];
    orderDetail = json['orderDetail'] != null
        ? OrderDetail.fromJson(json['orderDetail'])
        : null;
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_member'] = idMember;
    data['id_order_details'] = idOrderDetails;
    data['id_order'] = idOrder;
    data['id_spa'] = idSpa;
    data['id_services'] = idServices;
    data['id_staff'] = idStaff;
    data['created_at'] = createdAt;
    data['note'] = note;
    data['id_bed'] = idBed;
    data['id_customer'] = idCustomer;
    data['status'] = status;
    data['check_out'] = checkOut;
    if (orderDetail != null) {
      data['orderDetail'] = orderDetail!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class OrderDetail {
  int? id;
  int? idMember;
  int? idOrder;
  int? idProduct;
  String? type;
  int? price;
  int? quantity;
  int? numberUses;

  OrderDetail(
      {this.id,
        this.idMember,
        this.idOrder,
        this.idProduct,
        this.type,
        this.price,
        this.quantity,
        this.numberUses});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMember = json['id_member'];
    idOrder = json['id_order'];
    idProduct = json['id_product'];
    type = json['type'];
    price = json['price'];
    quantity = json['quantity'];
    numberUses = json['number_uses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_member'] = idMember;
    data['id_order'] = idOrder;
    data['id_product'] = idProduct;
    data['type'] = type;
    data['price'] = price;
    data['quantity'] = quantity;
    data['number_uses'] = numberUses;
    return data;
  }
}

class Service {
  int? id;
  String? name;
  String? code;
  int? idCategory;
  int? idMember;
  int? idSpa;
  int? price;
  String? image;
  String? description;
  int? duration;
  String? slug;
  int? status;
  int? commissionStaffFix;
  int? commissionStaffPercent;
  int? commissionAffiliateFix;
  int? commissionAffiliatePercent;
  dynamic updatedAt;
  dynamic createdAt;

  Service(
      {this.id,
        this.name,
        this.code,
        this.idCategory,
        this.idMember,
        this.idSpa,
        this.price,
        this.image,
        this.description,
        this.duration,
        this.slug,
        this.status,
        this.commissionStaffFix,
        this.commissionStaffPercent,
        this.commissionAffiliateFix,
        this.commissionAffiliatePercent,
        this.updatedAt,
        this.createdAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    idCategory = json['id_category'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    duration = json['duration'];
    slug = json['slug'];
    status = json['status'];
    commissionStaffFix = json['commission_staff_fix'];
    commissionStaffPercent = json['commission_staff_percent'];
    commissionAffiliateFix = json['commission_affiliate_fix'];
    commissionAffiliatePercent = json['commission_affiliate_percent'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['id_category'] = idCategory;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['price'] = price;
    data['image'] = image;
    data['description'] = description;
    data['duration'] = duration;
    data['slug'] = slug;
    data['status'] = status;
    data['commission_staff_fix'] = commissionStaffFix;
    data['commission_staff_percent'] = commissionStaffPercent;
    data['commission_affiliate_fix'] = commissionAffiliateFix;
    data['commission_affiliate_percent'] = commissionAffiliatePercent;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
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

class Order {
  int? id;
  int? idMember;
  int? idSpa;
  int? idStaff;
  int? idCustomer;
  String? fullName;
  int? idBed;
  dynamic note;
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
        this.updatedAt});

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
    return data;
  }
}

class Staff {
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
  int? lastLogin;
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

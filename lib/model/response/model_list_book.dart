class ModelListBook {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListBook({this.data, this.code, this.messages, this.totalData});

  ModelListBook.fromJson(Map<String, dynamic> json) {
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
  int? idMember;
  int? idCustomer;
  int? idService;
  int? timeBook;
  int? idStaff;
  int? status;
  String? note;
  int? aptStep;
  int? aptTimes;
  int? idSpa;
  int? type1;
  int? type2;
  int? type3;
  int? type4;
  bool? repeatBook;
  int? timeBookEnd;
  int? idBed;
  int? createdAt;
  dynamic tempInt;
  Service? service;
  String? avatar;

  Data(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.idMember,
        this.idCustomer,
        this.idService,
        this.timeBook,
        this.idStaff,
        this.status,
        this.note,
        this.aptStep,
        this.aptTimes,
        this.idSpa,
        this.type1,
        this.type2,
        this.type3,
        this.type4,
        this.repeatBook,
        this.timeBookEnd,
        this.idBed,
        this.createdAt,
        this.tempInt,
        this.avatar,
        this.service});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    idMember = json['id_member'];
    idCustomer = json['id_customer'];
    idService = json['id_service'];
    timeBook = json['time_book'];
    idStaff = json['id_staff'];
    status = json['status'];
    note = json['note'];
    aptStep = json['apt_step'];
    aptTimes = json['apt_times'];
    idSpa = json['id_spa'];
    type1 = json['type1'];
    type2 = json['type2'];
    type3 = json['type3'];
    type4 = json['type4'];
    repeatBook = json['repeat_book'];
    timeBookEnd = json['time_book_end'];
    idBed = json['id_bed'];
    createdAt = json['created_at'];
    tempInt = json['temp_int'];
    avatar = json['avatar'];
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['id_member'] = idMember;
    data['id_customer'] = idCustomer;
    data['id_service'] = idService;
    data['time_book'] = timeBook;
    data['id_staff'] = idStaff;
    data['status'] = status;
    data['note'] = note;
    data['apt_step'] = aptStep;
    data['apt_times'] = aptTimes;
    data['id_spa'] = idSpa;
    data['type1'] = type1;
    data['type2'] = type2;
    data['type3'] = type3;
    data['type4'] = type4;
    data['avatar'] = avatar;
    data['repeat_book'] = repeatBook;
    data['time_book_end'] = timeBookEnd;
    data['id_bed'] = idBed;
    data['created_at'] = createdAt;
    data['temp_int'] = tempInt;
    if (service != null) {
      data['service'] = service!.toJson();
    }
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

class InfoCustomer {
  int? id;
  String? name;
  int? idMember;
  int? idSpa;
  String? phone;
  dynamic email;
  String? address;
  int? sex;
  String? avatar;
  dynamic birthday;
  dynamic cmnd;
  dynamic linkFacebook;
  dynamic referralCode;
  int? idStaff;
  int? source;
  dynamic idGroup;
  dynamic idService;
  dynamic medicalHistory;
  dynamic drugAllergyHistory;
  dynamic requestCurrent;
  dynamic advisory;
  dynamic adviseTowards;
  String? note;
  dynamic job;
  dynamic idProduct;
  int? point;
  int? idCustomerAff;
  dynamic idTelegram;
  int? createdAt;
  int? updatedAt;

  InfoCustomer(
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

  InfoCustomer.fromJson(Map<String, dynamic> json) {
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


class ModelDetailCustomer {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelDetailCustomer({this.data, this.code, this.messages, this.totalData});

  ModelDetailCustomer.fromJson(Map<String, dynamic> json) {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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

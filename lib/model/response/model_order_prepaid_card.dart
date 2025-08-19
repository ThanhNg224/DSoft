class ModelOrderPrepaidCard {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelOrderPrepaidCard({this.data, this.code, this.messages, this.totalData});

  ModelOrderPrepaidCard.fromJson(Map<String, dynamic> json) {
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
  int? idCustomer;
  int? idMember;
  int? idSpa;
  int? total;
  String? status;
  int? idPrepaycard;
  int? idBill;
  int? priceSell;
  int? price;
  int? quantity;
  int? createdAt;
  int? updatedAt;
  dynamic tempInt;
  InfoPrepayCard? infoPrepayCard;
  InfoCustomer? infoCustomer;

  Data(
      {this.id,
        this.idCustomer,
        this.idMember,
        this.idSpa,
        this.total,
        this.status,
        this.idPrepaycard,
        this.idBill,
        this.priceSell,
        this.price,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.tempInt,
        this.infoPrepayCard,
        this.infoCustomer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCustomer = json['id_customer'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    total = json['total'];
    status = json['status'];
    idPrepaycard = json['id_prepaycard'];
    idBill = json['id_bill'];
    priceSell = json['price_sell'];
    price = json['price'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tempInt = json['temp_int'];
    infoPrepayCard = json['infoPrepayCard'] != null
        ? InfoPrepayCard.fromJson(json['infoPrepayCard'])
        : null;
    infoCustomer = json['infoCustomer'] != null
        ? InfoCustomer.fromJson(json['infoCustomer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_customer'] = idCustomer;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['total'] = total;
    data['status'] = status;
    data['id_prepaycard'] = idPrepaycard;
    data['id_bill'] = idBill;
    data['price_sell'] = priceSell;
    data['price'] = price;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['temp_int'] = tempInt;
    if (infoPrepayCard != null) {
      data['infoPrepayCard'] = infoPrepayCard!.toJson();
    }
    if (infoCustomer != null) {
      data['infoCustomer'] = infoCustomer!.toJson();
    }
    return data;
  }
}

class InfoPrepayCard {
  int? id;
  String? name;
  int? price;
  int? priceSell;
  String? note;
  int? useTime;
  int? idMember;
  int? idSpa;
  String? status;
  int? commissionStaffFix;
  int? commissionStaffPercent;

  InfoPrepayCard(
      {this.id,
        this.name,
        this.price,
        this.priceSell,
        this.note,
        this.useTime,
        this.idMember,
        this.idSpa,
        this.status,
        this.commissionStaffFix,
        this.commissionStaffPercent});

  InfoPrepayCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    priceSell = json['price_sell'];
    note = json['note'];
    useTime = json['use_time'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    status = json['status'];
    commissionStaffFix = json['commission_staff_fix'];
    commissionStaffPercent = json['commission_staff_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['price_sell'] = priceSell;
    data['note'] = note;
    data['use_time'] = useTime;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['status'] = status;
    data['commission_staff_fix'] = commissionStaffFix;
    data['commission_staff_percent'] = commissionStaffPercent;
    return data;
  }
}

class InfoCustomer {
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

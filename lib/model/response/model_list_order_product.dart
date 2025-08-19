class ModelListOrderProduct {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListOrderProduct({this.data, this.code, this.messages, this.totalData});

  ModelListOrderProduct.fromJson(Map<String, dynamic> json) {
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
  int? idCustomer;
  String? fullName;
  int? idBed;
  String? note;
  int? time;
  int? status;
  int? total;
  int? promotion;
  int? totalPay;
  int? typeOrder;
  dynamic checkIn;
  dynamic checkOut;
  dynamic idWarehouse;
  String? type;
  int? createdAt;
  int? updatedAt;
  List<OrderDetail>? orderDetail;
  Customer? customer;

  Data(
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
        this.orderDetail,
        this.customer});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (json['OrderDetail'] != null) {
      orderDetail = <OrderDetail>[];
      json['OrderDetail'].forEach((v) {
        orderDetail!.add(OrderDetail.fromJson(v));
      });
    }
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
    if (orderDetail != null) {
      data['OrderDetail'] = orderDetail!.map((v) => v.toJson()).toList();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
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
  Product? product;

  OrderDetail(
      {this.id,
        this.idMember,
        this.idOrder,
        this.idProduct,
        this.type,
        this.price,
        this.quantity,
        this.numberUses,
        this.product});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMember = json['id_member'];
    idOrder = json['id_order'];
    idProduct = json['id_product'];
    type = json['type'];
    price = json['price'];
    quantity = json['quantity'];
    numberUses = json['number_uses'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
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
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? idCategory;
  String? description;
  dynamic info;
  String? image;
  String? code;
  int? price;
  int? quantity;
  int? idTrademark;
  String? status;
  String? slug;
  dynamic view;
  int? idMember;
  int? idSpa;
  int? commissionStaffFix;
  int? commissionStaffPercent;
  int? commissionAffiliateFix;
  int? commissionAffiliatePercent;
  int? updatedAt;
  int? createdAt;

  Product(
      {this.id,
        this.name,
        this.idCategory,
        this.description,
        this.info,
        this.image,
        this.code,
        this.price,
        this.quantity,
        this.idTrademark,
        this.status,
        this.slug,
        this.view,
        this.idMember,
        this.idSpa,
        this.commissionStaffFix,
        this.commissionStaffPercent,
        this.commissionAffiliateFix,
        this.commissionAffiliatePercent,
        this.updatedAt,
        this.createdAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idCategory = json['id_category'];
    description = json['description'];
    info = json['info'];
    image = json['image'];
    code = json['code'];
    price = json['price'];
    quantity = json['quantity'];
    idTrademark = json['id_trademark'];
    status = json['status'];
    slug = json['slug'];
    view = json['view'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
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
    data['id_category'] = idCategory;
    data['description'] = description;
    data['info'] = info;
    data['image'] = image;
    data['code'] = code;
    data['price'] = price;
    data['quantity'] = quantity;
    data['id_trademark'] = idTrademark;
    data['status'] = status;
    data['slug'] = slug;
    data['view'] = view;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
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

class ModelListCombo {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListCombo({this.data, this.code, this.messages, this.totalData});

  ModelListCombo.fromJson(Map<String, dynamic> json) {
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
  String? service;
  String? product;
  int? price;
  String? description;
  String? status;
  int? quantity;
  int? idMember;
  int? idSpa;
  int? commissionStaffFix;
  int? commissionStaffPercent;
  int? useTime;
  String? image;
  int? updatedAt;
  int? createdAt;
  List<ListProduct>? listProduct;
  List<ListService>? listService;

  Data(
      {this.id,
        this.name,
        this.service,
        this.product,
        this.price,
        this.description,
        this.status,
        this.quantity,
        this.idMember,
        this.idSpa,
        this.commissionStaffFix,
        this.commissionStaffPercent,
        this.useTime,
        this.image,
        this.updatedAt,
        this.createdAt,
        this.listProduct,
        this.listService});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    service = json['service'];
    product = json['product'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    quantity = json['quantity'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    commissionStaffFix = json['commission_staff_fix'];
    commissionStaffPercent = json['commission_staff_percent'];
    useTime = json['use_time'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    if (json['list_product'] != null) {
      listProduct = <ListProduct>[];
      json['list_product'].forEach((v) {
        listProduct!.add(ListProduct.fromJson(v));
      });
    }
    if (json['list_service'] != null) {
      listService = <ListService>[];
      json['list_service'].forEach((v) {
        listService!.add(ListService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['service'] = service;
    data['product'] = product;
    data['price'] = price;
    data['description'] = description;
    data['status'] = status;
    data['quantity'] = quantity;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['commission_staff_fix'] = commissionStaffFix;
    data['commission_staff_percent'] = commissionStaffPercent;
    data['use_time'] = useTime;
    data['image'] = image;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    if (listProduct != null) {
      data['list_product'] = listProduct!.map((v) => v.toJson()).toList();
    }
    if (listService != null) {
      data['list_service'] = listService!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListProduct {
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
  int? quantityCombo;

  ListProduct(
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
        this.createdAt,
        this.quantityCombo});

  ListProduct.fromJson(Map<String, dynamic> json) {
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
    quantityCombo = json['quantity_combo'];
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
    data['quantity_combo'] = quantityCombo;
    return data;
  }
}

class ListService {
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
  int? quantityCombo;

  ListService(
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
        this.createdAt,
        this.quantityCombo});

  ListService.fromJson(Map<String, dynamic> json) {
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
    quantityCombo = json['quantity_combo'];
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
    data['quantity_combo'] = quantityCombo;
    return data;
  }
}

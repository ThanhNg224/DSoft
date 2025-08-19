class ModelListProduct {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListProduct({this.data, this.code, this.messages, this.totalData});

  ModelListProduct.fromJson(Map<String, dynamic> json) {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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

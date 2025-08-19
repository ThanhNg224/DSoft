class ModelListService {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListService({this.data, this.code, this.messages, this.totalData});

  ModelListService.fromJson(Map<String, dynamic> json) {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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

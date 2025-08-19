class ReqCreateProduct {
  int? id;
  String? name;
  int? idCategory;
  String? description;
  int? price;
  String? status;
  String? image;
  int? duration;
  int? commissionStaffFix;
  int? commissionStaffPercent;
  int? commissionAffiliateFix;
  int? commissionAffiliatePercent;
  int? idTrademark;
  String? info;
  String? code;

  ReqCreateProduct(
      {this.id,
        this.name,
        this.idCategory,
        this.description,
        this.price,
        this.status,
        this.image,
        this.duration,
        this.commissionStaffFix,
        this.commissionStaffPercent,
        this.commissionAffiliateFix,
        this.commissionAffiliatePercent,
        this.info,
        this.code,
        this.idTrademark});

  ReqCreateProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idCategory = json['id_category'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    image = json['image'];
    duration = json['duration'];
    commissionStaffFix = json['commission_staff_fix'];
    commissionStaffPercent = json['commission_staff_percent'];
    commissionAffiliateFix = json['commission_affiliate_fix'];
    commissionAffiliatePercent = json['commission_affiliate_percent'];
    idTrademark = json['id_trademark'];
    info = json['info'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['id_category'] = idCategory;
    data['description'] = description;
    data['price'] = price;
    data['status'] = status;
    data['image'] = image;
    data['duration'] = duration;
    data['commission_staff_fix'] = commissionStaffFix;
    data['commission_staff_percent'] = commissionStaffPercent;
    data['commission_affiliate_fix'] = commissionAffiliateFix;
    data['commission_affiliate_percent'] = commissionAffiliatePercent;
    data['id_trademark'] = idTrademark;
    data['info'] = info;
    data['code'] = code;
    return data;
  }
}

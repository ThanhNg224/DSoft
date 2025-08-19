class ReqAddEditCombo {
  int? id;
  String? name;
  String? description;
  int? price;
  String? status;
  int? duration;
  int? commissionStaffFix;
  int? commissionStaffPercent;
  String? dataService;
  String? dataProduct;

  ReqAddEditCombo(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.status,
        this.duration,
        this.commissionStaffFix,
        this.commissionStaffPercent,
        this.dataService,
        this.dataProduct});

  ReqAddEditCombo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    duration = json['duration'];
    commissionStaffFix = json['commission_staff_fix'];
    commissionStaffPercent = json['commission_staff_percent'];
    dataService = json['data_service'];
    dataProduct = json['data_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['status'] = status;
    data['duration'] = duration;
    data['commission_staff_fix'] = commissionStaffFix;
    data['commission_staff_percent'] = commissionStaffPercent;
    data['data_service'] = dataService;
    data['data_product'] = dataProduct;
    return data;
  }
}

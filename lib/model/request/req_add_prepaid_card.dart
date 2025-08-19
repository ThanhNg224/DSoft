class ReqAddPrepaidCard {
  int? id;
  String? name;
  int? priceSell;
  String? note;
  int? useTime;
  String? status;
  int? commissionStaffFix;
  int? commissionStaffPercent;
  int? price;

  ReqAddPrepaidCard(
      {this.id,
        this.name,
        this.priceSell,
        this.note,
        this.useTime,
        this.status,
        this.commissionStaffFix,
        this.price,
        this.commissionStaffPercent});

  ReqAddPrepaidCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priceSell = json['price_sell'];
    note = json['note'];
    useTime = json['use_time'];
    status = json['status'];
    commissionStaffFix = json['commission_staff_fix'];
    commissionStaffPercent = json['commission_staff_percent'];
    price = json['price'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price_sell'] = priceSell;
    data['note'] = note;
    data['use_time'] = useTime;
    data['status'] = status;
    data['commission_staff_fix'] = commissionStaffFix;
    data['commission_staff_percent'] = commissionStaffPercent;
    data['price'] = price;
    return data;
  }
}

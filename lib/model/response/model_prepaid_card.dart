class ModelPrepaidCard {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelPrepaidCard({this.data, this.code, this.messages, this.totalData});

  ModelPrepaidCard.fromJson(Map<String, dynamic> json) {
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
  int? price;
  int? priceSell;
  String? note;
  int? useTime;
  int? idMember;
  int? idSpa;
  String? status;
  int? commissionStaffFix;
  int? commissionStaffPercent;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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

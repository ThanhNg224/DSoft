class ReqAddBonusPunish {
  int? money;
  int? idStaff;
  String? createdAt;
  String? note;
  String? type;
  int? id;

  ReqAddBonusPunish({this.money, this.idStaff, this.createdAt, this.note, this.type, this.id});

  ReqAddBonusPunish.fromJson(Map<String, dynamic> json) {
    money = json['money'];
    idStaff = json['id_staff'];
    createdAt = json['created_at'];
    note = json['note'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['money'] = money;
    data['id_staff'] = idStaff;
    data['created_at'] = createdAt;
    data['note'] = note;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}

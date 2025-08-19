class ReqAddDebtCollection {
  int? id;
  int? total;
  int? idCustomer;
  String? fullName;
  String? time;
  String? note;

  ReqAddDebtCollection(
      {this.id,
        this.total,
        this.idCustomer,
        this.fullName,
        this.time,
        this.note});

  ReqAddDebtCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    idCustomer = json['id_customer'];
    fullName = json['full_name'];
    time = json['time'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total'] = total;
    data['id_customer'] = idCustomer;
    data['full_name'] = fullName;
    data['time'] = time;
    data['note'] = note;
    return data;
  }
}

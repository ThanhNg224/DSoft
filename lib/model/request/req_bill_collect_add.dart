class ReqBillCollectAdd {
  int? id;
  int? idSpa;
  int? idStaff;
  int? total;
  String? note;
  String? typeCollectionBill;
  int? idCustomer;
  String? fullName;
  String? time;

  ReqBillCollectAdd(
      {this.id,
        this.idSpa,
        this.idStaff,
        this.total,
        this.note,
        this.typeCollectionBill,
        this.idCustomer,
        this.fullName,
        this.time});

  ReqBillCollectAdd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSpa = json['id_spa'];
    idStaff = json['id_staff'];
    total = json['total'];
    note = json['note'];
    typeCollectionBill = json['type_collection_bill'];
    idCustomer = json['id_customer'];
    fullName = json['full_name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_spa'] = idSpa;
    data['id_staff'] = idStaff;
    data['total'] = total;
    data['note'] = note;
    data['type_collection_bill'] = typeCollectionBill;
    data['id_customer'] = idCustomer;
    data['full_name'] = fullName;
    data['time'] = time;
    return data;
  }
}

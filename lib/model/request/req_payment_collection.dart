class ReqPaymentCollection {
  int? id;
  int? total;
  String? typeCollectionBill;
  String? note;

  ReqPaymentCollection(
      {this.id, this.total, this.typeCollectionBill, this.note});

  ReqPaymentCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    typeCollectionBill = json['type_collection_bill'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total'] = total;
    data['type_collection_bill'] = typeCollectionBill;
    data['note'] = note;
    return data;
  }
}

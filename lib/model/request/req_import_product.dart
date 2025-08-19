class ReqImportProduct {
  String? dataOrder;
  int? idPartner;
  String? partnerName;
  String? typeBill;
  int? idWarehouse;

  ReqImportProduct(
      {this.dataOrder,
        this.idPartner,
        this.partnerName,
        this.typeBill,
        this.idWarehouse});

  ReqImportProduct.fromJson(Map<String, dynamic> json) {
    dataOrder = json['data_order'];
    idPartner = json['id_partner'];
    partnerName = json['partner_name'];
    typeBill = json['type_bill'];
    idWarehouse = json['id_warehouse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_order'] = dataOrder;
    data['id_partner'] = idPartner;
    data['partner_name'] = partnerName;
    data['type_bill'] = typeBill;
    data['id_warehouse'] = idWarehouse;
    return data;
  }
}

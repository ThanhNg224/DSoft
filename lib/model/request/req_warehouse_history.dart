class ReqWarehouseHistory {
  int? page;
  int? idWarehouse;
  int? idPartner;
  int? idProduct;

  ReqWarehouseHistory(
      {this.page, this.idWarehouse, this.idPartner, this.idProduct});

  ReqWarehouseHistory.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    idWarehouse = json['id_Warehouse'];
    idPartner = json['id_partner'];
    idProduct = json['id_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['id_Warehouse'] = idWarehouse;
    data['id_partner'] = idPartner;
    data['id_product'] = idProduct;
    return data;
  }
}

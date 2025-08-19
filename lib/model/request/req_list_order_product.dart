class ReqListOrderProduct {
  int? idCustomer;
  String? dateStart;
  String? dateEnd;
  int? page;

  ReqListOrderProduct(
      {this.idCustomer, this.dateStart, this.dateEnd, this.page});

  ReqListOrderProduct.fromJson(Map<String, dynamic> json) {
    idCustomer = json['id_customer'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_customer'] = idCustomer;
    data['date_start'] = dateStart;
    data['date_end'] = dateEnd;
    data['page'] = page;
    return data;
  }
}

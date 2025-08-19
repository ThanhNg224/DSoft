class ReqDebtCollection {
  int? page;
  int? idCustomer;
  String? dateStart;
  String? dateEnd;

  ReqDebtCollection({this.page, this.idCustomer, this.dateStart, this.dateEnd});

  ReqDebtCollection.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    idCustomer = json['id_customer'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['id_customer'] = idCustomer;
    data['date_start'] = dateStart;
    data['date_end'] = dateEnd;
    return data;
  }
}

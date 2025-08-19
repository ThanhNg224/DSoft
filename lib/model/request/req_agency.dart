class ReqAgency {
  int? page;
  int? idStaff;
  String? dateStart;
  String? dateEnd;
  int? status;

  ReqAgency(
      {this.page, this.idStaff, this.dateStart, this.dateEnd, this.status});

  ReqAgency.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    idStaff = json['id_staff'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['id_staff'] = idStaff;
    data['date_start'] = dateStart;
    data['date_end'] = dateEnd;
    data['status'] = status;
    return data;
  }
}

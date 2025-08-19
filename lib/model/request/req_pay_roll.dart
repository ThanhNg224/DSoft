class ReqPayRoll {
  int? idStaff;
  int? month;
  int? year;
  int? totalDay;
  String? status;
  int? page;

  ReqPayRoll({this.idStaff, this.month, this.year, this.totalDay, this.status, this.page});

  ReqPayRoll.fromJson(Map<String, dynamic> json) {
    idStaff = json['id_staff'];
    month = json['month'];
    year = json['year'];
    totalDay = json['total_day'];
    status = json['status'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_staff'] = idStaff;
    data['month'] = month;
    data['year'] = year;
    data['total_day'] = totalDay;
    data['status'] = status;
    data['page'] = page;
    return data;
  }
}

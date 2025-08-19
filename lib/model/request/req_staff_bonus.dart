class ReqStaffBonus {
  String? type;
  int? page;
  int? idStaff;
  String? dateStart;
  String? dateEnd;
  String? status;

  ReqStaffBonus(
      {this.type,
        this.page,
        this.idStaff,
        this.dateStart,
        this.dateEnd,
        this.status});

  ReqStaffBonus.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    page = json['page'];
    idStaff = json['id_staff'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['page'] = page;
    data['id_staff'] = idStaff;
    data['date_start'] = dateStart;
    data['date_end'] = dateEnd;
    data['status'] = status;
    return data;
  }
}

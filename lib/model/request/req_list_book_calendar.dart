class ReqListBookCalendar {
  int? page;
  String? fullName;
  String? phone;
  String? idStaff;
  String? idService;
  String? dateStart;
  String? dateEnd;

  ReqListBookCalendar(
      {this.page,
        this.fullName,
        this.phone,
        this.idStaff,
        this.idService,
        this.dateStart,
        this.dateEnd});

  ReqListBookCalendar.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    fullName = json['full_name'];
    phone = json['phone'];
    idStaff = json['id_staff'];
    idService = json['id_service'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['id_staff'] = idStaff;
    data['id_service'] = idService;
    data['date_start'] = dateStart;
    data['date_end'] = dateEnd;
    return data;
  }
}

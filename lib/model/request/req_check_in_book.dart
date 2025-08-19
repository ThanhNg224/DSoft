class ReqCheckInBook {
  int? idStaff;
  int? idBook;
  int? idBed;
  String? timeCheckin;

  ReqCheckInBook({this.idStaff, this.idBook, this.idBed, this.timeCheckin});

  ReqCheckInBook.fromJson(Map<String, dynamic> json) {
    idStaff = json['id_staff'];
    idBook = json['id_book'];
    idBed = json['id_bed'];
    timeCheckin = json['time_checkin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_staff'] = idStaff;
    data['id_book'] = idBook;
    data['id_bed'] = idBed;
    data['time_checkin'] = timeCheckin;
    return data;
  }
}

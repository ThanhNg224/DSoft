class ReqUseCombo {
  int? idBed;
  int? idStaff;
  int? id;
  int? idService;
  String? time;
  String? note;

  ReqUseCombo(
      {this.idBed,
        this.idStaff,
        this.id,
        this.idService,
        this.time,
        this.note});

  ReqUseCombo.fromJson(Map<String, dynamic> json) {
    idBed = json['id_bed'];
    idStaff = json['id_staff'];
    id = json['id'];
    idService = json['id_service'];
    time = json['time'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_bed'] = idBed;
    data['id_staff'] = idStaff;
    data['id'] = id;
    data['id_service'] = idService;
    data['time'] = time;
    data['note'] = note;
    return data;
  }
}

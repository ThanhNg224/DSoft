class ReqAddOrEditBook {
  int? id;
  int? idStaff;
  int? idBook;
  int? idBed;
  String? timeBook;
  String? phone;
  int? idService;
  int? status;
  int? type1;
  int? type2;
  int? type3;
  int? type4;

  ReqAddOrEditBook(
      {this.id,
        this.idStaff,
        this.idBook,
        this.idBed,
        this.timeBook,
        this.phone,
        this.idService,
        this.status,
        this.type1,
        this.type2,
        this.type3,
        this.type4});

  ReqAddOrEditBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idStaff = json['id_staff'];
    idBook = json['id_book'];
    idBed = json['id_bed'];
    timeBook = json['time_book'];
    phone = json['phone'];
    idService = json['id_service'];
    status = json['status'];
    type1 = json['type1'];
    type2 = json['type2'];
    type3 = json['type3'];
    type4 = json['type4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_staff'] = idStaff;
    data['id_book'] = idBook;
    data['id_bed'] = idBed;
    data['time_book'] = timeBook;
    data['phone'] = phone;
    data['id_service'] = idService;
    data['status'] = status;
    data['type1'] = type1;
    data['type2'] = type2;
    data['type3'] = type3;
    data['type4'] = type4;
    return data;
  }
}

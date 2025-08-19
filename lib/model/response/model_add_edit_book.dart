class ModelAddEditBook {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelAddEditBook({this.data, this.code, this.messages, this.totalData});

  ModelAddEditBook.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    data['messages'] = messages;
    data['totalData'] = totalData;
    return data;
  }
}

class Data {
  int? createdAt;
  int? timeBook;
  String? name;
  String? phone;
  dynamic email;
  int? idMember;
  int? idCustomer;
  int? idService;
  int? timeBookEnd;
  int? idStaff;
  int? status;
  int? idBed;
  dynamic note;
  int? aptStep;
  int? aptTimes;
  int? idSpa;
  int? type1;
  int? type2;
  int? type3;
  int? type4;
  int? repeatBook;
  int? id;

  Data(
      {this.createdAt,
        this.timeBook,
        this.name,
        this.phone,
        this.email,
        this.idMember,
        this.idCustomer,
        this.idService,
        this.timeBookEnd,
        this.idStaff,
        this.status,
        this.idBed,
        this.note,
        this.aptStep,
        this.aptTimes,
        this.idSpa,
        this.type1,
        this.type2,
        this.type3,
        this.type4,
        this.repeatBook,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    timeBook = json['time_book'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    idMember = json['id_member'];
    idCustomer = json['id_customer'];
    idService = json['id_service'];
    timeBookEnd = json['time_book_end'];
    idStaff = json['id_staff'];
    status = json['status'];
    idBed = json['id_bed'];
    note = json['note'];
    aptStep = json['apt_step'];
    aptTimes = json['apt_times'];
    idSpa = json['id_spa'];
    type1 = json['type1'];
    type2 = json['type2'];
    type3 = json['type3'];
    type4 = json['type4'];
    repeatBook = json['repeat_book'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['time_book'] = timeBook;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['id_member'] = idMember;
    data['id_customer'] = idCustomer;
    data['id_service'] = idService;
    data['time_book_end'] = timeBookEnd;
    data['id_staff'] = idStaff;
    data['status'] = status;
    data['id_bed'] = idBed;
    data['note'] = note;
    data['apt_step'] = aptStep;
    data['apt_times'] = aptTimes;
    data['id_spa'] = idSpa;
    data['type1'] = type1;
    data['type2'] = type2;
    data['type3'] = type3;
    data['type4'] = type4;
    data['repeat_book'] = repeatBook;
    data['id'] = id;
    return data;
  }
}

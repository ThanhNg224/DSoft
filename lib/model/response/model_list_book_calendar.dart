class ModelListBookCalendar {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListBookCalendar({this.data, this.code, this.messages, this.totalData});

  ModelListBookCalendar.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['messages'] = messages;
    data['totalData'] = totalData;
    return data;
  }
}

class Data {
  int? id;
  int? idCustomer;
  String? name;
  String? phone;
  String? email;
  int? timeBook;
  int? status;
  String? note;
  int? type1;
  int? type2;
  int? type3;
  int? type4;
  bool? repeatBook;
  int? aptTimes;
  int? aptStep;
  Services? services;
  Members? members;
  Members? beds;

  Data(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.timeBook,
        this.status,
        this.note,
        this.type1,
        this.type2,
        this.type3,
        this.type4,
        this.repeatBook,
        this.aptTimes,
        this.idCustomer,
        this.aptStep,
        this.services,
        this.members,
        this.beds});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    timeBook = json['time_book'];
    status = json['status'];
    note = json['note'];
    type1 = json['type1'];
    type2 = json['type2'];
    type3 = json['type3'];
    type4 = json['type4'];
    repeatBook = json['repeat_book'];
    aptTimes = json['apt_times'];
    aptStep = json['apt_step'];
    idCustomer = json['id_customer'];
    services = json['Services'] != null
        ? Services.fromJson(json['Services'])
        : null;
    members =
    json['Members'] != null ? Members.fromJson(json['Members']) : null;
    beds = json['Beds'] != null ? Members.fromJson(json['Beds']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['time_book'] = timeBook;
    data['status'] = status;
    data['note'] = note;
    data['type1'] = type1;
    data['type2'] = type2;
    data['type3'] = type3;
    data['type4'] = type4;
    data['id_customer'] = idCustomer;
    data['repeat_book'] = repeatBook;
    data['apt_times'] = aptTimes;
    data['apt_step'] = aptStep;
    if (services != null) {
      data['Services'] = services!.toJson();
    }
    if (members != null) {
      data['Members'] = members!.toJson();
    }
    if (beds != null) {
      data['Beds'] = beds!.toJson();
    }
    return data;
  }
}

class Services {
  String? name;
  int? id;

  Services({this.name});

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Members {
  String? name;
  int? id;

  Members({this.name, this.id});

  Members.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

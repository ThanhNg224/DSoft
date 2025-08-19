class ModelDiagramRoomBed {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelDiagramRoomBed({this.data, this.code, this.messages, this.totalData});

  ModelDiagramRoomBed.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? status;
  int? idMember;
  int? idSpa;
  int? createdAt;
  List<Bed>? listBed;

  Data(
      {this.id,
        this.name,
        this.status,
        this.idMember,
        this.idSpa,
        this.createdAt,
        this.listBed});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    createdAt = json['created_at'];
    if (json['bed'] != null) {
      listBed = <Bed>[];
      json['bed'].forEach((v) {
        listBed!.add(Bed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['created_at'] = createdAt;
    if (listBed != null) {
      data['bed'] = listBed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bed {
  int? id;
  String? name;
  int? status;
  int? idMember;
  int? idSpa;
  int? idRoom;
  int? createdAt;
  int? idStaff;
  int? idOrder;
  int? idCustomer;
  String? idUserservice;
  int? timeCheckin;

  Bed(
      {this.id,
        this.name,
        this.status,
        this.idMember,
        this.idSpa,
        this.idRoom,
        this.createdAt,
        this.idStaff,
        this.idOrder,
        this.idCustomer,
        this.idUserservice,
        this.timeCheckin});

  Bed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    idRoom = json['id_room'];
    createdAt = json['created_at'];
    idStaff = json['id_staff'];
    idOrder = json['id_order'];
    idCustomer = json['id_customer'];
    idUserservice = json['id_userservice'];
    timeCheckin = json['time_checkin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['id_room'] = idRoom;
    data['created_at'] = createdAt;
    data['id_staff'] = idStaff;
    data['id_order'] = idOrder;
    data['id_customer'] = idCustomer;
    data['id_userservice'] = idUserservice;
    data['time_checkin'] = timeCheckin;
    return data;
  }
}

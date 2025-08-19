import 'model_staff_bonus.dart';

class ModelListPayRoll {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListPayRoll({this.data, this.code, this.messages, this.totalData});

  ModelListPayRoll.fromJson(Map<String, dynamic> json) {
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
  int? salary;
  int? fixedSalary;
  int? work;
  int? workingDay;
  int? commission;
  int? bonus;
  int? punish;
  int? allowance;
  int? fine;
  int? insurance;
  int? advance;
  String? status;
  dynamic note;
  int? month;
  int? year;
  int? idMember;
  int? idStaff;
  int? createdAt;
  int? updatedAt;
  int? paymentDate;
  String? noteBoss;
  InfoStaff? infoStaff;

  Data(
      {this.id,
        this.salary,
        this.fixedSalary,
        this.work,
        this.workingDay,
        this.commission,
        this.bonus,
        this.allowance,
        this.fine,
        this.insurance,
        this.advance,
        this.status,
        this.note,
        this.month,
        this.year,
        this.idMember,
        this.idStaff,
        this.createdAt,
        this.updatedAt,
        this.paymentDate,
        this.noteBoss,
        this.punish,
        this.infoStaff});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salary = json['salary'];
    fixedSalary = json['fixed_salary'];
    work = json['work'];
    workingDay = json['working_day'];
    commission = json['commission'];
    bonus = json['bonus'];
    punish = json['punish'];
    allowance = json['allowance'];
    fine = json['fine'];
    insurance = json['insurance'];
    advance = json['advance'];
    status = json['status'];
    note = json['note'];
    month = json['month'];
    year = json['year'];
    idMember = json['id_member'];
    idStaff = json['id_staff'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentDate = json['payment_date'];
    noteBoss = json['note_boss'];
    infoStaff = json['infoStaff'] != null
        ? InfoStaff.fromJson(json['infoStaff'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['salary'] = salary;
    data['fixed_salary'] = fixedSalary;
    data['work'] = work;
    data['working_day'] = workingDay;
    data['commission'] = commission;
    data['bonus'] = bonus;
    data['allowance'] = allowance;
    data['fine'] = fine;
    data['insurance'] = insurance;
    data['advance'] = advance;
    data['status'] = status;
    data['note'] = note;
    data['month'] = month;
    data['year'] = year;
    data['punish'] = punish;
    data['id_member'] = idMember;
    data['id_staff'] = idStaff;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['payment_date'] = paymentDate;
    data['note_boss'] = noteBoss;
    if (infoStaff != null) {
      data['infoStaff'] = infoStaff!.toJson();
    }
    return data;
  }
}

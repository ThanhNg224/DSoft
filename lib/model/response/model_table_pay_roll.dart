class ModelTablePayRoll {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelTablePayRoll({this.data, this.code, this.messages, this.totalData});

  ModelTablePayRoll.fromJson(Map<String, dynamic> json) {
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
  int? idStaff;
  int? month;
  int? year;
  int? createdAt;
  int? idMember;
  int? salary;
  int? work;
  int? fixedSalary;
  int? workingDay;
  int? commission;
  int? bonus;
  int? punish;
  int? allowance;
  int? insurance;
  int? advance;
  String? status;
  int? updatedAt;

  Data(
      {this.idStaff,
        this.month,
        this.year,
        this.createdAt,
        this.idMember,
        this.salary,
        this.work,
        this.fixedSalary,
        this.workingDay,
        this.commission,
        this.bonus,
        this.punish,
        this.allowance,
        this.insurance,
        this.advance,
        this.status,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    idStaff = json['id_staff'];
    month = json['month'];
    year = json['year'];
    createdAt = json['created_at'];
    idMember = json['id_member'];
    salary = json['salary'];
    work = json['work'];
    fixedSalary = json['fixed_salary'];
    workingDay = json['working_day'];
    commission = json['commission'];
    bonus = json['bonus'];
    punish = json['punish'];
    allowance = json['allowance'];
    insurance = json['insurance'];
    advance = json['advance'];
    status = json['status'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_staff'] = idStaff;
    data['month'] = month;
    data['year'] = year;
    data['created_at'] = createdAt;
    data['id_member'] = idMember;
    data['salary'] = salary;
    data['work'] = work;
    data['fixed_salary'] = fixedSalary;
    data['working_day'] = workingDay;
    data['commission'] = commission;
    data['bonus'] = bonus;
    data['punish'] = punish;
    data['allowance'] = allowance;
    data['insurance'] = insurance;
    data['advance'] = advance;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    return data;
  }
}

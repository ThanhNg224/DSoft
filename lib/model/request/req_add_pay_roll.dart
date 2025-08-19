class ReqAddPayroll {
  int? idStaff;
  int? month;
  int? year;
  int? totalDay;
  int? salary;
  int? fixedSalary;
  int? workingDay;
  int? commission;
  int? allowance;
  int? insurance;
  int? bonus;
  int? punish;

  ReqAddPayroll(
      {this.idStaff,
        this.month,
        this.year,
        this.totalDay,
        this.salary,
        this.fixedSalary,
        this.workingDay,
        this.commission,
        this.allowance,
        this.insurance,
        this.bonus,
        this.punish});

  ReqAddPayroll.fromJson(Map<String, dynamic> json) {
    idStaff = json['id_staff'];
    month = json['month'];
    year = json['year'];
    totalDay = json['total_day'];
    salary = json['salary'];
    fixedSalary = json['fixed_salary'];
    workingDay = json['working_day'];
    commission = json['commission'];
    allowance = json['allowance'];
    insurance = json['insurance'];
    bonus = json['bonus'];
    punish = json['punish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_staff'] = idStaff;
    data['month'] = month;
    data['year'] = year;
    data['total_day'] = totalDay;
    data['salary'] = salary;
    data['fixed_salary'] = fixedSalary;
    data['working_day'] = workingDay;
    data['commission'] = commission;
    data['allowance'] = allowance;
    data['insurance'] = insurance;
    data['bonus'] = bonus;
    data['punish'] = punish;
    return data;
  }
}

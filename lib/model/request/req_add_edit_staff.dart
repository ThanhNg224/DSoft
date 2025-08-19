class ReqAddEditStaff {
  int? id;
  String? name;
  int? idGroup;
  String? avatar;
  String? checkListPermission;
  String? address;
  String? birthday;
  int? status;
  String? password;
  String? phone;
  int? fixedSalary;
  int? insurance;
  int? allowance;
  String? accountBank;
  String? codeBank;
  String? idCard;

  ReqAddEditStaff({
    this.id,
    this.name,
    this.idGroup,
    this.avatar,
    this.checkListPermission,
    this.address,
    this.birthday,
    this.status,
    this.phone,
    this.password,
    this.fixedSalary,
    this.insurance,
    this.allowance,
    this.accountBank,
    this.codeBank,
    this.idCard,
  });

  ReqAddEditStaff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idGroup = json['id_group'];
    avatar = json['avatar'];
    checkListPermission = json['check_list_permission'];
    address = json['address'];
    birthday = json['birthday'];
    status = json['status'];
    phone = json['phone'];
    password = json['password'];
    fixedSalary = (json['fixed_salary'] as num?)?.toInt();
    insurance = (json['insurance'] as num?)?.toInt();
    allowance = (json['allowance'] as num?)?.toInt();
    accountBank = json['account_bank'];
    codeBank = json['code_bank'];
    idCard = json['id_card'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['id_group'] = idGroup;
    data['avatar'] = avatar;
    data['check_list_permission'] = checkListPermission;
    data['address'] = address;
    data['birthday'] = birthday;
    data['status'] = status;
    data['phone'] = phone;
    data['password'] = password;
    data['fixed_salary'] = fixedSalary;
    data['insurance'] = insurance;
    data['allowance'] = allowance;
    data['account_bank'] = accountBank;
    data['code_bank'] = codeBank;
    data['id_card'] = idCard;
    return data;
  }
}

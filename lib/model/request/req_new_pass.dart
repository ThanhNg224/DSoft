class ReqNewPass {
  String? phone;
  String? code;
  String? passNew;
  String? passAgain;

  ReqNewPass({this.phone, this.code, this.passNew, this.passAgain});

  ReqNewPass.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    code = json['code'];
    passNew = json['passNew'];
    passAgain = json['passAgain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['code'] = code;
    data['passNew'] = passNew;
    data['passAgain'] = passAgain;
    return data;
  }
}

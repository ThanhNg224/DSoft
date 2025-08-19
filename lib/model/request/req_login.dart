class ReqLogin {
  String? phone;
  String? password;
  String? tokenDevice;

  ReqLogin({this.phone, this.password, this.tokenDevice});

  ReqLogin.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    tokenDevice = json['token_device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['token_device'] = tokenDevice;
    return data;
  }
}
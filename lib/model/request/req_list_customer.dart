class ReqListCustomer {
  int? page;
  String? phone;
  String? name;
  String? email;

  ReqListCustomer({this.page, this.phone, this.name, this.email});

  ReqListCustomer.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['phone'] = phone;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

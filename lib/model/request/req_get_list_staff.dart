class ReqGetListStaff {
  int? id;
  String? name;
  String? phone;
  int? idGroup;
  String? email;
  int? page;

  ReqGetListStaff(
      {this.id, this.name, this.phone, this.idGroup, this.email, this.page});

  ReqGetListStaff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    idGroup = json['id_group'];
    email = json['email'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['id_group'] = idGroup;
    data['email'] = email;
    data['page'] = page;
    return data;
  }
}

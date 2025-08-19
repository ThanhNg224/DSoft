class ReqAEPartner {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? email;
  String? note;

  ReqAEPartner(
      {this.id, this.name, this.phone, this.address, this.email, this.note});

  ReqAEPartner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['email'] = email;
    data['note'] = note;
    return data;
  }
}

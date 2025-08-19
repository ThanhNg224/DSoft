class ReqAddEditSpa {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? email;
  String? note;
  String? facebook;
  String? website;
  String? zalo;
  String? image;

  ReqAddEditSpa(
      {this.id,
        this.name,
        this.phone,
        this.address,
        this.email,
        this.note,
        this.facebook,
        this.website,
        this.zalo,
        this.image});

  ReqAddEditSpa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    note = json['note'];
    facebook = json['facebook'];
    website = json['website'];
    zalo = json['zalo'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['email'] = email;
    data['note'] = note;
    data['facebook'] = facebook;
    data['website'] = website;
    data['zalo'] = zalo;
    data['image'] = image;
    return data;
  }
}

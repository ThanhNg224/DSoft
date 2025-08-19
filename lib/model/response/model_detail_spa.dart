class ModelDetailSpa {
  Data? data;
  int? code;
  String? messages;
  int? totalData;

  ModelDetailSpa(
      {this.data, this.code, this.messages, this.totalData});

  ModelDetailSpa.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? phone;
  String? email;
  int? idMember;
  String? address;
  dynamic note;
  String? image;
  String? slug;
  String? facebook;
  String? website;
  String? zalo;
  int? createdAt;
  int? updatedAt;

  Data(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.idMember,
        this.address,
        this.note,
        this.image,
        this.slug,
        this.facebook,
        this.website,
        this.zalo,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    idMember = json['id_member'];
    address = json['address'];
    note = json['note'];
    image = json['image'];
    slug = json['slug'];
    facebook = json['facebook'];
    website = json['website'];
    zalo = json['zalo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['id_member'] = idMember;
    data['address'] = address;
    data['note'] = note;
    data['image'] = image;
    data['slug'] = slug;
    data['facebook'] = facebook;
    data['website'] = website;
    data['zalo'] = zalo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

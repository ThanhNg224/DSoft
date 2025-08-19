class ModelListTrademark {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListTrademark({this.data, this.code, this.messages, this.totalData});

  ModelListTrademark.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  String? description;
  String? createdAt;
  int? idMember;
  String? image;
  String? slug;

  Data(
      {this.id,
        this.name,
        this.description,
        this.createdAt,
        this.idMember,
        this.image,
        this.slug});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    idMember = json['id_member'];
    image = json['image'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['id_member'] = idMember;
    data['image'] = image;
    data['slug'] = slug;
    return data;
  }
}

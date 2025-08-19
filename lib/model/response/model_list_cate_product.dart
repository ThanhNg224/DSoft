class ModelListCateProduct {
  List<ModelDetailCateProduct>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelListCateProduct({this.data, this.code, this.messages, this.totalData});

  ModelListCateProduct.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ModelDetailCateProduct>[];
      json['data'].forEach((v) {
        data!.add(ModelDetailCateProduct.fromJson(v));
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

class ModelDetailCateProduct {
  int? id;
  String? name;
  int? parent;
  String? image;
  String? keyword;
  String? description;
  String? type;
  String? slug;
  dynamic status;
  int? weighty;
  int? idMember;

  ModelDetailCateProduct(
      {this.id,
        this.name,
        this.parent,
        this.image,
        this.keyword,
        this.description,
        this.type,
        this.slug,
        this.status,
        this.weighty,
        this.idMember});

  ModelDetailCateProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    image = json['image'];
    keyword = json['keyword'];
    description = json['description'];
    type = json['type'];
    slug = json['slug'];
    status = json['status'];
    weighty = json['weighty'];
    idMember = json['id_member'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent'] = parent;
    data['image'] = image;
    data['keyword'] = keyword;
    data['description'] = description;
    data['type'] = type;
    data['slug'] = slug;
    data['status'] = status;
    data['weighty'] = weighty;
    data['id_member'] = idMember;
    return data;
  }
}


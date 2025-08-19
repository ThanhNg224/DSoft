class ReqGetListService {
  int? page;
  int? id;
  int? code;
  int? idCategory;
  String? name;

  ReqGetListService(
      {this.page, this.id, this.code, this.idCategory, this.name});

  ReqGetListService.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    id = json['id'];
    code = json['code'];
    idCategory = json['id_category'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['id'] = id;
    data['code'] = code;
    data['id_category'] = idCategory;
    data['name'] = name;
    return data;
  }
}

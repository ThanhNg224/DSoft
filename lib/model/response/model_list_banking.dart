class ModelListBanking {
  int? id;
  String? name;
  String? code;

  ModelListBanking({this.id, this.name, this.code});

  ModelListBanking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class ModelListPriceExtend {
  int? yer;
  int? price;

  ModelListPriceExtend({this.yer, this.price});

  ModelListPriceExtend.fromJson(Map<String, dynamic> json) {
    yer = json['yer'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yer'] = yer;
    data['price'] = price;
    return data;
  }
}

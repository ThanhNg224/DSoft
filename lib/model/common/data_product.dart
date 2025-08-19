import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_product.dart';

class DataProduct {
  Data? value;
  TextEditingController? cQuantity;

  DataProduct({this.value, this.cQuantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = value?.id;
    data['quantity'] = cQuantity?.text.removeCommaMoney;
    return data;
  }
}
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_service.dart';

class DataService {
  Data? value;
  TextEditingController? cQuantity;

  DataService({this.value, this.cQuantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_service'] = value?.id;
    data['quantity'] = cQuantity?.text.removeCommaMoney;
    return data;
  }
}
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_order_product.dart';

class OrderProductCubit extends Cubit<List<Data>> {
  OrderProductCubit() : super(const []);

  void onGetList(List<Data> list) => emit(list);
}
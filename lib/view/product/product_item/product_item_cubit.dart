import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_product.dart';

class ProductItemCubit extends Cubit<List<Data>> {
  ProductItemCubit() : super(const []);

  void getListProduct(List<Data> list) => emit(list);
}
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_cate_product.dart';

class ProductCategoryCubit extends Cubit<List<ModelDetailCateProduct>> {
  ProductCategoryCubit() : super(const []);

  void getListCateProduct(List<ModelDetailCateProduct> list) => emit(list);
}
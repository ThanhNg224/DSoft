import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_category_customer.dart';

class CustomCateCubit extends Cubit<List<Category>> {
  CustomCateCubit() : super(const []);

  void getListCate(List<Category> list) => emit(list);
}
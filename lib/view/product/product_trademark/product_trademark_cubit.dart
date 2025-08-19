import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_trademark.dart';

class ProductTrademarkCubit extends Cubit<List<Data>> {
  ProductTrademarkCubit() : super(const []);

  void getListTrademark(List<Data> list)
  => emit(list);
}
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_combo.dart';

class OrderTreatmentCubit extends Cubit<List<Data>> {
  OrderTreatmentCubit() : super(const []);

  void onGetListOrderCombo(List<Data> list) => emit(list);
}
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_service.dart';

class OrderServiceCubit extends Cubit<List<Data>> {
  OrderServiceCubit() : super(const []);

  void onGetListOrderService(List<Data> list) => emit(list);
}
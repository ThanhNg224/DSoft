import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_detail_order_service.dart';

class OrderServiceDetailCubit extends Cubit<ModelDetailOrderService> {
  OrderServiceDetailCubit() : super(ModelDetailOrderService());

  void getDetailOrderServiceDetail(ModelDetailOrderService? data)
  => emit(data ?? ModelDetailOrderService());
}
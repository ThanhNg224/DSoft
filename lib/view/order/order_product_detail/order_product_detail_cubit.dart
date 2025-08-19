import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_product_detail.dart';

class OrderProductDetailCubit extends Cubit<ModelOrderProductDetail?> {
  OrderProductDetailCubit() : super(ModelOrderProductDetail());

  void getDetailOrderProduct(ModelOrderProductDetail? response)
  => emit(response);
}
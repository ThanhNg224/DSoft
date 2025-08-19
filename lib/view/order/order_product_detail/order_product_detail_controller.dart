import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_product_detail.dart';
import 'package:spa_project/view/order/order_product_detail/order_product_detail_cubit.dart';

class OrderProductDetailController extends BaseController<int> with Repository {
  OrderProductDetailController(super.context);
  
  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => onGetDetail());
    super.onInitState();
  }

  void onGetDetail() async {
    setScreenState = screenStateLoading;
    final response = await detailOrderProductAPI(args);
    if(response is Success<ModelOrderProductDetail>) {
      if(response.value.code == Result.isOk) {
        setScreenState = screenStateOk;
        onTriggerEvent<OrderProductDetailCubit>().getDetailOrderProduct(response.value);
      } else {
        setScreenState = screenStateError;
        errorWidget = Utilities.errorMesWidget("Không thể lấy dữ liệu chi tiết đơn hàng $args");
      }
    }
    if(response is Failure<ModelOrderProductDetail>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
}
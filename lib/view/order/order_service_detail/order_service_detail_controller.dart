import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_detail_order_service.dart';
import 'package:spa_project/view/order/order_service_detail/order_service_detail_cubit.dart';

class OrderServiceDetailController extends BaseController<int> with Repository {
  OrderServiceDetailController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => onGetDetailOrderService());
    super.onInitState();
  }

  void onGetDetailOrderService() async {
    setScreenState = screenStateLoading;
    final response = await detailOrderServiceAPI(args);
    if(response is Success<ModelDetailOrderService>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<OrderServiceDetailCubit>().getDetailOrderServiceDetail(response.value);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy thông tin đơn hàng");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelDetailOrderService>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
}
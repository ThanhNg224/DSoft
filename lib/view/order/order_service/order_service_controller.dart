import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_service.dart';
import 'package:spa_project/view/order/order_service/order_service_cubit.dart';

class OrderServiceController extends BaseController with Repository {
  OrderServiceController(super.context);

  List<Data> _list = [];
  Widget errorWidget = const SizedBox();
  int page = 1;

  @override
  void onInitState() {
    final listData = onTriggerEvent<OrderServiceCubit>().state;
    if(listData.isEmpty) onGetListOrderService();
    if(listData.length < 10) isMoreEnable = false;
    setEnableScrollController = true;
    super.onInitState();
  }

  @override
  void onLoadMore() {
    page ++;
    onGetListOrderService(isLoad: false);
    super.onLoadMore();
  }

  Future<void> onGetListOrderService({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listOrderServiceAPI(page);
    if(response is Success<ModelOrderService>) {
      if(response.value.code == Result.isOk) {
        _onGetListOrderSuccess(response.value.data ?? []);
      } else {
        setScreenState = screenStateError;
        errorWidget = Utilities.errorMesWidget("Không thể lấy danh sách đơn sản phẩm");
      }
    }
    if(response is Failure<ModelOrderService>) {
      setScreenState = screenStateError;
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void _onGetListOrderSuccess(List<Data> response) {
    _list = List.from(onTriggerEvent<OrderServiceCubit>().state);
    if(page == 1) _list = [];
    _list.addAll(response);
    if (_list.isEmpty || response.length < 10) {
      isMoreEnable = false;
    } else {
      isMoreEnable = true;
    }
    setScreenState = screenStateOk;
    onTriggerEvent<OrderServiceCubit>().onGetListOrderService(_list);
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    page = 1;
    isMoreEnable = true;
    await onGetListOrderService(isLoad: false);
  }
}
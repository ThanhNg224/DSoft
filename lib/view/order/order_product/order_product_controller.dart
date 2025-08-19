import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_list_order_product.dart';
import 'package:spa_project/model/response/model_list_order_product.dart';
import 'package:spa_project/view/order/order_product/order_product_cubit.dart';

class OrderProductController extends BaseController with Repository {
  OrderProductController(super.context);
  
  List<Data> _list = [];
  Widget errorWidget = const SizedBox();
  int page = 1;

  @override
  void onInitState() {
    final listData = context.read<OrderProductCubit>().state;
    if(listData.isEmpty) onGetListOrderProduct(true);
    if(listData.length < 10) isMoreEnable = false;
    setEnableScrollController = true;
    super.onInitState();
  }

  @override
  void onLoadMore() {
    page ++;
    onGetListOrderProduct(false);
    super.onLoadMore();
  }

  ReqListOrderProduct get _request => ReqListOrderProduct(
    page: page
  );

  Future<void> onGetListOrderProduct(bool isLoad) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listOrderProductAPI(_request);
    if(response is Success<ModelListOrderProduct>) {
      if(response.value.code == Result.isOk) {
        _onGetListOrderSuccess(response.value.data ?? []);
      } else {
        setScreenState = screenStateError;
        errorWidget = Utilities.errorMesWidget("Không thể lấy danh sách đơn sản phẩm");
      }
    }
    if(response is Failure<ModelListOrderProduct>) {
      setScreenState = screenStateError;
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void _onGetListOrderSuccess(List<Data> response) {
    _list = List.from(context.read<OrderProductCubit>().state);
    if(page == 1) _list = [];
    _list.addAll(response);
    if (_list.isEmpty || response.length < 10) {
      isMoreEnable = false;
    } else {
      isMoreEnable = true;
    }
    setScreenState = screenStateOk;
    context.read<OrderProductCubit>().onGetList(_list);
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    page = 1;
    isMoreEnable = true;
    await onGetListOrderProduct(false);
  }
}
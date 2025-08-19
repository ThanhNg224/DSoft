import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_prepaid_card.dart';
import 'package:spa_project/view/order/order_prepaid_card/order_prepaid_card_cubit.dart';

class OrderPrepaidCardController extends BaseController with Repository {
  OrderPrepaidCardController(super.context);

  Widget errorWidget = const SizedBox();
  List<Data> _list = [];
  int page = 1;

  @override
  void onInitState() {
    final listData = context.read<OrderPrepaidCardCubit>().state;
    if(listData.isEmpty) onGetListOrderPrepaidCard();
    if(listData.length < 10) isMoreEnable = false;
    setEnableScrollController = true;
    super.onInitState();
  }

  Future<void> onGetListOrderPrepaidCard({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listCustomerCardAPI();
    if(response is Success<ModelOrderPrepaidCard>) {
      if(response.value.code == Result.isOk) {
        _onGetListOrderSuccess(response.value.data ?? []);
      } else {
        setScreenState = screenStateError;
        errorWidget = Utilities.errorMesWidget("Không thể lấy danh sách đơn sản phẩm");
      }
    }
    if(response is Failure<ModelOrderPrepaidCard>) {
      setScreenState = screenStateError;
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void _onGetListOrderSuccess(List<Data> response) {
    _list = List.from(context.read<OrderPrepaidCardCubit>().state);
    if(page == 1) _list = [];
    _list.addAll(response);
    if (_list.isEmpty || response.length < 10) {
      isMoreEnable = false;
    } else {
      isMoreEnable = true;
    }
    setScreenState = screenStateOk;
    context.read<OrderPrepaidCardCubit>().onGetList(_list);
  }

  @override
  void onLoadMore() {
    page ++;
    onGetListOrderPrepaidCard(isLoad: false);
    super.onLoadMore();
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    page = 1;
    isMoreEnable = true;
    await onGetListOrderPrepaidCard(isLoad: false);
  }
}
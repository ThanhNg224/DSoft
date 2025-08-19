import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_combo.dart';
import 'package:spa_project/view/order/order_treatment/order_treatment_cubit.dart';

class OrderTreatmentController extends BaseController with Repository {
  OrderTreatmentController(super.context);

  Widget errorWidget = const SizedBox();
  int page = 1;
  List<Data> _list = [];

  @override
  void onInitState() {
    final listData = onTriggerEvent<OrderTreatmentCubit>().state;
    if(listData.isEmpty) onGetListOrderCombo();
    if(listData.length < 10) isMoreEnable = false;
    setEnableScrollController = true;
    super.onInitState();
  }

  @override
  void onLoadMore() {
    page ++;
    onGetListOrderCombo(isLoad: false);
    super.onLoadMore();
  }

  Future<void> onGetListOrderCombo({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listOrderComboAPI(page);
    if(response is Success<ModelOrderCombo>) {
      if(response.value.code == Result.isOk) {
        _onGetListOrderSuccess(response.value.data ?? []);
      } else {
        setScreenState = screenStateError;
        errorWidget = Utilities.errorMesWidget("Không thể lấy danh sách đơn sản phẩm");
      }
    }
    if(response is Failure<ModelOrderCombo>) {
      setScreenState = screenStateError;
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void _onGetListOrderSuccess(List<Data> response) {
    _list = List.from(onTriggerEvent<OrderTreatmentCubit>().state);
    if(page == 1) _list = [];
    _list.addAll(response);
    if (_list.isEmpty || response.length < 10) {
      isMoreEnable = false;
    } else {
      isMoreEnable = true;
    }
    setScreenState = screenStateOk;
    onTriggerEvent<OrderTreatmentCubit>().onGetListOrderCombo(_list);
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    page = 1;
    isMoreEnable = true;
    await onGetListOrderCombo(isLoad: false);
  }
}
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_warehouse_history.dart';
import 'package:spa_project/model/response/model_warehouse_history.dart';
import 'package:spa_project/view/warehouse_history/warehouse_history_cubit.dart';

class WarehouseHistoryController extends BaseController<int> with Repository {
  WarehouseHistoryController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => onGetWarehouseHistory());
    super.onInitState();
  }

  void onGetWarehouseHistory({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await importHistorytWarehouseAPI(ReqWarehouseHistory(page: 1, idWarehouse: args));
    if(response is Success<ModelWarehouseHistory>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<WarehouseHistoryCubit>()
          .getListWarehouseHistoryCubit(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được lịch sợ nhập kho");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelWarehouseHistory>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  String priceTotal(List<Product> produce) {
    if(produce.isEmpty) return 0.toCurrency(suffix: "đ");
    int price = produce.fold<int>(0, (previousValue, item) {
      final quantity = item.quantity ?? 0;
      return previousValue + ((item.imporPrice ?? 0) * quantity);
    });
    return price.toCurrency(suffix: "đ");
  }
}
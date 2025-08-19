import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_list_collect_bill.dart';
import 'package:spa_project/model/response/model_list_collect_bill.dart';
import 'package:spa_project/view/debt_management/debt_management_cubit.dart';

class BillCollectController extends BaseController with Repository {
  BillCollectController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    final list = onTriggerEvent<DebtManagementCubit>().state.listCollectBill;
    if(list.isEmpty) onGetBillCollect();
    super.onInitState();
  }

  void onGetBillCollect({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listCollectionBillAPI(ReqListCollectBill(
      page: 1,
    ));
    if(response is Success<ModelListCollectBill>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<DebtManagementCubit>().getCollectBill(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelListCollectBill>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

}
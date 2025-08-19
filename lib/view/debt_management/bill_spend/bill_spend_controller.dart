import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_list_collect_bill.dart';
import 'package:spa_project/model/response/model_list_spend_bill.dart';
import 'package:spa_project/view/debt_management/debt_management_cubit.dart';

class BillSpendController extends BaseController with Repository {
  BillSpendController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    final list = onTriggerEvent<DebtManagementCubit>().state.listSpendBill;
    if(list.isEmpty) onGetBillSpend();
    super.onInitState();
  }

  void onGetBillSpend({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listBillAPI(ReqListCollectBill(
      page: 1,
    ));
    if(response is Success<ModelListSpendBill>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<DebtManagementCubit>().getSpendBill(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelListSpendBill>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
}
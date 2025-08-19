import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_debt_collection.dart';
import 'package:spa_project/model/response/model_debt_collection.dart';
import 'package:spa_project/view/debt_management/debt_management_cubit.dart';

class DebtPaidController extends BaseController with Repository {
  DebtPaidController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    final list = onTriggerEvent<DebtManagementCubit>().state.listDebtPaid;
    if(list.isEmpty) onGetListPaid();
    super.onInitState();
  }

  void onGetListPaid({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listPayableDebtAPI(ReqDebtCollection(page: 1));
    if(response is Success<ModelDebtCollection>) {
      if(response.value.code == Result.isOk) {
        setScreenState = screenStateOk;
        onTriggerEvent<DebtManagementCubit>().getDebtPaid(response.value.data ?? []);
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được danh sách cơ nợ phải trả");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelDebtCollection>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
}
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_debt_collection.dart';
import 'package:spa_project/model/response/model_debt_collection.dart';
import 'package:spa_project/view/debt_management/debt_management_cubit.dart';

class DebtCollectionController extends BaseController with Repository {
  DebtCollectionController(super.context);

  final int _page = 1;
  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    final list = onTriggerEvent<DebtManagementCubit>().state.listDebtCollection;
    if(list.isEmpty) onGetDebtCollection();
    super.onInitState();
  }

  void onGetDebtCollection({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listCollectionDebtAPI(ReqDebtCollection(page: _page));
    if(response is Success<ModelDebtCollection>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<DebtManagementCubit>().getDebtCollection(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelDebtCollection>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
}
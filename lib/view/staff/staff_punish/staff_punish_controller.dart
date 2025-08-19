import 'package:spa_project/base_project/package.dart';

import '../../../model/request/req_staff_bonus.dart';
import '../../../model/response/model_staff_bonus.dart';
import '../bloc/staff_bloc.dart';
import '../staff_controller.dart';

class StaffPunishController extends BaseController with Repository {
  StaffPunishController(super.context);

  Widget errorWidget = const SizedBox();
  final staffController = findController<StaffController>();

  @override
  void onInitState() {
    final list = staffController.onTriggerEvent<StaffBloc>().state.listPunish;
    if(list.isEmpty) onGetListPunish();
    super.onInitState();
  }

  void onGetListPunish({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listStaffBonusAPI(ReqStaffBonus(
        page: 1,
        type: "punish"
    ));
    if(response is Success<ModelStaffBonus>) {
      if(response.value.code == Result.isOk) {
        staffController.onTriggerEvent<StaffBloc>().add(GetPunishStaffEvent(response.value.data ?? []));
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelStaffBonus>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
}
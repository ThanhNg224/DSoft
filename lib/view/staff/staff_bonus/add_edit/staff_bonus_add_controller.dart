import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_add_bonus_punish.dart';
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/view/staff/staff_bonus/add_edit/staff_bonus_add_cubit.dart';
import 'package:spa_project/view/staff/staff_controller.dart';


class StaffBonusAddController extends BaseController<ModelToBonusOrPunish> with Repository {
  StaffBonusAddController(super.context);

  final ServiceDateTimePicker dateTimePicker = ServiceDateTimePicker();
  TextEditingController cMoney =  TextEditingController();
  TextEditingController cNote =  TextEditingController();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isBonus = args?.isBonus ?? true;
      final hasModel = args?.model != null;
      String title;
      if (isBonus && !hasModel) {
        title = "Tạo thưởng nhân viên";
      } else if (!isBonus && !hasModel) {
        title = "Phạt nhân viên";
      } else if (isBonus && hasModel) {
        title = "Thông tin thưởng nhân viên";
      } else {
        title = "Thông tin phạt nhân viên";
      }

      onTriggerEvent<StaffBonusAddCubit>().setTitleStaffBonus(title);
      if (!hasModel) return;
      onTriggerEvent<StaffBonusAddCubit>().setDateTimeStaffBonus(
        args!.model!.createdAt?.toDateTime ?? DateTime.now(),
      );
      onTriggerEvent<StaffBonusAddCubit>().choseStaffBonus(
        staff.Data(
          id: args?.model?.idStaff,
          name: args?.model?.infoStaff?.name,
        ),
      );
      cMoney = TextEditingController(text: args?.model?.money?.toCurrency());
      cNote = TextEditingController(text: args?.model?.note);
    });

    super.onInitState();
  }


  void onOpenSelectDateTime(StaffBonusAddState state) async {
    DateTime? initTime = args?.model?.createdAt?.toDateTime;
    final time = await dateTimePicker.open(context, initTime: initTime);
    state.dateTimeValue = time;
  }

  void onUpdate(StaffBonusAddState state) async {
    if(state.choseStaff.id == null) return warningSnackBar(message: "Vui lòng chọn nhân viên thêm thưởng");
    if(cMoney.text.isEmpty) return warningSnackBar(message: "Vui lòng nhập tiền thưởng");
    loadingFullScreen();
    final response = await addStaffBonusAPI(ReqAddBonusPunish(
      idStaff: state.choseStaff.id,
      createdAt: state.dateTimeValue.formatDateTime(),
      money: cMoney.text.removeCommaMoney,
      note: cNote.text,
      type: args?.isBonus == true ? "bonus" : "punish",
      id: args?.model?.id
    ));
    hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        pop(response.value);
      } else {
        errorSnackBar(message: "Thêm thưởng nhân viên ${state.choseStaff.name ?? ""} Không thành công");
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }

  @override
  void onDispose() {
    cMoney.dispose();
    cNote.dispose();
    super.onDispose();
  }
}
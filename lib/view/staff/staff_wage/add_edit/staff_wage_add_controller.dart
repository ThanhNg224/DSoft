import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_add_pay_roll.dart';
import 'package:spa_project/model/request/req_agency.dart';
import 'package:spa_project/model/request/req_get_list_staff.dart';
import 'package:spa_project/model/request/req_staff_bonus.dart';
import 'package:spa_project/model/request/req_time_sheet.dart';
import 'package:spa_project/model/response/model_list_agency.dart';
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/model/response/model_staff_bonus.dart';
import 'package:spa_project/model/response/model_time_sheet.dart';
import 'package:spa_project/view/staff/staff_wage/add_edit/staff_wage_add_cubit.dart';
import 'package:spa_project/view/staff/staff_wage/staff_wage_controller.dart';

class StaffWageAddController extends BaseController with Repository {
  StaffWageAddController(super.context);

  final ServiceDateTimePicker dateTimePicker = ServiceDateTimePicker();
  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadingFullScreen();
      await onGetListStaff();
      hideLoading();
    });
    final dayWage = onTriggerEvent<StaffWageAddCubit>().state.dayWage;
    final day = DateTime(dayWage.year, dayWage.month + 1, 0);
    onTriggerEvent<StaffWageAddCubit>().changeDayStaffWageAdd(day);
    super.onInitState();
  }

  Future<void> onGetListStaff() async {
    setScreenState = screenStateLoading;
    final response = await listStaffAPI(ReqGetListStaff());
    if(response is Success<staff.ModelListStaff>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<StaffWageAddCubit>().getListStaffWageAdd(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Đã có lỗi xảy ra");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<staff.ModelListStaff>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void onChoseDate() async {
    final date = await dateTimePicker.open(context,
      type: TypeDateTime.monthYear,
      initTime: onTriggerEvent<StaffWageAddCubit>().state.dateTimeValue
    );
    onTriggerEvent<StaffWageAddCubit>().changeDateTimeStaffWageAdd(date);
    onGetMulti();
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    onTriggerEvent<StaffWageAddCubit>().changeDayStaffWageAdd(lastDayOfMonth);
  }

  void onChoseDay() async {
    final date = await dateTimePicker.open(context,
      type: TypeDateTime.onlyDay,
      initTime: onTriggerEvent<StaffWageAddCubit>().state.dayWage,
    );
    onTriggerEvent<StaffWageAddCubit>().changeDayStaffWageAdd(date);
  }

  void onSalaryCalculation(StaffWageAddState state) async {
    loadingFullScreen();
    final response = await addPayrollAPI(ReqAddPayroll(
      idStaff: state.choseStaff.id,
      fixedSalary: state.choseStaff.fixedSalary,
      allowance: state.choseStaff.allowance,
      insurance: state.choseStaff.insurance,
      month: state.dateTimeValue.month,
      year: state.dateTimeValue.year,
      bonus: state.listBonus.fold(0, (sum, item) => (sum ?? 0) + (item.money ?? 0)),
      punish: state.listPunish.fold(0, (sum, item) => (sum ?? 0) + (item.money ?? 0)),
      commission: state.listAgency.fold(0, (sum, item) => (sum ?? 0) + (item.money ?? 0)),
      salary: totalPricePay(state).toInt(),
      totalDay: state.dayWage.day,
      workingDay: state.listTimeSheet.length,
    ));
    hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        pop(response.value);
        findController<StaffWageController>().onGetListPayRoll(isLoad: false);
        successSnackBar(message: "Bạn vừa tính lương cho ${state.choseStaff.name} thành công");
      } else {
        errorSnackBar(message: "Tính lương thất bại");
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }

  Future<ExceptionMultiApi> onGetListBonus() async {
    final state = onTriggerEvent<StaffWageAddCubit>().state;
    final selectedDate = state.dateTimeValue;
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    final response = await listStaffBonusAPI(ReqStaffBonus(
      page: 1,
      type: "bonus",
      idStaff: state.choseStaff.id,
      status: "new",
      dateStart: firstDayOfMonth.formatDateTime(format: "dd/MM/yyyy"),
      dateEnd: lastDayOfMonth.formatDateTime(format: "dd/MM/yyyy"),
    ));
    if(response is Success<ModelStaffBonus>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<StaffWageAddCubit>().getBonusStaffWageAdd(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không thể lấy được dữ liệu"));
      }
    }
    if(response is Failure<ModelStaffBonus>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  Future<ExceptionMultiApi> onGetListPunish() async {
    final state = onTriggerEvent<StaffWageAddCubit>().state;
    final selectedDate = state.dateTimeValue;
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    final response = await listStaffBonusAPI(ReqStaffBonus(
      page: 1,
      type: "punish",
      idStaff: state.choseStaff.id,
      status: "new",
      dateStart: firstDayOfMonth.formatDateTime(format: "dd/MM/yyyy"),
      dateEnd: lastDayOfMonth.formatDateTime(format: "dd/MM/yyyy"),
    ));
    if(response is Success<ModelStaffBonus>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<StaffWageAddCubit>().getPunishStaffWageAdd(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không thể lấy được dữ liệu"));
      }
    }
    if(response is Failure<ModelStaffBonus>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  Future<ExceptionMultiApi> onGetListCommission() async {
    final state = onTriggerEvent<StaffWageAddCubit>().state;
    final selectedDate = state.dateTimeValue;
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    final response = await listAgencyAPI(ReqAgency(
      page: 1,
      idStaff: state.choseStaff.id,
      status: 0, //Chưa thanh toán
      dateStart: firstDayOfMonth.formatDateTime(format: "dd/MM/yyyy"),
      dateEnd: lastDayOfMonth.formatDateTime(format: "dd/MM/yyyy"),
    ));
    if(response is Success<ModelListAgency>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<StaffWageAddCubit>().getAgencyStaffWageAdd(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không thể lấy được dữ liệu"));
      }
    }
    if(response is Failure<ModelListAgency>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  Future<ExceptionMultiApi> onGetListTimesheet() async {
    final state = onTriggerEvent<StaffWageAddCubit>().state;
    final selectedDate = state.dateTimeValue;
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    final response = await listTimesheetAPI(ReqTimesheet(
      page: 1,
      idStaff: state.choseStaff.id,
      dateStart: firstDayOfMonth.formatDateTime(format: "dd/MM/yyyy"),
      dateEnd: lastDayOfMonth.formatDateTime(format: "dd/MM/yyyy"),
      status: "new"
    ));
    if(response is Success<ModelTimeSheet>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<StaffWageAddCubit>().getTimesheetStaffWageAdd(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không thể lấy được dữ liệu"));
      }
    }
    if(response is Failure<ModelTimeSheet>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  void onGetMulti() async {
    loadingFullScreen();
    final listException = await Future.wait([
      onGetListBonus(),
      onGetListPunish(),
      onGetListCommission(),
      onGetListTimesheet()
    ]);
    hideLoading();
    for(var item in listException) {
      if(!item.isNotError) {
        errorWidget = item.logo;
        setScreenState = screenStateError;
        return;
      }
    }
    setScreenState = screenStateOk;
    final state = onTriggerEvent<StaffWageAddCubit>().state;
    final totalBonus = state.listBonus.fold<int>(0, (sum, e) => sum + (e.money ?? 0));
    final totalPunish = state.listPunish.fold<int>(0, (sum, e) => sum + (e.money ?? 0));
    final totalCommission = state.listAgency.fold<int>(0, (sum, e) => sum + (e.money ?? 0));
    final listAll = [totalBonus, totalPunish, totalCommission];
    onTriggerEvent<StaffWageAddCubit>().changeCheckBonusPunishStaffWageAdd(listAll);
  }

  void checkBoxBonusPunish(int price) {
    List<int> list = List.from(onTriggerEvent<StaffWageAddCubit>().state.listCheckBonusPunish);
    if(list.contains(price)) {
      list.remove(price);
    } else {
      list.add(price);
    }
    onTriggerEvent<StaffWageAddCubit>().changeCheckBonusPunishStaffWageAdd(list);
  }

  double totalPricePay(StaffWageAddState state) {

    final fixedSalary = state.choseStaff.fixedSalary ?? 0;
    final workday = state.dayWage.day;
    final realDay = state.listTimeSheet.length;
    final allowance = state.choseStaff.allowance ?? 0;
    final insurance = state.choseStaff.insurance ?? 0;

    final commission = state.listAgency.fold(0, (sum, item) => sum + (item.money ?? 0));
    final bonus = state.listBonus.fold(0, (sum, item) => sum + (item.money ?? 0));
    final punish = state.listPunish.fold(0, (sum, item) => sum + (item.money ?? 0));

    final realCommission = state.listCheckBonusPunish.contains(commission) ? commission : 0;
    final realBonus = state.listCheckBonusPunish.contains(bonus) ? bonus : 0;
    final realPunish = state.listCheckBonusPunish.contains(punish) ? punish : 0;

    return ((fixedSalary / workday ) * realDay)
        + (realCommission + realBonus + allowance) - (realPunish + insurance);
  }
}
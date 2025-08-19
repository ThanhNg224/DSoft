import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_group_staff.dart' as group;
import 'package:spa_project/model/response/model_list_pay_roll.dart' as list_payroll;
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/model/response/model_staff_bonus.dart' as bonus;
import 'package:spa_project/model/response/model_time_sheet.dart' as time;

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc() : super(InitStaffState(timekeepingDay: DateTime.now())) {
    on<ChosePageViewStaffEvent>((event, emit) {
      emit(state.copyWith(indexPage: event.indexPage));
    });
    on<GetListStaffEvent>((event, emit) {
      emit(state.copyWith(listStaff: event.listStaff));
    });
    on<GetGroupStaffEvent>((event, emit) {
      emit(state.copyWith(listGroup: event.listGroup));
    });
    on<SetValidateStaffEvent>((event, emit) {
      emit(state.copyWith(vaNameStaff: event.vaName));
    });
    on<SetLoadingSearchStaffEvent>((event, emit) {
      emit(state.copyWith(isLoadingSearch: event.loading));
    });
    on<GetBonusStaffEvent>((event, emit) {
      emit(state.copyWith(listBonus: event.listBonus));
    });
    on<GetPunishStaffEvent>((event, emit) {
      emit(state.copyWith(listPunish: event.listPunish));
    });
    on<GetTimeSheetStaffEvent>((event, emit) {
      emit(state.copyWith(listTimeSheet: event.listTimeSheet));
    });
    on<SetStaffTimeSheetStaffEvent>((event, emit) {
      emit(state.copyWith(choseStaffTimeSheet: event.choseStaffTimeSheet));
    });
    on<SetTimekeepingDayStaffEvent>((event, emit) {
      emit(state.copyWith(timekeepingDay: event.timekeepingDay));
    });
    on<SetListDailySessionsStaffEvent>((event, emit) {
      emit(state.copyWith(listDailySessions: event.listDailySessions));
    });
    on<SetVaNameStaffTimeSheetStaffEvent>((event, emit) {
      emit(state.copyWith(vaNameStaffTimeSheet: event.vaNameStaffTimeSheet));
    });
    on<GetListPayRollStaffEvent>((event, emit) {
      emit(state.copyWith(listPayroll: event.listPayRoll));
    });
    on<SetChoseGroupStaffEvent>((event, emit) {
      Object? result;
      event.choseGroup == state.choseGroup
        ? result = null
        : result = event.choseGroup;
      emit(state.copyWith(choseGroup: result));
    });
    on<SetChosePaymentMethodStaffEvent>((event, emit) {
      emit(state.copyWith(chosePaymentMethod: event.chosePaymentMethod));
    });
    on<SetVaPaymentMethodStaffEvent>((event, emit) {
      emit(state.copyWith(vaPaymentMethod: event.vaPaymentMethod));
    });
  }
}
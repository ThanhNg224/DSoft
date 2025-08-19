import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_agency.dart' as agency;
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/model/response/model_staff_bonus.dart' as bonus;
import 'package:spa_project/model/response/model_time_sheet.dart' as time_sheet;

import 'staff_wage_add_controller.dart';

class StaffWageAddCubit extends Cubit<StaffWageAddState> {
  StaffWageAddCubit() : super(StaffWageAddState(
    dateTimeValue: DateTime.now(),
    dayWage: DateTime.now(),
    choseStaff: staff.Data(
      name: findController<StaffWageAddController>().os.modelMyInfo?.data?.name,
      id: findController<StaffWageAddController>().os.modelMyInfo?.data?.id
    )
  ));

  void changeDateTimeStaffWageAdd(DateTime dateTime)
  => emit(state.copyWith(dateTimeValue: dateTime));

  void getListStaffWageAdd(List<staff.Data> staff)
  => emit(state.copyWith(listStaff: staff));

  void getBonusStaffWageAdd(List<bonus.Data> bonus)
  => emit(state.copyWith(listBonus: bonus));

  void getPunishStaffWageAdd(List<bonus.Data> punish)
  => emit(state.copyWith(listPunish: punish));

  void getAgencyStaffWageAdd(List<agency.Data> agency)
  => emit(state.copyWith(listAgency: agency));

  void changeDayStaffWageAdd(DateTime day)
  => emit(state.copyWith(dayWage: day));

  void changeCheckBonusPunishStaffWageAdd(List<int> value)
  => emit(state.copyWith(listCheckBonusPunish: value));

  void getTimesheetStaffWageAdd(List<time_sheet.Data> timesheet)
  => emit(state.copyWith(listTimeSheet: timesheet));
}

class StaffWageAddState {
  DateTime dateTimeValue;
  DateTime dayWage;
  staff.Data choseStaff;
  List<staff.Data> listStaff = [];
  List<bonus.Data> listBonus = [];
  List<bonus.Data> listPunish = [];
  List<agency.Data> listAgency = [];
  List<time_sheet.Data> listTimeSheet = [];
  List<int> listCheckBonusPunish = [];

  StaffWageAddState({
    required this.dateTimeValue,
    required this.dayWage,
    required this.choseStaff,
    this.listStaff = const [],
    this.listBonus = const [],
    this.listPunish = const [],
    this.listAgency = const [],
    this.listCheckBonusPunish = const [],
    this.listTimeSheet = const [],
  });

  StaffWageAddState copyWith({
    DateTime? dateTimeValue,
    staff.Data? choseStaff,
    List<staff.Data>? listStaff,
    List<bonus.Data>? listBonus,
    List<bonus.Data>? listPunish,
    List<agency.Data>? listAgency,
    DateTime? dayWage,
    List<int>? listCheckBonusPunish,
    List<time_sheet.Data>? listTimeSheet,
  }) => StaffWageAddState(
    dateTimeValue: dateTimeValue ?? this.dateTimeValue,
    choseStaff: choseStaff ?? this.choseStaff,
    listStaff: listStaff ?? this.listStaff,
    listBonus: listBonus ?? this.listBonus,
    listPunish: listPunish ?? this.listPunish,
    listAgency: listAgency ?? this.listAgency,
    dayWage: dayWage ?? this.dayWage,
    listCheckBonusPunish: listCheckBonusPunish ?? this.listCheckBonusPunish,
    listTimeSheet: listTimeSheet ?? this.listTimeSheet,
  );
}
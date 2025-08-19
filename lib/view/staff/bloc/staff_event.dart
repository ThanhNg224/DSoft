part of 'staff_bloc.dart';

class StaffEvent {}

class InitStaffEvent extends StaffEvent {}

class ChosePageViewStaffEvent extends StaffEvent {
  int? indexPage;
  ChosePageViewStaffEvent(this.indexPage);
}

class GetListStaffEvent extends StaffEvent {
  List<staff.Data>? listStaff;
  GetListStaffEvent(this.listStaff);
}

class GetGroupStaffEvent extends StaffEvent {
  List<group.Data>? listGroup;
  GetGroupStaffEvent(this.listGroup);
}

class SetLoadingSearchStaffEvent extends StaffEvent {
  bool? loading;
  SetLoadingSearchStaffEvent(this.loading);
}

class SetValidateStaffEvent extends StaffEvent {
  String? vaName;
  SetValidateStaffEvent(this.vaName);
}

class GetBonusStaffEvent extends StaffEvent {
  List<bonus.Data>? listBonus;
  GetBonusStaffEvent(this.listBonus);
}

class GetPunishStaffEvent extends StaffEvent {
  List<bonus.Data>? listPunish;
  GetPunishStaffEvent(this.listPunish);
}

class GetTimeSheetStaffEvent extends StaffEvent {
  List<time.Data>? listTimeSheet;
  GetTimeSheetStaffEvent(this.listTimeSheet);
}

class SetStaffTimeSheetStaffEvent extends StaffEvent {
  staff.Data? choseStaffTimeSheet;
  SetStaffTimeSheetStaffEvent(this.choseStaffTimeSheet);
}

class SetTimekeepingDayStaffEvent extends StaffEvent {
  DateTime? timekeepingDay;
  SetTimekeepingDayStaffEvent(this.timekeepingDay);
}

class SetListDailySessionsStaffEvent extends StaffEvent {
  List<String>? listDailySessions;
  SetListDailySessionsStaffEvent(this.listDailySessions);
}

class SetVaNameStaffTimeSheetStaffEvent extends StaffEvent {
  String? vaNameStaffTimeSheet;
  SetVaNameStaffTimeSheetStaffEvent(this.vaNameStaffTimeSheet);
}

class GetListPayRollStaffEvent extends StaffEvent {
  List<list_payroll.Data>? listPayRoll;
  GetListPayRollStaffEvent(this.listPayRoll);
}

class SetChoseGroupStaffEvent extends StaffEvent {
  group.Data? choseGroup;
  SetChoseGroupStaffEvent(this.choseGroup);
}

class SetChosePaymentMethodStaffEvent extends StaffEvent {
  ModelPaymentMethod? chosePaymentMethod;
  SetChosePaymentMethodStaffEvent(this.chosePaymentMethod);
}

class SetVaPaymentMethodStaffEvent extends StaffEvent {
  String? vaPaymentMethod;
  SetVaPaymentMethodStaffEvent(this.vaPaymentMethod);
}



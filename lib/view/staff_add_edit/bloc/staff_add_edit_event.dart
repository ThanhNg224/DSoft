part of 'staff_add_edit_bloc.dart';

class StaffAddEditEvent {}

class ChoseImageStaffAddEditEvent extends StaffAddEditEvent {
  String? image;
  ChoseImageStaffAddEditEvent(this.image);
}

class GetListPermissionStaffAddEditEvent extends StaffAddEditEvent {
  List<permission.Data>? listPermission;
  GetListPermissionStaffAddEditEvent(this.listPermission);
}

class GetGroupStaffAddEditEvent extends StaffAddEditEvent {
  List<group.Data>? listGroup;
  GetGroupStaffAddEditEvent(this.listGroup);
}

class ChangeStatusAccountStaffAddEditEvent extends StaffAddEditEvent {}

class ChangeTabPermissionStaffAddEditEvent extends StaffAddEditEvent {
  int? index;
  ChangeTabPermissionStaffAddEditEvent(this.index);
}

class GetListBankStaffAddEditEvent extends StaffAddEditEvent {
  List<ModelListBanking>? listBank;
  GetListBankStaffAddEditEvent(this.listBank);
}

class ChosePermissionStaffAddEditEvent extends StaffAddEditEvent {
  List<permission.Sub>? selectedPermissionsByGroup;
  ChosePermissionStaffAddEditEvent(this.selectedPermissionsByGroup);
}

class ChoseGroupStaffAddEditEvent extends StaffAddEditEvent {
  group.Data? itemChoseGroup;
  ChoseGroupStaffAddEditEvent(this.itemChoseGroup);
}

class ChoseBankStaffAddEditEvent extends StaffAddEditEvent {
  ModelListBanking? valueBankChose;
  ChoseBankStaffAddEditEvent(this.valueBankChose);
}

class SetTitleScreenStaffAddEditEvent extends StaffAddEditEvent {
  String? appbar;
  String? button;
  SetTitleScreenStaffAddEditEvent({this.appbar, this.button});
}

class SetValidateStaffAddEditEvent extends StaffAddEditEvent {
  String? vaName;
  String? vaPhone;
  String? vaPass;
  String? vaFixedSalary;
  String? vaInsurance;
  String? vaAllowance;
  String? vaAccountBank;
  String? vaCodeBank;
  String? vaIdCard;
  SetValidateStaffAddEditEvent({
    this.vaName,
    this.vaPass,
    this.vaPhone,
    this.vaInsurance,
    this.vaFixedSalary,
    this.vaAccountBank,
    this.vaAllowance,
    this.vaCodeBank,
    this.vaIdCard
  });
}

class SetBirthdayStaffAddEditEvent extends StaffAddEditEvent {
  String? valueBirthday;
  SetBirthdayStaffAddEditEvent(this.valueBirthday);
}
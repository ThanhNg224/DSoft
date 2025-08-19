part of 'staff_add_edit_bloc.dart';

class StaffAddEditState {
  String imageFile;
  List<permission.Data> listPermission;
  List<group.Data> listGroup;
  List<ModelListBanking> listBank;
  int statusAccount;
  int indexPermissionTab;
  String titleAppbar, titleButton;
  String vaName, vaPhone, vaPass;
  String vaFixedSalary;
  String vaInsurance;
  String vaAllowance;
  String vaAccountBank;
  String vaCodeBank;
  String vaIdCard;
  String valueBirthday;
  group.Data? itemChoseGroup;
  ModelListBanking? valueBankChose;
  List<permission.Sub> selectedPermissionsByGroup;

  StaffAddEditState({
    this.imageFile = "",
    this.listPermission = const [],
    this.listGroup = const [],
    this.listBank = const [],
    this.vaFixedSalary = "",
    this.vaInsurance = "",
    this.valueBirthday = "",
    this.vaAllowance = "",
    this.itemChoseGroup,
    this.vaAccountBank = "",
    this.valueBankChose,
    this.vaCodeBank = "",
    this.selectedPermissionsByGroup = const [],
    this.vaIdCard = "",
    this.statusAccount = 1,
    this.vaPass = "",
    this.vaPhone = "",
    this.vaName = "",
    this.indexPermissionTab = 0,
    this.titleAppbar = "Thêm mới nhân viên",
    this.titleButton = "Thêm nhân viên"
  });

  StaffAddEditState copyWith({
    String? imageFile,
    ModelListBanking? valueBankChose,
    List<permission.Data>? listPermission,
    int? statusAccount,
    List<permission.Sub>? selectedPermissionsByGroup,
    int? indexPermissionTab,
    String? titleAppbar,
    String? titleButton,
    String? vaName,
    group.Data? itemChoseGroup,
    String? vaPass,
    String? valueBirthday,
    String? vaFixedSalary,
    String? vaInsurance,
    String? vaAllowance,
    String? vaAccountBank,
    String? vaCodeBank,
    String? vaIdCard,
    List<ModelListBanking>? listBank,
    List<group.Data>? listGroup,
    String? vaPhone,
  }) => StaffAddEditState(
    imageFile: imageFile ?? this.imageFile,
    listPermission: listPermission ?? this.listPermission,
    statusAccount: statusAccount ?? this.statusAccount,
    indexPermissionTab: indexPermissionTab ?? this.indexPermissionTab,
    titleAppbar: titleAppbar ?? this.titleAppbar,
    titleButton: titleButton ?? this.titleButton,
    vaPhone: vaPhone ?? this.vaPhone,
    vaPass: vaPass ?? this.vaPass,
    listBank: listBank ?? this.listBank,
    selectedPermissionsByGroup: selectedPermissionsByGroup ?? this.selectedPermissionsByGroup,
    vaName: vaName ?? this.vaName,
    valueBirthday: valueBirthday ?? this.valueBirthday,
    listGroup: listGroup ?? this.listGroup,
    vaFixedSalary: vaFixedSalary ?? this.vaFixedSalary,
    vaInsurance: vaInsurance ?? this.vaInsurance,
    vaAllowance: vaAllowance ?? this.vaAllowance,
    vaAccountBank: vaAccountBank ?? this.vaAccountBank,
    vaCodeBank: vaCodeBank ?? this.vaCodeBank,
    vaIdCard: vaIdCard ?? this.vaIdCard,
    itemChoseGroup: itemChoseGroup ?? this.itemChoseGroup,
    valueBankChose: valueBankChose ?? this.valueBankChose,
  );
}

class InitStaffAddEditState extends StaffAddEditState {}
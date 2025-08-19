part of 'staff_bloc.dart';

class StaffState {
  int indexPage;
  List<staff.Data> listStaff;
  List<group.Data> listGroup;
  List<bonus.Data> listBonus;
  List<bonus.Data> listPunish;
  List<time.Data> listTimeSheet;
  List<list_payroll.Data> listPayroll;
  String? vaNameStaff;
  String vaNameStaffTimeSheet;
  bool isLoadingSearch;
  DateTime timekeepingDay;
  staff.Data? choseStaffTimeSheet;
  List<String> listDailySessions = [];
  group.Data? choseGroup;
  ModelPaymentMethod? chosePaymentMethod;
  String vaPaymentMethod;

  StaffState({
    this.indexPage = 0,
    this.listStaff = const [],
    this.vaNameStaff = "",
    this.isLoadingSearch = false,
    this.listGroup = const [],
    this.listBonus = const [],
    this.listPunish = const [],
    this.listTimeSheet = const [],
    required this.timekeepingDay,
    this.choseStaffTimeSheet,
    this.listDailySessions = const [],
    this.vaNameStaffTimeSheet = "",
    this.listPayroll = const [],
    this.choseGroup,
    this.chosePaymentMethod,
    this.vaPaymentMethod = ""
  });

  StaffState copyWith({
    int? indexPage,
    List<staff.Data>? listStaff,
    List<group.Data>? listGroup,
    bool? isLoadingSearch,
    String? vaNameStaff,
    List<bonus.Data>? listBonus,
    List<bonus.Data>? listPunish,
    List<time.Data>? listTimeSheet,
    DateTime? timekeepingDay,
    Object? choseStaffTimeSheet = _unset,
    List<String>? listDailySessions,
    String? vaNameStaffTimeSheet,
    List<list_payroll.Data>? listPayroll,
    Object? choseGroup = _unset,
    ModelPaymentMethod? chosePaymentMethod,
    String? vaPaymentMethod,
  }) => StaffState(
    indexPage: indexPage ?? this.indexPage,
    listStaff: listStaff ?? this.listStaff,
    isLoadingSearch: isLoadingSearch ?? this.isLoadingSearch,
    listGroup: listGroup ?? this.listGroup,
    vaNameStaff: vaNameStaff ?? this.vaNameStaff,
    listBonus: listBonus ?? this.listBonus,
    listPunish: listPunish ?? this.listPunish,
    listTimeSheet: listTimeSheet ?? this.listTimeSheet,
    timekeepingDay: timekeepingDay ?? this.timekeepingDay,
    choseStaffTimeSheet: choseStaffTimeSheet == _unset
        ? this.choseStaffTimeSheet
        : choseStaffTimeSheet as staff.Data?,
    listDailySessions: listDailySessions ?? this.listDailySessions,
    vaNameStaffTimeSheet: vaNameStaffTimeSheet ?? this.vaNameStaffTimeSheet,
    listPayroll: listPayroll ?? this.listPayroll,
    choseGroup: choseGroup == _unset ? this.choseGroup : choseGroup as group.Data?,
    chosePaymentMethod: chosePaymentMethod ?? this.chosePaymentMethod,
    vaPaymentMethod: vaPaymentMethod ?? this.vaPaymentMethod,
  );

  static const _unset = Object();
}

class InitStaffState extends StaffState {
  InitStaffState({required super.timekeepingDay});
}
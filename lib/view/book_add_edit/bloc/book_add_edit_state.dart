part of 'book_add_edit_bloc.dart';

class BookAddEditState {
  List<list_staff.Data> listStaff;
  List<list_bed.Data> listBed;
  List<list_service.Data> listService;
  List<cate_service.Data> listCateService;
  List<list_room.Data> listRoom;
  ModelDropDowStaff staffValue;
  ModelDropDowStatus? statusValue;
  ModelDropDowService? serviceValue;
  ModelDropDowBed? bedValue;
  bool isConsultation;
  bool isCare;
  bool isTreatmentPlan;
  bool isTherapy;
  String vaPhone;
  String vaStaff;
  String vaService;
  String vaBed;
  String vaName;
  String titleButton;
  String titleAppbar;
  DateTime dateTimeValue;

  BookAddEditState({
    this.listStaff = const [],
    this.listBed = const [],
    this.listService = const [],
    this.listCateService = const [],
    this.listRoom = const [],
    required this.staffValue,
    required this.dateTimeValue,
    this.statusValue,
    this.vaPhone = "",
    this.vaStaff = "",
    this.vaService = "",
    this.vaName = "",
    this.vaBed = "",
    this.isCare = false,
    this.isConsultation = false,
    this.isTherapy = false,
    this.isTreatmentPlan = false,
    this.bedValue,
    this.serviceValue,
    this.titleAppbar = "Đặt lịch mới",
    this.titleButton = "Đặt lịch"
  });

  BookAddEditState copyWith({
    List<list_staff.Data>? listStaff,
    List<list_bed.Data>? listBed,
    List<list_service.Data>? listService,
    ModelDropDowStaff? staffValue,
    ModelDropDowStatus? statusValue,
    bool? isConsultation,
    List<cate_service.Data>? listCateService,
    List<list_room.Data>? listRoom,
    List<list_customer.Data>? listSearch,
    bool? isCare,
    bool? isTreatmentPlan,
    bool? isTherapy,
    ModelDropDowBed? bedValue,
    ModelDropDowService? serviceValue,
    String? vaPhone,
    String? vaStaff,
    String? vaService,
    String? vaBed,
    String? vaName,
    String? titleButton,
    String? titleAppbar,
    DateTime? dateTimeValue,
  }) => BookAddEditState(
    listStaff: listStaff ?? this.listStaff,
    listBed: listBed ?? this.listBed,
    listService: listService ?? this.listService,
    staffValue: staffValue ?? this.staffValue,
    statusValue: statusValue ?? this.statusValue,
    isCare: isCare ?? this.isCare,
    isTreatmentPlan: isTreatmentPlan ?? this.isTreatmentPlan,
    isTherapy: isTherapy ?? this.isTherapy,
    isConsultation: isConsultation ?? this.isConsultation,
    listCateService: listCateService ?? this.listCateService,
    listRoom: listRoom ?? this.listRoom,
    serviceValue: serviceValue ?? this.serviceValue,
    bedValue: bedValue ?? this.bedValue,
    vaPhone: vaPhone ?? this.vaPhone,
    vaStaff: vaStaff ?? this.vaStaff,
    vaService: vaService ?? this.vaService,
    vaBed: vaBed ?? this.vaBed,
    vaName: vaName ?? this.vaName,
    titleAppbar: titleAppbar ?? this.titleAppbar,
    titleButton: titleButton ?? this.titleButton,
    dateTimeValue: dateTimeValue ?? this.dateTimeValue
  );
}

class InitBookAddEditState extends BookAddEditState {
  InitBookAddEditState(ModelDropDowStatus statusValue, DateTime dateTimeValue, ModelDropDowStaff staffValue)
      : super(statusValue: statusValue, dateTimeValue: dateTimeValue, staffValue: staffValue);
}
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_category_service.dart' as ser;

class ServiceAddEditState {
  List<ser.Data> listCate;
  int statusService;
  int commissionStaffPercent;
  int commissionAffiliatePercent;
  String vaName;
  String vaPrice;
  String vaCate;
  String titleApp;
  String? image;

  ServiceAddEditState({
    this.listCate = const [],
    this.statusService = 1,
    this.commissionStaffPercent = 0,
    this.commissionAffiliatePercent = 0,
    this.vaName = "",
    this.vaPrice = "",
    this.vaCate = "",
    this.titleApp = "Thêm dịch vụ",
    this.image,
  });

  ServiceAddEditState copyWith({
    List<ser.Data>? listCate,
    int? statusService,
    int? commissionStaffPercent,
    int? commissionAffiliatePercent,
    String? vaName,
    String? vaPrice,
    String? vaCate,
    String? titleApp,
    String? image,
  }) => ServiceAddEditState(
    listCate: listCate ?? this.listCate,
    statusService: statusService ?? this.statusService,
    commissionAffiliatePercent: commissionAffiliatePercent ?? this.commissionAffiliatePercent,
    commissionStaffPercent: commissionStaffPercent ?? this.commissionStaffPercent,
    vaName: vaName ?? this.vaName,
    vaPrice: vaPrice ?? this.vaPrice,
    vaCate: vaCate ?? this.vaCate,
    titleApp: titleApp ?? this.titleApp,
    image: image ?? this.image,
  );
}

class ServiceAddEditCubit extends Cubit<ServiceAddEditState> {
  ServiceAddEditCubit() : super(ServiceAddEditState());

  void getListCateSuccess(List<ser.Data> listCate)
  => emit(state.copyWith(listCate: listCate));

  void setTitleApp(String value)
  => emit(state.copyWith(titleApp: value));

  void changeStatusService() {
    int value = state.statusService == StatusAccountStaff.isLock
        ? StatusAccountStaff.isActive
        : StatusAccountStaff.isLock;
    emit(state.copyWith(statusService: value));
  }

  void changePercent({
    int? commissionStaffPercent,
    int? commissionAffiliatePercent,
  }) => emit(state.copyWith(
    commissionAffiliatePercent: commissionAffiliatePercent,
    commissionStaffPercent: commissionStaffPercent,
  ));

  void setValidate({
    String? vaName,
    String? vaPrice,
    String? vaCate,
  }) => emit(state.copyWith(vaName: vaName, vaCate: vaCate, vaPrice: vaPrice));

  void setImage(String? image) => emit(state.copyWith(image: image));
}
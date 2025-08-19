import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/data_product.dart';
import 'package:spa_project/model/common/data_service.dart';
import 'package:spa_project/model/response/model_list_product.dart' as product;
import 'package:spa_project/model/response/model_list_service.dart' as service;

class ComboAddEditCubit extends Cubit<ComboAddEditState> {
  ComboAddEditCubit() : super(ComboAddEditState());

  void changeStatusComboAddEdit() {
    String value = state.status == "active"
        ? "lock" : "active";
    emit(state.copyWith(status: value));
  }

  void getServiceComboAddEdit(List<service.Data>? listService)
  => emit(state.copyWith(listService: listService));

  void getProductComboAddEdit(List<product.Data>? listProduct)
  => emit(state.copyWith(listProduct: listProduct));

  void setProductComboAddEdit(List<DataProduct>? product)
  => emit(state.copyWith(dataProduct: product));

  void setServiceComboAddEdit(List<DataService>? service)
  => emit(state.copyWith(dataService: service));

  void changePercentComboAddEdit(int value)
  => emit(state.copyWith(commissionStaffPercent: value));

  void setValidatorComboAddEdit({String? vaName, String? vaPrice})
  => emit(state.copyWith(vaPrice: vaPrice, vaName: vaName));

  void setTitleComboAddEdit({String? value})
  => emit(state.copyWith(titleApp: value));
}

class ComboAddEditState {
  String status;
  List<service.Data> listService;
  List<product.Data> listProduct;
  List<DataProduct> dataProduct;
  List<DataService> dataService;
  int commissionStaffPercent;
  String vaName;
  String vaPrice;
  String titleApp;

  ComboAddEditState({
    this.status = "active",
    this.listService = const [],
    this.listProduct = const [],
    this.dataProduct = const [],
    this.dataService = const [],
    this.commissionStaffPercent = 0,
    this.vaName = "",
    this.vaPrice = "",
    this.titleApp = "Tạo combo liệu trình"
  });

  ComboAddEditState copyWith({
    String? status,
    List<service.Data>? listService,
    List<product.Data>? listProduct,
    List<DataProduct>? dataProduct,
    List<DataService>? dataService,
    int? commissionStaffPercent,
    String? vaName,
    String? vaPrice,
    String? titleApp
  }) => ComboAddEditState(
    status: status ?? this.status,
    listService: listService ?? this.listService,
    listProduct: listProduct ?? this.listProduct,
    dataProduct: dataProduct ?? this.dataProduct,
    dataService: dataService ?? this.dataService,
    commissionStaffPercent: commissionStaffPercent ?? this.commissionStaffPercent,
    vaName: vaName ?? this.vaName,
    titleApp: titleApp ?? this.titleApp,
    vaPrice: vaPrice ?? this.vaPrice
  );
}
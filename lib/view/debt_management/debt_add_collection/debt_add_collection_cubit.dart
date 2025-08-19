import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_list_staff.dart';
import 'package:spa_project/view/debt_management/debt_add_collection/debt_add_collection_controller.dart';

class DebtAddCollectionCubit extends Cubit<DebtAddCollectionState> {
  DebtAddCollectionCubit() : super(DebtAddCollectionState(
    dateTimeValue: DateTime.now(),
    chosePaymentMethod: ModelPaymentMethod.listPaymentMethod[0],
    choseStaff: Data(
      name: findController<DebtAddCollectionController>().os.modelMyInfo?.data?.name,
      id: findController<DebtAddCollectionController>().os.modelMyInfo?.data?.id
    )
  ));

  void getListStaffDebtAddCollection(List<Data> listStaff)
  => emit(state.copyWith(listStaff: listStaff));

  void setDateTimeDebtAddCollection(DateTime dateTimeValue)
  => emit(state.copyWith(dateTimeValue: dateTimeValue));

  void setChoseStaffDebtAddCollection(Data choseStaff)
  => emit(state.copyWith(choseStaff: choseStaff));

  void setVaNameDebtAddCollection({String? vaName, String? vaPrice, String? vaStaff, String? vaPricePay})
  => emit(state.copyWith(
      vaName: vaName,
      vaPrice: vaPrice,
      vaStaff: vaStaff,
      vaPricePay: vaPricePay
  ));

  void setTitleAppDebtAddCollection({String? title, String? titleButton}) => emit(state.copyWith(
    title: title,
    titleButton: titleButton
  ));

  void setChosePaymentMethod(ModelPaymentMethod chosePaymentMethod)
  => emit(state.copyWith(chosePaymentMethod: chosePaymentMethod));
}

class DebtAddCollectionState {
  List<Data> listStaff;
  DateTime dateTimeValue;
  Data choseStaff;
  String vaName;
  String vaPrice;
  String vaPricePay;
  String vaStaff;
  String title;
  String titleButton;
  ModelPaymentMethod chosePaymentMethod;

  DebtAddCollectionState({
    this.listStaff = const [],
    required this.dateTimeValue,
    required this.choseStaff,
    this.vaName = "",
    this.vaPrice = "",
    this.vaStaff = "",
    this.vaPricePay = "",
    this.title = "Tạo công nợ phải thu",
    this.titleButton = "Tạo công nợ phải thu",
    required this.chosePaymentMethod,
  });

  DebtAddCollectionState copyWith({
    List<Data>? listStaff,
    DateTime? dateTimeValue,
    Data? choseStaff,
    String? vaName,
    String? vaPrice,
    String? vaStaff,
    String? title,
    String? titleButton,
    ModelPaymentMethod? chosePaymentMethod,
    String? vaPricePay,
  }) => DebtAddCollectionState(
    listStaff: listStaff ?? this.listStaff,
    dateTimeValue: dateTimeValue ?? this.dateTimeValue,
    choseStaff: choseStaff ?? this.choseStaff,
    vaName: vaName ?? this.vaName,
    vaPrice: vaPrice ?? this.vaPrice,
    vaStaff: vaStaff ?? this.vaStaff,
    title: title ?? this.title,
    titleButton: titleButton ?? this.titleButton,
    chosePaymentMethod: chosePaymentMethod ?? this.chosePaymentMethod,
    vaPricePay: vaPricePay ?? this.vaPricePay,
  );
}
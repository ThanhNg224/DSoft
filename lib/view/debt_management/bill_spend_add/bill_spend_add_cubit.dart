import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/view/debt_management/bill_spend_add/bill_spend_add_controller.dart';

class BillSpendAddCubit extends Cubit<BillSpendAddState> {
  BillSpendAddCubit() : super(BillSpendAddState(
    dateTimeValue: DateTime.now(),
    methodPayment: ModelPaymentMethod(name: "Tiền mặt", keyValue: "tien_mat"),
    choseStaff: staff.Data(
        name: findController<BillSpendAddController>().os.modelMyInfo?.data?.name,
        id: findController<BillSpendAddController>().os.modelMyInfo?.data?.id
    )
  ));

  void changeDateTimeBillSpendAdd(DateTime dateTime) {
    emit(state.copyWith(dateTimeValue: dateTime));
  }

  void changeMethodPaymentBillSpendAdd(ModelPaymentMethod method) {
    emit(state.copyWith(methodPayment: method));
  }

  void getListStaffBillSpendAdd(List<staff.Data> list) {
    emit(state.copyWith(listStaff: list));
  }

  void changeChoseStaffBillSpendAdd(staff.Data staff) {
    emit(state.copyWith(choseStaff: staff));
  }

  void setValidatorBillSpendAdd(String? vaName, String? vaPrice, String? vaStaff) {
    emit(state.copyWith(
        vaName: vaName,
        vaPrice: vaPrice,
        vaStaff: vaStaff
    ));
  }

  void changeTitleAppBarBillSpendAdd(String title) {
    emit(state.copyWith(titleAppBar: title));
  }

}

class BillSpendAddState {
  DateTime dateTimeValue;
  ModelPaymentMethod methodPayment;
  List<staff.Data> listStaff;
  staff.Data choseStaff;
  String vaName;
  String vaPrice;
  String vaStaff;
  String titleAppBar;

  BillSpendAddState({
    required this.dateTimeValue,
    required this.methodPayment,
    this.listStaff = const [],
    required this.choseStaff,
    this.vaName = "",
    this.vaPrice = "",
    this.vaStaff = "",
    this.titleAppBar = "Tạo phiếu chi"
  });

  BillSpendAddState copyWith({
    DateTime? dateTimeValue,
    ModelPaymentMethod? methodPayment,
    List<staff.Data>? listStaff,
    staff.Data? choseStaff,
    String? vaName,
    String? vaPrice,
    String? vaStaff,
    String? titleAppBar
  }) => BillSpendAddState(
      dateTimeValue: dateTimeValue ?? this.dateTimeValue,
      methodPayment: methodPayment ?? this.methodPayment,
      listStaff: listStaff ?? this.listStaff,
      choseStaff: choseStaff ?? this.choseStaff,
      vaName: vaName ?? this.vaName,
      vaPrice: vaPrice ?? this.vaPrice,
      vaStaff: vaStaff ?? this.vaStaff,
      titleAppBar: titleAppBar ?? this.titleAppBar
  );
}
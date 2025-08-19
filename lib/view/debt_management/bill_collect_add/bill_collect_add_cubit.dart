import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_list_staff.dart';
import 'package:spa_project/view/debt_management/bill_collect_add/bill_collect_add_controller.dart';

class BillCollectAddCubit extends Cubit<BillCollectAddState> {
  BillCollectAddCubit() : super(BillCollectAddState(
    dateTimeValue: DateTime.now(),
    methodPayment: ModelPaymentMethod(name: "Tiền mặt", keyValue: "tien_mat"),
    choseStaff: Data(
      name: findController<BillCollectAddController>().os.modelMyInfo?.data?.name,
      id: findController<BillCollectAddController>().os.modelMyInfo?.data?.id
    )
  ));

  void changeDateTimeBillCollectAdd(DateTime dateTime) {
    emit(state.copyWith(dateTimeValue: dateTime));
  }

  void changeMethodPaymentBillCollectAdd(ModelPaymentMethod method) {
    emit(state.copyWith(methodPayment: method));
  }

  void changeListStaffBillCollectAdd(List<Data> list) {
    emit(state.copyWith(listStaff: list));
  }

  void changeChoseStaffBillCollectAdd(Data staff) {
    emit(state.copyWith(choseStaff: staff));
  }

  void setValidatorBillCollectAdd(String? vaName, String? vaPrice, String? vaStaff) {
    emit(state.copyWith(
      vaName: vaName,
      vaPrice: vaPrice,
      vaStaff: vaStaff
    ));
  }

  void changeTitleAppBarBillCollectAdd(String title) {
    emit(state.copyWith(titleAppBar: title));
  }

}

class BillCollectAddState {
  DateTime dateTimeValue;
  ModelPaymentMethod methodPayment;
  List<Data> listStaff;
  Data choseStaff;
  String vaName;
  String vaPrice;
  String vaStaff;
  String titleAppBar;

  BillCollectAddState({
    required this.dateTimeValue,
    required this.methodPayment,
    this.listStaff = const [],
    required this.choseStaff,
    this.vaName = "",
    this.vaPrice = "",
    this.vaStaff = "",
    this.titleAppBar = "Tạo phiếu thu"
  });

  BillCollectAddState copyWith({
    DateTime? dateTimeValue,
    ModelPaymentMethod? methodPayment,
    List<Data>? listStaff,
    Data? choseStaff,
    String? vaName,
    String? vaPrice,
    String? vaStaff,
    String? titleAppBar
  }) => BillCollectAddState(
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
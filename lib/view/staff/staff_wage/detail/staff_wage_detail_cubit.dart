import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_list_pay_roll.dart';
import 'package:spa_project/view/staff/staff_wage/detail/staff_wage_detail_controller.dart';

class StaffWageDetailCubit extends Cubit<StaffWageDetailState> {
  StaffWageDetailCubit() : super(StaffWageDetailState(
    choseStatus: ModelSalaryVerifyStatus(name: "Chờ duyệt", key: "new"),
    chosePaymentMethod: ModelPaymentMethod(name: "Tiền mặt", keyValue: "tien_mat"),
  ));

  void choseStatusStaffWageDetail(ModelSalaryVerifyStatus? choseStatus)
  => emit(state.copyWith(choseStatus: choseStatus));

  void setChosePaymentMethod(ModelPaymentMethod chosePaymentMethod)
  => emit(state.copyWith(chosePaymentMethod: chosePaymentMethod));

  void setDataStaffWageDetail(Data data)
  => emit(state.copyWith(data: data));
}

class StaffWageDetailState {
  ModelSalaryVerifyStatus choseStatus;
  ModelPaymentMethod chosePaymentMethod;
  Data? data;

  StaffWageDetailState({
    required this.choseStatus,
    required this.chosePaymentMethod,
    this.data
  });

  StaffWageDetailState copyWith({
    ModelSalaryVerifyStatus? choseStatus,
    ModelPaymentMethod? chosePaymentMethod,
    Data? data
  }) => StaffWageDetailState(
    choseStatus: choseStatus ?? this.choseStatus,
    chosePaymentMethod: chosePaymentMethod ?? this.chosePaymentMethod,
    data: data ?? this.data
  );
}
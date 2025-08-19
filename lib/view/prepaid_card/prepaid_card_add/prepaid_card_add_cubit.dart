import 'package:spa_project/base_project/package.dart';

class PrepaidCardAddCubit extends Cubit<PrepaidCardAddState> {
  PrepaidCardAddCubit() : super(PrepaidCardAddState());

  void changePercent(int? commissionStaffPercent)
  => emit(state.copyWith(commissionStaffPercent: commissionStaffPercent));

  void setValidatePrepaidCardAdd({
    String? vaPrice,
    String? vaName,
    String? vaFaceValue,
  }) => emit(state.copyWith(
    vaPrice: vaPrice,
    vaName: vaName,
    vaFaceValue: vaFaceValue,
  ));

  void changeStatusPrepaidCardAdd() {
    String status = state.status == "active" ? "lock" : "active";
    emit(state.copyWith(status: status));
  }

  void changeTitle(String title) {
    emit(state.copyWith(title: title));
  }
}

class PrepaidCardAddState {
  int commissionStaffPercent;
  String? vaPrice;
  String? vaName;
  String? vaFaceValue;
  String? status;
  String title;

  PrepaidCardAddState({
    this.commissionStaffPercent = 0,
    this.vaPrice,
    this.vaName,
    this.vaFaceValue,
    this.title = "Thêm thẻ trả trước",
    this.status = "active",
  });

  PrepaidCardAddState copyWith({
    int? commissionStaffPercent,
    String? vaPrice,
    String? vaName,
    String? vaFaceValue,
    String? status,
    String? title,
  }) => PrepaidCardAddState(
    commissionStaffPercent: commissionStaffPercent ?? this.commissionStaffPercent,
    vaPrice: vaPrice ?? this.vaPrice,
    vaName: vaName ?? this.vaName,
    vaFaceValue: vaFaceValue ?? this.vaFaceValue,
    status: status ?? this.status,
    title: title ?? this.title,
  );
}
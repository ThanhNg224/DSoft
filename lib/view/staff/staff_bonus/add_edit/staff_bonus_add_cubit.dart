import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_staff.dart';

import 'staff_bonus_add_controller.dart';

class StaffBonusAddCubit extends Cubit<StaffBonusAddState> {
  StaffBonusAddCubit() : super(StaffBonusAddState(
    dateTimeValue: DateTime.now(),
    choseStaff: Data(
      name: findController<StaffBonusAddController>().os.modelMyInfo?.data?.name,
      id: findController<StaffBonusAddController>().os.modelMyInfo?.data?.id
    )
  ));

  void choseStaffBonus(Data choseStaff) {
    emit(state.copyWith(choseStaff: choseStaff));
  }
  void setDateTimeStaffBonus(DateTime dateTime) {
    emit(state.copyWith(dateTimeValue: dateTime));
  }
  void setTitleStaffBonus(String? title) {
    emit(state.copyWith(title: title));
  }
}

class StaffBonusAddState {
  Data choseStaff;
  DateTime dateTimeValue;
  String title;

  StaffBonusAddState({
    required this.choseStaff,
    required this.dateTimeValue,
    this.title = "Tạo thưởng nhân viên",
  });

  StaffBonusAddState copyWith({
    Data? choseStaff,
    DateTime? dateTimeValue,
    String? title,
  }) => StaffBonusAddState(
    choseStaff: choseStaff ?? this.choseStaff,
    dateTimeValue: dateTimeValue ?? this.dateTimeValue,
    title: title ?? this.title,
  );
}
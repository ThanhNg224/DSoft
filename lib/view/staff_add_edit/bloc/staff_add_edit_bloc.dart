import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_group_staff.dart' as group;
import 'package:spa_project/model/response/model_list_banking.dart';
import 'package:spa_project/model/response/model_list_permission.dart' as permission;

part 'staff_add_edit_event.dart';
part 'staff_add_edit_state.dart';

class StaffAddEditBloc extends Bloc<StaffAddEditEvent, StaffAddEditState> {
  StaffAddEditBloc() : super(InitStaffAddEditState()) {
    on<ChoseImageStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(imageFile: event.image));
    });
    on<GetGroupStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(listGroup: event.listGroup));
    });
    on<GetListPermissionStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(listPermission: event.listPermission));
    });
    on<ChoseGroupStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(itemChoseGroup: event.itemChoseGroup));
    });
    on<ChoseBankStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(valueBankChose: event.valueBankChose));
    });
    on<ChangeStatusAccountStaffAddEditEvent>((event, emit) {
      int value = state.statusAccount == StatusAccountStaff.isLock
          ? StatusAccountStaff.isActive
          : StatusAccountStaff.isLock;
      emit(state.copyWith(statusAccount: value));
    });
    on<ChangeTabPermissionStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(indexPermissionTab: event.index));
    });
    on<SetBirthdayStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(valueBirthday: event.valueBirthday));
    });
    on<SetTitleScreenStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(titleButton: event.button, titleAppbar: event.appbar));
    });
    on<ChosePermissionStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(selectedPermissionsByGroup: event.selectedPermissionsByGroup));
    });
    on<SetValidateStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(
        vaPhone: event.vaPhone,
        vaName: event.vaName,
        vaPass: event.vaPass,
        vaAccountBank: event.vaAccountBank,
        vaAllowance: event.vaAllowance,
        vaCodeBank: event.vaCodeBank,
        vaFixedSalary: event.vaFixedSalary,
        vaIdCard: event.vaIdCard,
        vaInsurance: event.vaInsurance,
      ));
    });
    on<GetListBankStaffAddEditEvent>((event, emit) {
      emit(state.copyWith(listBank: event.listBank));
    });
  }
}
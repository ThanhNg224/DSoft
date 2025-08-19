import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_group_staff.dart';
import 'package:spa_project/view/staff/staff_controller.dart';

import '../bloc/staff_bloc.dart';

class StaffGroupController extends BaseController with Repository {
  StaffGroupController(super.context);

  final staffController = findController<StaffController>();
  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    final list = staffController.onTriggerEvent<StaffBloc>().state.listGroup;
    if(list.isEmpty) onGetListGroup();
    super.onInitState();
  }

  void onGetListGroup() async {
    setScreenState = screenStateLoading;
    final response = await listGroupStaffAPI(1);
    if(response is Success<ModelGroupStaff>) {
      if(response.value.code == Result.isOk) {
        staffController.onTriggerEvent<StaffBloc>().add(GetGroupStaffEvent(response.value.data ?? []));
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Đã có lỗi xảy ra");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelGroupStaff>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void openAddEdit({int? id, String? name}) {
    if(id == null) {
      staffController.cNameGroupStaff.clear();
    } else {
      staffController.cNameGroupStaff = TextEditingController(text: name);
    }
    final bloc = staffController.onTriggerEvent<StaffBloc>();
    popupConfirm(
      title: id == null ? "Thêm nhóm nhân viên mới" : "Sửa nhóm nhân viên",
      content: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<StaffBloc, StaffState>(
          builder: (context, state) {
            return WidgetInput(
              controller: staffController.cNameGroupStaff,
              title: "Tên nhóm nhân viên",
              validateValue: state.vaNameStaff,
              hintText: "Nhập tên nhóm nhân viên",
            );
          }
        ),
      )
    ).confirm(onConfirm: () => _onChangeGroup(id));
  }

  void _onChangeGroup(int? id) async {
    String vaName = staffController.cNameGroupStaff.text.isEmpty ? "Vui lòng nhập tên nhóm" : "";
    staffController.onTriggerEvent<StaffBloc>().add(SetValidateStaffEvent(vaName));
    if(vaName.isNotEmpty) return;
    loadingFullScreen();
    final response = await addGroupStaffAPI(id, staffController.cNameGroupStaff.text);
    if(response is Success<int>) {
      hideLoading();
      if(response.value == Result.isOk) {
        onGetListGroup();
        successSnackBar(message: "Cập nhật thành công");
      } else {
        errorSnackBar(message: "Xóa nhóm nhân viên thất bại");
      }
    }
    if(response is Failure<int>) {
      hideLoading();
      popupConfirm(
          content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }

  void deleteGroupStaff(int? id) {
    popupConfirm(
        content: Text("Bạn chắc chắn xóa nhóm nhân viên này ?", style: TextStyles.def)
    ).serious(onTap: () => _onDeleteGroup(id));
  }

  void _onDeleteGroup(int? id) async {
    loadingFullScreen();
    final response = await deteleGroupStaffAPI(id);
    if(response is Success<int>) {
      hideLoading();
      if(response.value == Result.isOk) {
        _onSuccess(id);
      } else {
        errorSnackBar(message: "Xóa nhóm nhân viên thất bại");
      }
    }
    if(response is Failure<int>) {
      hideLoading();
      popupConfirm(content:
      Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }

  void _onSuccess(int? id) {
    final List<Data> list = List.from(staffController.onTriggerEvent<StaffBloc>().state.listGroup);
    int index = list.indexWhere((element) => element.id == id);
    list.removeAt(index);
    staffController.onTriggerEvent<StaffBloc>().add(GetGroupStaffEvent(list));
    successSnackBar(message: "Bạn vừa xóa nhóm thành công");
  }
}
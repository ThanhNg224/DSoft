import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_group_staff.dart' as group;
import 'package:spa_project/model/response/model_list_staff.dart';
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_controller.dart';
import 'package:spa_project/view/staff_add_edit/staff_add_edit_screen.dart';

import '../../../model/request/req_get_list_staff.dart';

class StaffItemController extends BaseController with Repository {
  StaffItemController(super.context);

  final staffController = findController<StaffController>();
  int page = 1;
  Widget errorWidget = const SizedBox();
  TextEditingController cPhone = TextEditingController();
  TextEditingController cEmail = TextEditingController();

  @override
  void onInitState() {
    final list = staffController.onTriggerEvent<StaffBloc>().state.listStaff;
    if(list.isEmpty) {
      getListStaff();
      onGetGroupStaff();
    }
    super.onInitState();
  }

  void getListStaff({StaffState? state}) async {
    setScreenState = screenStateLoading;
    final response = await listStaffAPI(ReqGetListStaff(
      name: staffController.cNameStaff.text,
      idGroup: state?.choseGroup?.id,
      phone: cPhone.text,
      email: cEmail.text
    ));
    if(response is Success<ModelListStaff>) {
      if(response.value.code == Result.isOk) {
        staffController.onTriggerEvent<StaffBloc>().add(GetListStaffEvent(response.value.data ?? []));
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Đã có lỗi xảy ra");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelListStaff>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void onLockStaff({String? name, int? id, required int status}) {
    if(status == 0) {
      popupConfirm(
          content: Text("Khóa tài khoản của nhân viên $name",
              style: TextStyles.def, textAlign: TextAlign.center)
      ).serious(onTap: () {
        _onChangeStatus(id, status);
      });
    } else {
      popupConfirm(
          content: Text("Kích hoạt lại nhân viên $name",
              style: TextStyles.def, textAlign: TextAlign.center)
      ).confirm(onConfirm: () {
        _onChangeStatus(id, status);
      });
    }

  }

  void _onChangeStatus(int? id, int status) async {
    /// 1 : kịch họat
    /// 0 khóa
    loadingFullScreen();
    final response = await lockStaffAPI(id, status);
    if(response is Success<int>) {
      hideLoading();
      if(response.value == Result.isOk) {
        getListStaff();
      } else {
        errorSnackBar(message: "Đã xảy ra lỗi!");
      }
    }
    if(response is Failure<int>) {
      hideLoading();
      popupConfirm(
        content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }

  void toAddStaff({int? idStaff}) {
    Navigator.pushNamed(context, StaffAddEditScreen.router, arguments: idStaff).then((value) {
      if(value != Result.isOk) return;
      getListStaff();
    });
  }

  void onGetGroupStaff() async {
    final response = await listGroupStaffAPI(1);
    if(response is Success<group.ModelGroupStaff>) {
      if(response.value.code == Result.isOk) {
        staffController.onTriggerEvent<StaffBloc>().add(GetGroupStaffEvent(response.value.data ?? []));
      } else {
        errorWidget = Utilities.errorMesWidget("Đã có lỗi xảy ra, không thể lấy được dữ liệu nhóm nhân viên");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<group.ModelGroupStaff>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  @override
  void onDispose() {
    cPhone.dispose();
    cEmail.dispose();
    super.onDispose();
  }
}
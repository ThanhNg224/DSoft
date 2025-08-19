import 'dart:async';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_group_staff.dart' as group;
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_bonus/add_edit/staff_bonus_add_screen.dart';
import 'package:spa_project/view/staff/staff_bonus/staff_bonus_controller.dart';
import 'package:spa_project/view/staff/staff_item/staff_item_controller.dart';
import 'package:spa_project/view/staff/staff_punish/staff_punish_controller.dart';
import 'package:spa_project/view/staff/staff_time_sheet/staff_time_sheet_controller.dart';
import 'package:spa_project/view/staff/staff_wage/add_edit/staff_wage_add_screen.dart';

import '../../model/response/model_staff_bonus.dart' as bonus;
import '../staff_add_edit/staff_add_edit_screen.dart';

class StaffController extends BaseController with Repository {
  StaffController(super.context);

  Widget errorWidget = const SizedBox();
  late DeleteGroupStaff deleteGroupStaff = DeleteGroupStaff(this);

  TextEditingController cNameGroupStaff = TextEditingController();
  TextEditingController cNameStaff = TextEditingController();
  Timer? _debounce;

  void toAddStaff({int? idStaff}) {
    Navigator.pushNamed(context, StaffAddEditScreen.router, arguments: idStaff).then((value) {
      if(value != Result.isOk) return;
      findController<StaffItemController>().getListStaff();
    });
  }

  void toAddBonus({bonus.Data? model, bool isBonus = true}) {
    pushName(StaffBonusAddScreen.router, args: ModelToBonusOrPunish(model: model, isBonus: isBonus)).then((value) {
      if(value != Result.isOk) return;
      if(isBonus) findController<StaffBonusController>().onGetListBonus(isLoad: false);
      findController<StaffPunishController>().onGetListPunish(isLoad: false);
    });
  }

  void toAddWage() {
    pushName(StaffWageAddScreen.router);
  }

  void onOpenCheckTimeSheet() {
    findController<StaffTimeSheetController>().onCheckTimesheet();
  }

  void onSearchStaff() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () async {
      context.read<StaffBloc>().add(SetLoadingSearchStaffEvent(true));
      List<staff.Data> list = List.from(context.read<StaffBloc>().state.listStaff);
      list.clear();
      context.read<StaffBloc>().add(GetListStaffEvent(list));
      // await getListStaff.perform();
      onTriggerEvent<StaffBloc>().add(SetLoadingSearchStaffEvent(false));
    });
  }

  @override
  void onDispose() {
    cNameGroupStaff.dispose();
    cNameStaff.dispose();
    _debounce?.cancel();
    super.onDispose();
  }
}

class DeleteGroupStaff {
  final StaffController _internal;
  DeleteGroupStaff(this._internal);

  void perform(int? id) {
    _internal.popupConfirm(
      content: Text("Bạn chắc chắn xóa nhóm nhân viên này ?", style: TextStyles.def)
    ).serious(onTap: () => _onDeleteGroup(id));
  }

  void _onDeleteGroup(int? id) async {
    _internal.loadingFullScreen();

    final response = await _internal.deteleGroupStaffAPI(id);
    if(response is Success<int>) {
      _internal.hideLoading();
      if(response.value == Result.isOk) {
        _onSuccess(id);
      } else {
        _internal.errorSnackBar(message: "Xóa nhóm nhân viên thất bại");
      }
    }
    if(response is Failure<int>) {
      _internal.hideLoading();
      _internal.popupConfirm(content:
      Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }

  void _onSuccess(int? id) {
    final List<group.Data> list = List.from(_internal.context.read<StaffBloc>().state.listGroup);
    int index = list.indexWhere((element) => element.id == id);
    list.removeAt(index);
    _internal.context.read<StaffBloc>().add(GetGroupStaffEvent(list));
    _internal.successSnackBar(message: "Bạn vừa xóa nhóm thành công");
  }
}

class ModelToBonusOrPunish {
  bool isBonus;
  bonus.Data? model;
  ModelToBonusOrPunish({
    this.isBonus = true,
    this.model
  });
}
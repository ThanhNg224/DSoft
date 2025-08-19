import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_add_edit_staff.dart';
import 'package:spa_project/model/response/model_detail_staff.dart';
import 'package:spa_project/model/response/model_group_staff.dart' as group;
import 'package:spa_project/model/response/model_list_banking.dart' as bank;
import 'package:spa_project/model/response/model_list_permission.dart' as permission;
import 'package:spa_project/view/staff_add_edit/bloc/staff_add_edit_bloc.dart';

class StaffAddEditController extends BaseController<int> with Repository {
  StaffAddEditController(super.context);

  final ServiceImagePicker imagePicker = ServiceImagePicker();
  final ServiceDateTimePicker dateTimePicker = ServiceDateTimePicker();
  Widget errorWidget = const SizedBox();
  ModelDetailStaff? detail;

  TextEditingController cName = TextEditingController();
  TextEditingController cAddress = TextEditingController();
  TextEditingController cPhone = TextEditingController();
  TextEditingController cPass = TextEditingController();
  TextEditingController cFixedSalary = TextEditingController();
  TextEditingController cInsurance = TextEditingController();
  TextEditingController cAllowance = TextEditingController();
  TextEditingController cAccountBank = TextEditingController();
  TextEditingController cidCard = TextEditingController();

  late GetListPermission getListPermission = GetListPermission(this);
  late GetListGroupStaff getListGroupStaff = GetListGroupStaff(this);
  late GetListBanking getListBanking = GetListBanking(this);
  late GetDetailStaff detailStaff = GetDetailStaff(this);

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onGetMulti();
      if(args == null) return;
      context.read<StaffAddEditBloc>().add(SetTitleScreenStaffAddEditEvent(
        button: "Cập nhật",
        appbar: "Sửa thông tin nhân viên",
      ));
    });
    super.onInitState();
  }

  @override
  void onDispose() {
    cName.dispose();
    cAddress.dispose();
    cPhone.dispose();
    cAccountBank.dispose();
    cidCard.dispose();
    cPass.dispose();
    cAllowance.dispose();
    cInsurance.dispose();
    cFixedSalary.dispose();
    super.onDispose();
  }

  bool _isValidate() {
    final state = context.read<StaffAddEditBloc>().state;
    String vaPhone = cPhone.text.isEmpty ? "Vui lòng nhập số điện thoại" : "";
    String vaPass = cPass.text.isEmpty ? "Vui lòng nhập mật khẩu" : "";
    String vaName = cName.text.isEmpty ? "Vui lòng nhập tên nhân viên" : "";
    String vaFixedSalary = cFixedSalary.text.isEmpty ? "Vui lòng nhập lương cứng" : "";
    String vaInsurance = cInsurance.text.isEmpty ? "Vui lòng nhập tiền đóng bảo hiểm" : "";
    String vaAllowance = cAllowance.text.isEmpty ? "Vui lòng nhập tiền phụp cấp" : "";
    String vaAccountBank = cAccountBank.text.isEmpty ? "vui lòng thêm ngân hàng" : "";
    String vaCodeBank = state.valueBankChose == null ? "Thêm tài khoản ngân hàng" : "";
    String vaIdCard = cidCard.text.isEmpty ? "Vui lòng điền CCCD" : "";

    context.read<StaffAddEditBloc>().add(SetValidateStaffAddEditEvent(
      vaPass: vaPass, vaName: vaName, vaPhone: vaPhone,
      vaInsurance: vaInsurance, vaIdCard: vaIdCard, vaFixedSalary: vaFixedSalary,
      vaCodeBank: vaCodeBank, vaAllowance: vaAllowance, vaAccountBank: vaAccountBank,
    ));
    return vaPhone.isEmpty &&
        vaName.isEmpty &&
        vaFixedSalary.isEmpty &&
        vaInsurance.isEmpty &&
        vaAllowance.isEmpty &&
        vaAccountBank.isEmpty &&
        vaCodeBank.isEmpty &&
        vaIdCard.isEmpty &&
        vaPass.isEmpty;
  }

  ReqAddEditStaff _request() {
    final state = context.read<StaffAddEditBloc>().state;
    List<String> allPermissionRequest = state.selectedPermissionsByGroup
        .map((sub) => sub.permission ?? "")
        .where((name) => name.isNotEmpty)
        .toList();
    return ReqAddEditStaff(
      id: args,
      password: cPass.text,
      name: cName.text,
      address: cAddress.text,
      status: state.statusAccount,
      avatar: state.imageFile,
      birthday: state.valueBirthday,
      checkListPermission: allPermissionRequest.join(','),
      idGroup: state.itemChoseGroup?.id,
      phone: cPhone.text,
      accountBank: cAccountBank.text,
      allowance: cAllowance.text.removeCommaMoney,
      codeBank: state.valueBankChose?.code,
      fixedSalary: cFixedSalary.text.removeCommaMoney,
      idCard: cidCard.text,
      insurance: cInsurance.text.removeCommaMoney
    );
  }

  void onAddEditStaff() async {
    if(!_isValidate()) return;
    loadingFullScreen();
    final response = await addStaffAPI(_request());
    if(response is Success<int>) {
      hideLoading();
      if(response.value == Result.isOk) {
        pop(response.value);
      } else if(response.value == 2) {
        popupConfirm(content: Utilities.errorMesWidget("Vui lòng hoàn thành đầy đủ thông tin")).normal();
      } else {
        popupConfirm(content: Utilities.errorMesWidget("Đã có lỗi xảy ra")).normal();
      }
    }
    if(response is Failure<int>) {
      hideLoading();
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }

  void onAvatarPicker() async {
    final item = await imagePicker.imagePicker();
    if(!item.isAllowed) {
      popupConfirm(
        content: Text("Bạn chưa cấp quyền vào bộ nhớ, hãy cấp quyền cho bộ nhớ và thử lại",
          style: TextStyles.def,
          textAlign: TextAlign.center,
        )
      ).confirm(onConfirm: imagePicker.openSettings);
    }
    if(item.path.isNotEmpty) {
      onTriggerEvent<StaffAddEditBloc>().add(ChoseImageStaffAddEditEvent(item.path));
    }
  }

  void onChoseDate() async {
    final date = await dateTimePicker.open(context, type: TypeDateTime.onlyDate);
    String value = date.formatDateTime(format: 'dd/MM/yyyy');
    onTriggerEvent<StaffAddEditBloc>().add(SetBirthdayStaffAddEditEvent(value));
  }

  Future<void> onGetMulti() async {
    loadingFullScreen();
    final listException = await Future.wait([
      getListPermission.perform(),
      getListGroupStaff.perform(),
      getListBanking.onGetListBanking()
    ]);
    if(args != null) await detailStaff.perform();
    hideLoading();
    for(var item in listException) {
      if(!item.isNotError) {
        errorWidget = item.logo;
        return;
      }
    }
  }
}

class GetListPermission {
  final StaffAddEditController _internal;
  GetListPermission(this._internal);

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.getListPermissionAPI();
    if(response is Success<permission.ModelListPermission>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Đã có lỗi xảy ra"));
      }
    }
    if(response is Failure<permission.ModelListPermission>) {
      return ExceptionMultiApi
          .error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<permission.Data> list) {
    final bloc = _internal.context.read<StaffAddEditBloc>();
    bloc.add(GetListPermissionStaffAddEditEvent(list));
  }
}

class GetListGroupStaff {
  final StaffAddEditController _internal;
  GetListGroupStaff(this._internal);

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.listGroupStaffAPI(1);
    if(response is Success<group.ModelGroupStaff>) {
      if(response.value.code == Result.isOk) {
        _internal.onTriggerEvent<StaffAddEditBloc>()
            .add(GetGroupStaffAddEditEvent(response.value.data ?? []));
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Đã có lỗi xảy ra!"));
      }
    }
    if(response is Failure<group.ModelGroupStaff>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}

class GetListBanking {
  final StaffAddEditController _internal;
  GetListBanking(this._internal);

  Future<ExceptionMultiApi> onGetListBanking() async {
    final response = await _internal.getLinstBank();
    if(response is Success<List<bank.ModelListBanking>>) {
      findController<StaffAddEditController>()
          .onTriggerEvent<StaffAddEditBloc>()
          .add(GetListBankStaffAddEditEvent(response.value));
      return ExceptionMultiApi.success();
    }
    if(response is Failure<List<bank.ModelListBanking>>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}

class GetDetailStaff {
  final StaffAddEditController _internal;
  const GetDetailStaff(this._internal);

  Future<void> perform() async {
    _internal.setScreenState = _internal.screenStateLoading;
    final response = await _internal.detailStaffAPI(_internal.args);
    if(response is Success<ModelDetailStaff>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value);
        _internal.setScreenState = _internal.screenStateOk;
      } else {
        _internal.setScreenState = _internal.screenStateError;
        _internal.errorWidget = Utilities.errorMesWidget("Đã có lỗi xảy ra!");
      }
    }
    if(response is Failure<ModelDetailStaff>) {
      _internal.setScreenState = _internal.screenStateError;
      _internal.errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void _onSuccess(ModelDetailStaff detail) {
    final bloc = _internal.context.read<StaffAddEditBloc>();
    _internal.detail = detail;
    _internal.cName = TextEditingController(text: detail.data?.name);
    _internal.cAddress = TextEditingController(text: detail.data?.address);
    _internal.cPhone = TextEditingController(text: detail.data?.phone);
    _internal.cPass = TextEditingController(text: detail.data?.password);
    _internal.cFixedSalary = TextEditingController(text: detail.data?.fixedSalary?.toCurrency());
    _internal.cInsurance = TextEditingController(text: detail.data?.insurance?.toCurrency());
    _internal.cAllowance = TextEditingController(text: detail.data?.allowance?.toCurrency());
    _internal.cAccountBank = TextEditingController(text: detail.data?.accountBank);
    _internal.cidCard = TextEditingController(text: detail.data?.idCard);
    bloc.add(ChoseImageStaffAddEditEvent(detail.data?.avatar));
    bloc.add(SetBirthdayStaffAddEditEvent(detail.data?.birthday));
    final listBank = bloc.state.listBank;
    final listGroup = bloc.state.listGroup;
    final listPermission = bloc.state.listPermission;
    int index = listBank.indexWhere((element) => element.code == detail.data?.codeBank);
    if(index >= 0) bloc.add(ChoseBankStaffAddEditEvent(listBank[index]));
    int indexGroup = listGroup.indexWhere((element) => element.id == detail.data?.idGroup);
    if(index >= 0) bloc.add(ChoseGroupStaffAddEditEvent(listGroup[indexGroup]));
    final permissionMap = _buildPermissionMap(listPermission);
    final selectedPermissions = _getSelectedPermissions(
      permissionNames: _internal.detail?.data?.permission ?? [],
      permissionMap: permissionMap,
    );
    bloc.add(ChosePermissionStaffAddEditEvent(selectedPermissions));
  }

  Map<String, permission.Sub> _buildPermissionMap(List<permission.Data> list) {
    final map = <String, permission.Sub>{};
    for (final group in list) {
      for (final sub in group.sub ?? []) {
        map[sub.permission] = sub;
      }
    }
    return map;
  }

  List<permission.Sub> _getSelectedPermissions({
    required List<String> permissionNames,
    required Map<String, permission.Sub> permissionMap,
  }) => permissionNames
        .map((name) => permissionMap[name])
        .where((sub) => sub != null)
        .map((sub) => permission.Sub(
      name: sub!.name,
      permission: sub.permission,
    )).toList();
}
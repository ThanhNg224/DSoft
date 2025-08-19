import 'dart:io';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_gender.dart';
import 'package:spa_project/model/request/req_create_edit_customer.dart';
import 'package:spa_project/model/response/model_category_customer.dart' as cate;
import 'package:spa_project/model/response/model_create_edit_customer.dart';

import 'package:spa_project/model/response/model_list_customer.dart' as custom;
import 'package:spa_project/model/response/model_list_source_custom.dart' as source;
import 'package:spa_project/view/custom_category/custom_cate_screen.dart';
import 'package:spa_project/view/custom_source/custom_source_screen.dart';
import 'package:spa_project/view/customer_add_edit/bloc/customer_add_edit_bloc.dart';

class CustomerAddOrEditController extends BaseController<custom.Data> with Repository {
  CustomerAddOrEditController(super.context);

  ServiceImagePicker imagePicker = ServiceImagePicker();
  TextEditingController cName = TextEditingController();
  TextEditingController cPhone = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cAddress = TextEditingController();
  int? idGender;
  Widget errorWidget = const SizedBox();

  late DeleteCustomer deleteCustomer = DeleteCustomer(this);
  GetListCategory getListCategory = GetListCategory();
  GetListSourceCustomer getListSource = GetListSourceCustomer();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isAddCustomer = args == null ? true : false;
      onTriggerEvent<CustomerAddEditBloc>().add(SetStatusCustomerAddEditEvent(isAddCustomer));
      onGetMultiple();
      if(args == null) return;
      cName = TextEditingController(text: args?.name);
      cPhone = TextEditingController(text: args?.phone);
      cEmail = TextEditingController(text: args?.email);
      cAddress = TextEditingController(text: args?.address);
      final bloc = onTriggerEvent<CustomerAddEditBloc>();
      bloc.add(SelectGenderCustomerAddEditEvent(
        gender: ModelGender(id: args?.sex, name: args?.sex == 1 ? "Nam" : "Nữ"),
      ));
      bloc.add(SetAvatarCustomerAddEditEvent(args?.avatar ?? ""));
    });
    super.onInitState();
  }

  @override
  void onDispose() {
    cName.dispose();
    cPhone.dispose();
    cEmail.dispose();
    cAddress.dispose();
    super.onDispose();
  }

  void onGetMultiple() async {
    loadingFullScreen();
    final lException = await Future.wait([
      getListCategory.perform(),
      getListSource.perform(),
    ]);
    hideLoading();
    for(var item in lException) {
      if(!item.isNotError) {
        setScreenState = screenStateError;
        errorWidget = item.logo;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  void onChoseImage() async {
    loadingFullScreen();
    final item = await imagePicker.imagePicker();
    hideLoading();
    if(!item.isAllowed) {
      popupConfirm(
        content: Text("Bạn chưa cấp quyền vào bộ nhớ, hãy cấp quyền cho bộ nhớ và thử lại",
          style: TextStyles.def,
          textAlign: TextAlign.center,
        )
      ).confirm(onConfirm: imagePicker.openSettings);
    }
    if(item.path.isNotEmpty) {
      onTriggerEvent<CustomerAddEditBloc>().add(SetAvatarCustomerAddEditEvent(item.path));
    }
  }

  bool _isValidate() {
    String vName = cName.text.isEmpty ? "Vui lòng nhập tên khách hàng" : "";
    String vPhone = cPhone.text.isEmpty ? "Vui lòng nhập số điện thoại" : "";
    context.read<CustomerAddEditBloc>()
        .add(SetValidateCustomerAddEditEvent(vaPhone: vPhone, vaName: vName));
    if(vName.isNotEmpty || vPhone.isNotEmpty) return false;
    return true;
  }

  ReqCreateEditCustomer _request() {
    final state = onTriggerEvent<CustomerAddEditBloc>().state;
    return ReqCreateEditCustomer(
      id: args?.id,
      avatar: File(state.avatar),
      phone: cPhone.text,
      email: cEmail.text,
      address: cAddress.text,
      name: cName.text,
      sex: idGender,
      idGroup: state.selectCate?.id,
      source: state.selectSource?.id
    );
  }

  void onSaveInfo(CustomerAddEditState state) async {
    if(!_isValidate()) return;
    loadingFullScreen();
    final response = await addCustomerApi(_request());
    if(response is Success<ModelCreateEditCustomer>) {
      hideLoading();
      if(response.value.code == Result.isOk) {
        pop(response.value.code);
      } else {
        popupConfirm(content:
        Utilities.errorMesWidget("Số điện thoại của khách hàng này đã tồn tại"
              ", vui lòng nhập số điện thoại khác")
        ).normal();
      }
    }
    if(response is Failure<ModelCreateEditCustomer>) {
      hideLoading();
      popupConfirm(
        content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }

  void toListCateGory() {
    Navigator.pushNamed(context, CustomCateScreen.router).whenComplete(() async {
      final response = await getListCategory.perform();
      if(!response.isNotError) {
        errorWidget = response.logo;
        setScreenState = screenStateError;
        return;
      }
      setScreenState = screenStateOk;
    });
  }

  void toListSource() {
    Navigator.pushNamed(context, CustomSourceScreen.router).whenComplete(() async {
      final response = await getListSource.perform();
      if(!response.isNotError) {
        errorWidget = response.logo;
        setScreenState = screenStateError;
        return;
      }
      setScreenState = screenStateOk;
    });
  }
}

class DeleteCustomer {
  final CustomerAddOrEditController _internal;
  DeleteCustomer(this._internal);

  void perform() {
    _internal.popupConfirm(content:
    Text("Bạn chắc chắn muốn xóa hồ sơ khách hàng này?",
      style: TextStyles.def,
      textAlign: TextAlign.center,
    )).serious(onTap: _onDelete);
  }

  void _onDelete() async {
    _internal.loadingFullScreen();
    final response = await _internal.deleteCustomerAPI(_internal.args?.id);
    if(response is Success<int>) {
      _internal.hideLoading();
      if(response.value == Result.isOk) {
        _internal.pop(_internal.args);
      } else {
        _internal.popupConfirm(content:
        Utilities.errorMesWidget("Không xóa được khách hàng này!")
        ).normal();
      }
    }
    if(response is Failure<int>) {
      _internal.hideLoading();
      _internal.popupConfirm(
          content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }
}

class GetListCategory with Repository {
  Future<ExceptionMultiApi> perform() async {
    final response = await listCategoryCustomerAPI(1);
    if(response is Success<cate.ModelCategoryCustomer>) {
      if(response.value.code == Result.isOk) {
        findController<CustomerAddOrEditController>()
            .onTriggerEvent<CustomerAddEditBloc>()
            .add(GetListCateCustomerAddEditEvent(response.value.data ?? const []));
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo:
        Utilities.errorMesWidget("Không thể lấy danh sách danh mục khách hàng"));
      }
    }
    if(response is Failure<cate.ModelCategoryCustomer>) {
      return ExceptionMultiApi.error(logo:
      Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}

class GetListSourceCustomer with Repository {
  Future<ExceptionMultiApi> perform() async {
    final response = await listSourceCustomerAPI(1);
    if(response is Success<source.ModelListSourceCustom>) {
      if(response.value.code == Result.isOk) {
        findController<CustomerAddOrEditController>()
            .onTriggerEvent<CustomerAddEditBloc>()
            .add(GetListSourceCustomerAddEditEvent(response.value.data ?? const []));
        final args = findController<CustomerAddOrEditController>().args;
        int index = response.value.data?.indexWhere((item) => item.id == args?.source) ?? -1;
        findController<CustomerAddOrEditController>()
            .onTriggerEvent<CustomerAddEditBloc>()
            .add(ChoseDropDowCustomerAddEditEvent(
          selectCate: args?.category,
          selectSource: (index >= 0 && (response.value.data?.length ?? 0) > index)
              ? response.value.data![index]
              : null,
        ));
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo:
        Utilities.errorMesWidget("Không thể lấy danh sách danh mục khách hàng"));
      }
    }
    if(response is Failure<source.ModelListSourceCustom>) {
      return ExceptionMultiApi.error(logo:
      Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}
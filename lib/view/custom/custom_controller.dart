import 'dart:async';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/arguments/to_book_add_edit_model.dart';
import 'package:spa_project/model/request/req_list_customer.dart';
import 'package:spa_project/model/response/model_category_customer.dart' as cate;
import 'package:spa_project/model/response/model_list_customer.dart' as custom;
import 'package:spa_project/model/response/model_list_source_custom.dart' as source;
import 'package:spa_project/view/book_add_edit/book_add_edit_screen.dart';
import 'package:spa_project/view/custom/bloc/custom_bloc.dart';

import '../customer_add_edit/customer_add_or_edit_screen.dart';

class CustomController extends BaseController with Repository {
  CustomController(super.context);

  Widget error = const SizedBox();
  int _page = 1;
  Timer? _debounce;

  TextEditingController cPhoneFil = TextEditingController();
  TextEditingController cEmailFil = TextEditingController();
  TextEditingController cNameFil = TextEditingController();

  @override
  void onDispose() {
    cPhoneFil.dispose();
    cEmailFil.dispose();
    _debounce?.cancel();
    cNameFil.dispose();
    super.onDispose();
  }

  @override
  void onInitState() {
    onGetMultiple();
    setEnableScrollController = true;
    super.onInitState();
  }

  Future<void> onGetMultiple() async {
    setScreenState = screenStateLoading;
    final listException = await Future.wait([
      _GetListCustomer(this).perform(1),
      _GetListGroup().perform(),
      _GetListSource().perform(),
    ]);
    for(var item in listException) {
      if(!item.isNotError) {
        setScreenState = screenStateError;
        error = item.logo;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  Future<void> onGetOnlyCustomer({int page = 1}) async {
    final data = await _GetListCustomer(this).perform(page);
    if(!data.isNotError) {
      setScreenState = screenStateError;
      error = data.logo;
      return;
    }
    setScreenState = screenStateOk;
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    _page = 1;
    isMoreEnable = true;
    await onGetOnlyCustomer();
  }

  void onSearchData() {
    _page = 1;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () async {
      List<custom.Data> list = List.from(context.read<CustomBloc>().state.listCustomer);
      list.clear();
      context.read<CustomBloc>().add(SetStateLoadingSearchCustomEvent(true));
      context.read<CustomBloc>().add(GetListCustomEvent(list));
      await onGetOnlyCustomer();
      onTriggerEvent<CustomBloc>().add(SetStateLoadingSearchCustomEvent(false));
    });
  }

  void toCreateCustomer() {
    Navigator.pushNamed(context, CustomerAddOrEditScreen.router).then((value) async {
      if(value == Result.isOk) {
        final res = await _GetListCustomer(this).perform(1);
        if(!res.isNotError) {
          setScreenState = screenStateError;
          error = res.logo;
          return;
        }
        setScreenState = screenStateOk;
      }
    });
  }

  void toAddEditCustomer(custom.Data? data) {
    Navigator.pushNamed(context,
      CustomerAddOrEditScreen.router,
      arguments: data
    ).then((value) {
      if(value == Result.isOk) onGetOnlyCustomer(page: _page);
    });
  }

  String getNameSource(int? id) {
    if(id == null) return "";
    final list = context.read<CustomBloc>().state.listSource;
    int index = list.indexWhere((element) => element.id == id);
    if(index < 0) return "Chưa cập nhật";
    return list[index].name ?? "Chưa cập nhật";
  }

  void toCreateBook(custom.Data custom) {
    Navigator.pushNamed(context, BookAddEditScreen.router, arguments: ToBookAddEditModel(
      dataCustom: custom
    ));
  }

  @override
  void onLoadMore() {
    _page ++;
    onGetOnlyCustomer(page: _page);
    super.onLoadMore();
  }
}

class _GetListCustomer {
  final CustomController _internal;
  _GetListCustomer(this._internal);

  List<custom.Data> _list = [];

  Future<ExceptionMultiApi> perform(int page) async {
    final response = await _internal.listCustomerAPI(ReqListCustomer(
      page: page,
      name: _internal.cNameFil.text,
      phone: _internal.cPhoneFil.text,
      email: _internal.cEmailFil.text,
    ));
    if(response is Success<custom.ModelListCustomer>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? [], page);
      } else {
        return ExceptionMultiApi.error(logo: Utilities
          .errorMesWidget("Không thể lấy danh sách khách hàng"));
      }
    }
    if(response is Failure<custom.ModelListCustomer>) {
      return ExceptionMultiApi.error(logo: Utilities
          .errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  _onSuccess(List<custom.Data> response, int page) {
    _list = List.from(_internal.context.read<CustomBloc>().state.listCustomer);
    if(page == 1) _list = [];
    _list.addAll(response);
    if (_list.isEmpty) _internal.isMoreEnable = false;
    if (response.length < 10) _internal.isMoreEnable = false;
    _internal.context.read<CustomBloc>().add(GetListCustomEvent(_list));
  }
}

class _GetListGroup with Repository {
  final context = findController<CustomController>().context;

  Future<ExceptionMultiApi> perform() async {
    final response = await listCategoryCustomerAPI(1);
    if(response is Success<cate.ModelCategoryCustomer>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
      } else {
        return ExceptionMultiApi.error(logo: Utilities
          .errorMesWidget("Không thể lấy danh sách danh mục khách hàng"));
      }
    }
    if(response is Failure<cate.ModelCategoryCustomer>) {
      return ExceptionMultiApi.error(logo: Utilities
        .errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<cate.Category> list) {
    context.read<CustomBloc>().add(GetListCateCustomEvent(list));
  }
}

class _GetListSource with Repository {

  Future<ExceptionMultiApi> perform() async {
    final response = await listSourceCustomerAPI(1);
    if(response is Success<source.ModelListSourceCustom>) {
      if(response.value.code == Result.isOk) {
        findController<CustomController>()
            .onTriggerEvent<CustomBloc>()
            .add(GetListSourceCustomEvent(response.value.data ?? []));
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
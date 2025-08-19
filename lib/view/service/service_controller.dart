import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_get_list_service.dart';
import 'package:spa_project/model/response/model_list_category_service.dart' as cate;
import 'package:spa_project/model/response/model_list_service.dart' as ser;

import 'package:spa_project/view/service/bloc/service_bloc.dart';
import 'package:spa_project/view/service_add_edit/service_add_edit_screen.dart';


class ServiceController extends BaseController with Repository {
  ServiceController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cNameGroup = TextEditingController();
  TextEditingController cNameServiceSearch = TextEditingController();
  int _page = 1;

  late GetListCategoryService getListCate = GetListCategoryService(context);
  late AddEditCategoryService addEdit = AddEditCategoryService(context);
  late DeleteCategoryService deleteCategory = DeleteCategoryService(this);
  late GetListService listService = GetListService(this);

  @override
  void onInitState() {
    onGetMulti(true);
    setEnableScrollController = true;
    super.onInitState();
  }

  void onGetMulti(bool isLoad) async {
    if(isLoad) setScreenState = screenStateLoading;
    final listException = await Future.wait([
      getListCate.perform(),
      listService.perform(),
    ]);
    for(var item in listException) {
      if(!item.isNotError) {
        errorWidget = item.logo;
        setScreenState = screenStateError;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  void onDeleteCateService(int? id) {
    popupConfirm(
      content: Text("Bạn có muốn xóa danh mục này không?", style: TextStyles.def, textAlign: TextAlign.center)
    ).serious(onTap: () {
      deleteCategory.perform(id);
    });
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    _page = 1;
    await listService.perform();
  }

  @override
  void onLoadMore() {
    _page ++;
    listService.perform();
    super.onLoadMore();
  }

  void onToAddEditService({int? index}) {
    final state = context.read<ServiceBloc>().state;
    Navigator.pushNamed(context, ServiceAddEditScreen.router, arguments: index != null ? state.listService[index] : null).then((value) {
      if(value == Result.isOk) listService.perform();
    });
  }

  @override
  void onDispose() {
    cNameGroup.dispose();
    cNameServiceSearch.dispose();
    super.onDispose();
  }
}

class GetListCategoryService extends ServiceController {
  GetListCategoryService(super.context);

  Future<ExceptionMultiApi> perform() async {
    final response = await listCategoryServiceAPI();
    if(response is Success<cate.ModelListCategoryService>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(
            logo: Utilities.errorMesWidget("Đã có lỗi xảy ra")
        );
      }
    }
    if(response is Failure<cate.ModelListCategoryService>) {
      return ExceptionMultiApi.error(
          logo: Utilities.errorCodeWidget(response.errorCode)
      );
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<cate.Data> response) => context.read<ServiceBloc>().add(
      GetListCateServiceEvent(response)
  );
}

class AddEditCategoryService extends ServiceController {
  AddEditCategoryService(super.context);

  void perform({int? id, String? name}) {
    cNameGroup.clear();
    if(id != null) cNameGroup = TextEditingController(text: name);
    popupConfirm(
      content: WidgetInput(
        title: "Tên dịch vụ",
        controller: cNameGroup,
        hintText: "Nhập tên dịch vụ",
      ),
      title: id != null ? "Sửa nhóm dịch vụ" : "Thêm nhóm dịch vụ"
    ).confirm(onConfirm: () {
      if(cNameGroup.text.isEmpty) {
        warningSnackBar(message: "Vui lòng nhập tên dịch vụ");
        return;
      }
      _onAddEdit(id: id);
    });
  }

  void _onAddEdit({int? id}) async {
    loadingFullScreen();
    final response = await addCategoryServiceAPI(name: cNameGroup.text, id: id);
    if(response is Success<int>) {
      hideLoading();
      if(response.value == Result.isOk) {
        getListCate.perform();
      } else {
        errorSnackBar(message: "Không thêm được nhóm dịch vụ");
      }
    }
    if(response is Failure<int>) {
      hideLoading();
      popupConfirm(
        content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }
}

class DeleteCategoryService {
  final ServiceController _internal;
  DeleteCategoryService(this._internal);

  void perform(int? id) async {
    _internal.loadingFullScreen();
    final response = await _internal.deleteCategoryServiceAPI(id);
    if(response is Success<int>) {
      _internal.hideLoading();
      if(response.value == Result.isOk) {
        _onSuccess(id);
      } else {
        _internal.errorSnackBar(message: "Không xóa được danh mục dịch vụ");
      }
    }
    if(response is Failure<int>) {
      _internal.hideLoading();
      _internal.popupConfirm(
        content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }

  void _onSuccess(int? id) {
    List<cate.Data> listRoom = List.from(_internal.context.read<ServiceBloc>().state.listCate);
    int index = listRoom.indexWhere((element) => element.id == id);
    listRoom.removeAt(index);
    _internal.context.read<ServiceBloc>().add(GetListCateServiceEvent(listRoom));
  }
}

class GetListService {
  final ServiceController _internal;
  GetListService(this._internal);

  List<ser.Data> _list = [];

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.listServiceAPI(ReqGetListService(
      page: _internal._page,
      name: _internal.cNameServiceSearch.text,
      idCategory: _internal.onTriggerEvent<ServiceBloc>().state.cateSelect?.id
    ));
    if(response is Success<ser.ModelListService>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(
          logo: Utilities.errorMesWidget("Đã có lỗi xảy ra")
        );
      }
    }
    if(response is Failure<ser.ModelListService>) {
      return ExceptionMultiApi.error(
          logo: Utilities.errorCodeWidget(response.errorCode)
      );
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<ser.Data> response) {
    _list = _internal.context.read<ServiceBloc>().state.listService;
    if(_internal._page == 1) _list = [];
    _list.addAll(response);
    if (_list.isEmpty) _internal.isMoreEnable = false;
    if (response.length < 10) _internal.isMoreEnable = false;
    _internal.context.read<ServiceBloc>().add(
      GetListServiceServiceEvent(_list)
    );
  }
}

class DeleteService extends Repository {

  final _c = findController<ServiceController>();

  void perform(int index) {
    final state = _c.onTriggerEvent<ServiceBloc>().state;
    _c.popupConfirm(
        content: RichText(text: TextSpan(
            children: [
              TextSpan(
                  text: "Bạn có muốn xóa dịch vụ ",
                  style: TextStyles.def
              ),
              TextSpan(
                  text: state.listService[index].name,
                  style: TextStyles.def.bold
              ),
              TextSpan(
                  text: " không",
                  style: TextStyles.def
              ),
            ]
        ))
    ).serious(onTap: () async {
      _c.loadingFullScreen();
      final response = await deleteServiceAPI(state.listService[index].id);
      _c.hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          final List<ser.Data> list = List.from(state.listService);
          list.removeAt(index);
          _c.onTriggerEvent<ServiceBloc>().add(GetListServiceServiceEvent(list));
        }
        if(response.value != Result.isOk) _c.errorSnackBar(message: "Không xóa được dịch vụ ${state.listService[index].name}");
      }
      if(response is Failure<int>) {
        _deleteError(response.errorCode);
      }
    });
  }

  _deleteError(int code) {
    _c.popupConfirm(
        content: Utilities.errorCodeWidget(code)
    ).normal();
  }
}
import 'dart:convert';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/data_product.dart';
import 'package:spa_project/model/common/data_service.dart';
import 'package:spa_project/model/request/req_add_edit_combo.dart';
import 'package:spa_project/model/request/req_get_list_service.dart';
import 'package:spa_project/model/request/req_list_product.dart';
import 'package:spa_project/model/response/model_list_combo.dart' as combo;
import 'package:spa_project/model/response/model_list_product.dart' as product;
import 'package:spa_project/model/response/model_list_service.dart' as service;
import 'package:spa_project/view/combo_treatment/add_edit/combo_add_edit_cubit.dart';

class ComboAddEditController extends BaseController<combo.Data> with Repository {
  ComboAddEditController(super.context);

  final GetListServiceComboAddEdit getListService = GetListServiceComboAddEdit();
  final GetListProductComboAddEdit getListProduct = GetListProductComboAddEdit();
  TextEditingController cName = TextEditingController();
  TextEditingController cPrice = TextEditingController();
  TextEditingController cDuration = TextEditingController();
  TextEditingController cPriceForStaff = TextEditingController();
  TextEditingController cDescription = TextEditingController();
  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onGetMulti();
      if(args == null) return;
      cName = TextEditingController(text: args?.name);
      cPrice = TextEditingController(text: args?.price?.toCurrency());
      // cDuration = TextEditingController(text: args?.price?.toCurrency());
      cPriceForStaff = TextEditingController(text: args?.commissionStaffFix?.toCurrency());
      cDescription = TextEditingController(text: args?.description);
      onTriggerEvent<ComboAddEditCubit>().changePercentComboAddEdit(args?.commissionStaffPercent ?? 0);
      if(args?.status != onTriggerEvent<ComboAddEditCubit>().state.status) {
        onTriggerEvent<ComboAddEditCubit>().changeStatusComboAddEdit();
      }
      onTriggerEvent<ComboAddEditCubit>().setServiceComboAddEdit(args?.listService?.map((element) {
        return DataService(value: service.Data(
          commissionAffiliatePercent: element.commissionAffiliatePercent,
          image: element.image,
          commissionStaffPercent: element.commissionStaffPercent,
          status: element.status,
          name: element.name,
          id: element.id,
          price: element.price,
          description: element.description,
          duration: element.duration,
          commissionStaffFix: element.commissionStaffFix,
          commissionAffiliateFix: element.commissionAffiliateFix,
          idCategory: element.idCategory,
          code: element.code,
          createdAt: element.createdAt,
          idMember: element.idMember,
          idSpa: element.idSpa,
          slug: element.slug,
          updatedAt: element.updatedAt
        ),
        cQuantity: TextEditingController(text: (element.quantityCombo ?? 0).toString()));
      }).toList());
      onTriggerEvent<ComboAddEditCubit>().setProductComboAddEdit(args?.listProduct?.map((element) {
        return DataProduct(value: product.Data(
          commissionAffiliatePercent: element.commissionAffiliatePercent,
          image: element.image,
          commissionStaffPercent: element.commissionStaffPercent,
          status: element.status,
          name: element.name,
          id: element.id,
          price: element.price,
          description: element.description,
          commissionStaffFix: element.commissionStaffFix,
          commissionAffiliateFix: element.commissionAffiliateFix,
          idCategory: element.idCategory,
          code: element.code,
          createdAt: element.createdAt,
          idMember: element.idMember,
          idSpa: element.idSpa,
          slug: element.slug,
          updatedAt: element.updatedAt
        ),
        cQuantity: TextEditingController(text: (element.quantityCombo ?? 0).toString()));
      }).toList());
      onTriggerEvent<ComboAddEditCubit>().setTitleComboAddEdit(value: "Cập nhật combo liệu trình");
    });
    super.onInitState();
  }

  ReqAddEditCombo _request() => ReqAddEditCombo();

  void onAddEditCombo() async {
    loadingFullScreen();
    final response = await addComboAPI(_request());
    hideLoading();
    if(response is Success<int>) {

    }
    if(response is Failure<int>) {
      popupConfirm(
        content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }

  void onGetMulti() async {
    loadingFullScreen();
    final eList = await Future.wait([
      getListService.perform(),
      getListProduct.perform(),
    ]);
    hideLoading();
    for(var item in eList) {
      if(!item.isNotError) {
        setScreenState = screenStateError;
        errorWidget = item.logo;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  void onAddProduct(ComboAddEditState state) {
    List<DataProduct> list = List.from(state.dataProduct);
    list.add(DataProduct(cQuantity: TextEditingController(text: "1")));
    onTriggerEvent<ComboAddEditCubit>().setProductComboAddEdit(list);
  }

  void removeProduct(int index, ComboAddEditState state) {
    List<DataProduct> list = List.from(state.dataProduct);
    list[index].cQuantity?.dispose();
    list.removeAt(index);
    onTriggerEvent<ComboAddEditCubit>().setProductComboAddEdit(list);
  }

  void onAddService(ComboAddEditState state) {
    List<DataService> list = List.from(state.dataService);
    list.add(DataService(cQuantity: TextEditingController(text: "1")));
    onTriggerEvent<ComboAddEditCubit>().setServiceComboAddEdit(list);
  }

  void removeService(int index, ComboAddEditState state) {
    List<DataService> list = List.from(state.dataService);
    list[index].cQuantity?.dispose();
    list.removeAt(index);
    onTriggerEvent<ComboAddEditCubit>().setServiceComboAddEdit(list);
  }

  bool _isValidator(ComboAddEditState state) {
    String vaName = cName.text.isEmpty ? "Vui lòng nhập tên gói combo" : "";
    String vaPrice = cPrice.text.isEmpty ? "Vui lòng nhập giá tiền" : "";
    onTriggerEvent<ComboAddEditCubit>().setValidatorComboAddEdit(
      vaName: vaName,
      vaPrice: vaPrice,
    );
    return vaName.isEmpty && vaPrice.isEmpty;
  }

  void onAddEdit(ComboAddEditState state) async {
    if(!_isValidator(state)) return warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
    bool isServiceEmpty = state.dataService.isEmpty ||
        (state.dataService.length == 1 && state.dataService[0].value == null);

    bool isProductEmpty = state.dataProduct.isEmpty ||
        (state.dataProduct.length == 1 && state.dataProduct[0].value == null);

    if (isServiceEmpty && isProductEmpty) {
      return popupConfirm(
        content: Text(
          "Vui lòng chọn ít nhất một sản phẩm hoặc dịch vụ",
          style: TextStyles.def,
          textAlign: TextAlign.center,
        ),
      ).normal();
    }
    loadingFullScreen();
    final response = await addComboAPI(ReqAddEditCombo(
      commissionStaffPercent: state.commissionStaffPercent,
      status: state.status,
      name: cName.text,
      id: args?.id,
      price: cPrice.text.removeCommaMoney,
      description: cDescription.text,
      duration: cDuration.text.isNotEmpty ? int.parse(cDuration.text) : null,
      commissionStaffFix: cPriceForStaff.text.removeCommaMoney,
      dataProduct: jsonEncode(state.dataProduct
          .where((element) => element.value != null)
          .map((element) => element.toJson())
          .toList()),
      dataService: jsonEncode(state.dataService
          .where((element) => element.value != null)
          .map((element) => element.toJson())
          .toList()),
    ));
    hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        pop(response.value);
      } else {
        errorSnackBar(message: "Không thể tạo combo");
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }

  @override
  void onDispose() {
    cName.dispose();
    cPrice.dispose();
    cDuration.dispose();
    cDescription.dispose();
    super.onDispose();
  }

}

class GetListServiceComboAddEdit with Repository {
  Future<ExceptionMultiApi> perform() async {
    final response = await listServiceAPI(ReqGetListService(page: 1));
    if(response is Success<service.ModelListService>) {
      findController<ComboAddEditController>()
          .onTriggerEvent<ComboAddEditCubit>()
          .getServiceComboAddEdit(response.value.data ?? []);
      return ExceptionMultiApi.success();
    }
    if(response is Failure<service.ModelListService>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}

class GetListProductComboAddEdit with Repository {
  Future<ExceptionMultiApi> perform() async {
    final response = await listProductAPI(ReqListProduct(page: 1));
    if(response is Success<product.ModelListProduct>) {
      findController<ComboAddEditController>()
          .onTriggerEvent<ComboAddEditCubit>()
          .getProductComboAddEdit(response.value.data ?? []);
      return ExceptionMultiApi.success();
    }
    if(response is Failure<product.ModelListProduct>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}
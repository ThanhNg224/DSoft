import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_create_product.dart';
import 'package:spa_project/model/response/model_list_cate_product.dart';
import 'package:spa_project/model/response/model_list_product.dart' as product;
import 'package:spa_project/model/response/model_list_trademark.dart';
import 'package:spa_project/view/product/product_item_add_edit/bloc/product_item_add_edit_bloc.dart';

class ProductItemAddEditController extends BaseController<product.Data> with Repository {
  ProductItemAddEditController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cName = TextEditingController();
  TextEditingController cCodeProduct = TextEditingController();
  TextEditingController cPrice = TextEditingController();
  TextEditingController cDescription  = TextEditingController();
  TextEditingController cPriceForStaff  = TextEditingController();
  TextEditingController cPriceForAffiliate  = TextEditingController();
  TextEditingController cInfo  = TextEditingController();
  final ServiceImagePicker serviceImage = ServiceImagePicker();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onGetMultiple();
      if(args == null) return;
      final bloc = context.read<ProductItemAddEditBloc>();
      cName = TextEditingController(text: args?.name);
      cCodeProduct = TextEditingController(text: args?.code);
      cPrice = TextEditingController(text: args?.price?.toCurrency());
      cDescription = TextEditingController(text: args?.description);
      cPriceForStaff = TextEditingController(text: args?.commissionStaffFix?.toCurrency());
      cPriceForAffiliate = TextEditingController(text: args?.commissionAffiliateFix?.toCurrency());
      cInfo = TextEditingController(text: args?.info);
      bloc.add(ChangeSlideProductItemAddEditEvent(
        commissionAffiliatePercent: args?.commissionAffiliatePercent,
        commissionStaffPercent: args?.commissionStaffPercent,
      ));
      if(args?.status == "lock") bloc.add(ChangeStatusProductItemAddEditEvent());
      bloc.add(SetTitleViewProductItemAddEditEvent("Sửa sản phẩm"));
      bloc.add(ChoseImageProductItemAddEditEvent(args?.image));
    });
    super.onInitState();
  }

  void onGetMultiple() async {
    loadingFullScreen();
    final list = await Future.wait([
      OnGetCategoryProduct().perform(),
      OnGetTrademarkProduct().perform(),
    ]);
    hideLoading();
    for(var item in list) {
      if(!item.isNotError) {
        errorWidget = item.logo;
        setScreenState = screenStateError;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  void onChoseImage() async {
    loadingFullScreen();
    final item = await serviceImage.imagePicker();
    hideLoading();
    if(!item.isAllowed) {
      popupConfirm(
          content: Text("Bạn chưa cấp quyền vào bộ nhớ, hãy cấp quyền cho bộ nhớ và thử lại",
            style: TextStyles.def,
            textAlign: TextAlign.center,
          )
      ).confirm(onConfirm: serviceImage.openSettings);
    }
    if(item.path.isNotEmpty) {
      onTriggerEvent<ProductItemAddEditBloc>().add(ChoseImageProductItemAddEditEvent(item.path));
    }
  }

  void onAddEditProduct() => AddProduct().perform();

  void onDeleteProduct() => RemoveProduct().perform();

  @override
  void onDispose() {
    cName.dispose();
    cCodeProduct.dispose();
    cPrice.dispose();
    cDescription.dispose();
    cPriceForStaff.dispose();
    cPriceForAffiliate.dispose();
    super.onDispose();
  }

}

class OnGetCategoryProduct with Repository {
  final context = findController<ProductItemAddEditController>().context;
  final args = findController<ProductItemAddEditController>().args;

  Future<ExceptionMultiApi> perform() async {
    final response = await listCategoryProductAPI(1);
    if(response is Success<ModelListCateProduct>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không thể tải được dữ liệu"));
      }
    }
    if(response is Failure<ModelListCateProduct>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
  
  void _onSuccess(List<ModelDetailCateProduct> response) {
    context.read<ProductItemAddEditBloc>().add(GetListCateProductItemAddEditEvent(response));
    if(args == null) return;
    int index = response.indexWhere((item) => item.id == args?.idCategory);
    if(index > -1) {
      context.read<ProductItemAddEditBloc>().add(ChoseDropDowProductItemAddEditEvent(
        choseCate: response[index]
      ));
    }
  }
}

class OnGetTrademarkProduct with Repository {
  final context = findController<ProductItemAddEditController>().context;
  final args = findController<ProductItemAddEditController>().args;

  Future<ExceptionMultiApi> perform() async {
    final response = await listTrademarkProductAPI(1);
    if(response is Success<ModelListTrademark>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không thể tải được dữ liệu"));
      }
    }
    if(response is Failure<ModelListTrademark>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<Data> response) {
    context.read<ProductItemAddEditBloc>().add(GetListTradeProductItemAddEditEvent(response));
    if(args == null) return;
    int index = response.indexWhere((item) => item.id == args?.idTrademark);
    if(index > -1) {
      context.read<ProductItemAddEditBloc>().add(ChoseDropDowProductItemAddEditEvent(
        choseTrademark: response[index]
      ));
    }
  }
}

class AddProduct with Repository {

  final _internal = findController<ProductItemAddEditController>();

  bool _isValidate() {
    final state = _internal.context.read<ProductItemAddEditBloc>().state;
    String vaName = _internal.cName.text.isEmpty ? "Vui lòng nhập tên sản phẩm" : "";
    String vaPrice = _internal.cPrice.text.isEmpty ? "Vui lòng nhập giá sản phẩm" : "";
    String vaCate = state.choseCate == null ? "Vui lòng chọn danh mục" : "";
    String vaTrademark = state.choseCate == null ? "Vui lòng chọn nhãn hiện" : "";
    _internal.context.read<ProductItemAddEditBloc>().add(ValidateProductItemAddEditEvent(
        vaName: vaName,
        vaCate: vaCate,
        vaPrice: vaPrice,
        vaTrademark: vaTrademark
    ));
    return vaName.isEmpty && vaPrice.isEmpty && vaCate.isEmpty && vaTrademark.isEmpty;
  }

  ReqCreateProduct _request() {
    final state = _internal.context.read<ProductItemAddEditBloc>().state;
    return ReqCreateProduct(
      description: _internal.cDescription.text,
      name: _internal.cName.text,
      status: state.statusProduct == 0 ? "lock" : "active",
      price: _internal.cPrice.text.removeCommaMoney,
      idCategory: state.choseCate?.id,
      idTrademark: state.choseTrademark?.id,
      image: state.fileImage,
      commissionAffiliatePercent: state.commissionAffiliatePercent,
      commissionStaffPercent: state.commissionStaffPercent,
      commissionStaffFix: _internal.cPriceForStaff.text.removeCommaMoney,
      commissionAffiliateFix: _internal.cPriceForAffiliate.text.removeCommaMoney,
      id: _internal.args?.id,
      code: _internal.cCodeProduct.text,
      info: _internal.cInfo.text,
    );
  }

  void perform() async {
    if(!_isValidate()) return;
    _internal.loadingFullScreen();
    final response = await addProductAPI(_request());
    _internal.hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        _internal.pop(ResultChangeProduct(
          result: response.value
        ));
      } else {
        _internal.errorSnackBar(message: "Không thể thêm sản phẩm");
      }
    }
    if(response is Failure<int>) {
      _internal.popupConfirm(content: Utilities
          .errorCodeWidget(response.errorCode)).normal();
    }
  }
}

class RemoveProduct with Repository {

  final _internal = findController<ProductItemAddEditController>();

  void perform() {
    _internal.popupConfirm(
      content: Text("Xác nhận xóa sản phẩm ${_internal.args?.name ?? ""}",
        style: TextStyles.def, textAlign: TextAlign.center)
    ).serious(onTap: () async {
      _internal.loadingFullScreen();
      final response = await deleteProductAPI(_internal.args?.id);
      _internal.hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          _internal.pop(ResultChangeProduct(
            result: response.value,
            isDelete: true
          ));
        } else {
          _internal.popupConfirm(
            content: Utilities.errorMesWidget("Không thể xóa sản phẩm")
          ).normal();
        }
      }
      if(response is Failure<int>) {
        _internal.popupConfirm(
          content: Utilities.errorCodeWidget(response.errorCode)
        ).normal();
      }
    });
  }
}

class ResultChangeProduct {
  bool isDelete;
  int? result;

  ResultChangeProduct({this.result, this.isDelete = false});
}
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_trademark.dart';
import 'package:spa_project/view/product/product_controller.dart';
import 'package:spa_project/view/product/product_trademark/product_trademark_cubit.dart';

class ProductTrademarkController extends BaseController with Repository {
  ProductTrademarkController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    final list = context.read<ProductTrademarkCubit>().state;
    if(list.isEmpty) onGetListTrademark(true);
    super.onInitState();
  }

  void onGetListTrademark(bool isLoad) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listTrademarkProductAPI(1);
    if(response is Success<ModelListTrademark>) {
      if(response.value.code == Result.isOk) {
        setScreenState = screenStateOk;
        onTriggerEvent<ProductTrademarkCubit>().getListTrademark(response.value.data ?? []);
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được danh sách");
      }
    }
    if(response is Failure<ModelListTrademark>) {
      setScreenState = screenStateError;
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void onDeleteTradeProduct(int? id, {String? name}) {
    popupConfirm(
        content: Text("Xác nhận xóa $name", style: TextStyles.def, textAlign: TextAlign.center)
    ).serious(onTap: () async {
      loadingFullScreen();
      final response = await deleteTrademarkProductAPI(id);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          final list = onTriggerEvent<ProductTrademarkCubit>().state;
          int index = list.indexWhere((value) => value.id == id);
          list.removeAt(index);
          onTriggerEvent<ProductTrademarkCubit>().getListTrademark(list);
        } else {
          errorSnackBar(message: "Không thể xóa danh mục $name");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }

  void onChangeTrademark(int? id, String? name, String? description)
  => findController<ProductController>().onOpenAddEditTrademark(name: name, id: id, description: description);
}
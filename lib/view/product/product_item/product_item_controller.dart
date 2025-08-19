import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_list_product.dart';
import 'package:spa_project/model/response/model_list_product.dart';
import 'package:spa_project/view/product/product_item/product_item_cubit.dart';
import 'package:spa_project/view/product/product_item_add_edit/product_item_add_edit_screen.dart';

import '../product_item_add_edit/product_item_add_edit_controller.dart';

class ProductItemController extends BaseController with Repository {
  ProductItemController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    final list = context.read<ProductItemCubit>().state;
    if(list.isEmpty) onGetListProduct(true);
    super.onInitState();
  }

  ReqListProduct get _request => ReqListProduct(
    page: 1,
  );

  void onGetListProduct(bool isLoad) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listProductAPI(_request);
    if(response is Success<ModelListProduct>) {
      if(response.value.code == Result.isOk) {
        setScreenState = screenStateOk;
        onTriggerEvent<ProductItemCubit>().getListProduct(response.value.data ?? []);
      } else {
        setScreenState = screenStateError;
        errorWidget = Utilities.errorMesWidget("Không tải được dữ liệu");
      }
    }
    if(response is Failure<ModelListProduct>) {
      setScreenState = screenStateError;
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void onToChangeProduct(Data data) {
    Navigator.pushNamed(context,
      ProductItemAddEditScreen.router,
      arguments: data
    ).then((value) {
      if(value is ResultChangeProduct && value.result == Result.isOk) {
        if(!value.isDelete) onGetListProduct(false);
        if(value.isDelete) {
          final list = onTriggerEvent<ProductItemCubit>().state;
          int index = list.indexWhere((item) => item.id == data.id);
          list.removeAt(index);
          onTriggerEvent<ProductItemCubit>().getListProduct(list);
        }
      }
    });
  }
}
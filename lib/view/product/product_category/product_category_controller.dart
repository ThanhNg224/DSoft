import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_cate_product.dart';
import 'package:spa_project/view/product/product_category/product_category_cubit.dart';
import 'package:spa_project/view/product/product_controller.dart';

class ProductCategoryController extends BaseController with Repository {
  ProductCategoryController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    final list = context.read<ProductCategoryCubit>().state;
    if(list.isEmpty) onGetCateProduct(true);
    super.onInitState();
  }

  void onGetCateProduct(bool isLoad) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listCategoryProductAPI(1);
    if(response is Success<ModelListCateProduct>) {
      if(response.value.code == Result.isOk) {
        setScreenState = screenStateOk;
        onTriggerEvent<ProductCategoryCubit>().getListCateProduct(response.value.data ?? []);
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được danh sách");
      }
    }
    if(response is Failure<ModelListCateProduct>) {
      setScreenState = screenStateError;
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void onDeleteCateProduct(int? id, {String? name}) {
    popupConfirm(
      content: Text("Xác nhận xóa $name", style: TextStyles.def, textAlign: TextAlign.center),
      title: "Xóa danh mục"
    ).serious(onTap: () async {
      loadingFullScreen();
      final response = await deleteCategoryProductAPI(id: id);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          final list = onTriggerEvent<ProductCategoryCubit>().state;
          int index = list.indexWhere((value) => value.id == id);
          list.removeAt(index);
          onTriggerEvent<ProductCategoryCubit>().getListCateProduct(list);
        } else {
          errorSnackBar(message: "Không thể xóa danh mục $name");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }

  void onChangeCategory(int? id, String? name)
  => findController<ProductController>().onOpenAddEditCateProduct(name: name, id: id);
}
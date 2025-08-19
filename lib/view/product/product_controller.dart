import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/product/product_category/product_category_controller.dart';
import 'package:spa_project/view/product/product_item/product_item_controller.dart';
import 'package:spa_project/view/product/product_item_add_edit/product_item_add_edit_controller.dart';
import 'package:spa_project/view/product/product_item_add_edit/product_item_add_edit_screen.dart';
import 'package:spa_project/view/product/product_partner/product_partner_controller.dart';
import 'package:spa_project/view/product/product_partner/product_partner_cubit.dart';
import 'package:spa_project/view/product/product_partner_add_edit/product_partner_add_edit_screen.dart';
import 'package:spa_project/view/product/product_trademark/product_trademark_controller.dart';

class ProductController extends BaseController with Repository {
  ProductController(super.context);

  TextEditingController cNameCate = TextEditingController();
  TextEditingController cNameTrade = TextEditingController();
  TextEditingController cTradeDescription = TextEditingController();

  void handleRouter(int page) {
    if(page == 2) {
      onOpenAddEditTrademark();
    } else if(page == 1) {
      onOpenAddEditCateProduct();
    } else if(page == 3) {
      onToAddEditProductPartner();
    } else {
      onToAddEditProductItem();
    }
  }

  void onOpenAddEditCateProduct({int? id, String? name}) {
    cNameCate.clear();
    if(id != null) cNameCate = TextEditingController(text: name);
    popupConfirm(
      title: id != null ? "Cập nhật danh mục" : "Thêm danh mục mới",
      content: WidgetInput(
        title: "Tên danh mục",
        controller: cNameCate,
        hintText: "Nhập tên danh mục",
      )
    ).confirm(onConfirm: () async {
      if(cNameCate.text.isEmpty) {
        warningSnackBar(message: "Vui lòng nhập tên danh mục");
        return;
      }
      loadingFullScreen();
      final response = await addCategoryProductAPI(name: cNameCate.text, id: id);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          findController<ProductCategoryController>().onGetCateProduct(false);
          cNameCate.clear();
          successSnackBar(message: "Tạo mới ${cNameCate.text} thành công");
        } else {
          errorSnackBar(message: "Lỗi khi thêm danh mục");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode));
      }
    });
  }

  void onOpenAddEditTrademark({int? id, String? name, String? description}) {
    cNameTrade.clear();
    cTradeDescription.clear();
    if(id != null) {
      cNameTrade = TextEditingController(text: name);
      cTradeDescription = TextEditingController(text: description);
    }
    popupConfirm(
      title: id != null ? "Cập nhật nhãn hiệu" : "Thêm danh nhãn hiệu",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetInput(
            title: "Tên nhãn hiệu",
            controller: cNameTrade,
            hintText: "Nhập tên nhãn hiệu",
          ),
          WidgetInput(
            title: "Mô tả",
            controller: cTradeDescription,
            hintText: "Nhập mô tả",
            maxLines: 3,
          ),
        ],
      )
    ).confirm(onConfirm: () async {
      if(cNameTrade.text.isEmpty) {
        warningSnackBar(message: "Vui lòng nhập tên nhãn hiệu");
        return;
      }
      loadingFullScreen();
      final response = await addTrademarkProductAPI(name: cNameTrade.text, id: id,
          description: cTradeDescription.text);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          findController<ProductTrademarkController>().onGetListTrademark(false);
          cNameTrade.clear();
          cTradeDescription.clear();
          successSnackBar(message: "Tạo mới ${cNameTrade.text} thành công");
        } else {
          errorSnackBar(message: "Lỗi khi thêm danh mục");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode));
      }
    });
  }

  void onToAddEditProductItem() {
    Navigator.pushNamed(context, ProductItemAddEditScreen.router).then((value) {
      if(value is ResultChangeProduct && value.result == Result.isOk) {
        findController<ProductItemController>().onGetListProduct(false);
      }
    });
  }

  void onToAddEditProductPartner({int? index}) {
    final controller = findController<ProductPartnerController>();
    Navigator.pushNamed(context,
      ProductPartnerAddEditScreen.router,
      arguments: index != null ? controller.onTriggerEvent<ProductPartnerCubit>().state[index] : null
    ).then((value) {
      if(value == Result.isOk) {
        controller.onGetListPartner(isLoad: false);
      }
    });
  }

  @override
  void onDispose() {
    cNameCate.dispose();
    cTradeDescription.dispose();
    cNameTrade.dispose();
    super.onDispose();
  }
}
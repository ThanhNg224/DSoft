import 'dart:convert';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_cart.dart';
import 'package:spa_project/model/request/req_create_order.dart';
import 'package:spa_project/model/request/req_import_product.dart';
import 'package:spa_project/model/request/req_list_product.dart';
import 'package:spa_project/model/response/model_list_product.dart';
import 'package:spa_project/model/response/model_partner.dart';
import 'package:spa_project/view/product/product_partner_add_edit/product_partner_add_edit_screen.dart';
import 'package:spa_project/view/product/product_screen.dart';
import 'package:spa_project/view/warehouse_import/bloc/warehouse_import_bloc.dart';

class WarehouseImportController extends BaseController<int> with Repository {
  WarehouseImportController(super.context);

  Widget errorWidget = const SizedBox();
  final GetListProduct getListProduct = GetListProduct();
  final GetListPartner getListPartner = GetListPartner();

  @override
  void onInitState() {
    onGetMulti();
    super.onInitState();
  }


  void onGetMulti() async {
    setScreenState = screenStateLoading;
    final e = await Future.wait([
      getListProduct.perform(),
      getListPartner.perform(),
    ]);
    for(var item in e) {
      if(!item.isNotError) {
        errorWidget = item.logo;
        setScreenState = screenStateError;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  void toAddProduct() {
    pushName(ProductScreen.router).whenComplete(() => getListProduct.perform());
  }

  void toAddPartner() {
    pushName(ProductPartnerAddEditScreen.router).whenComplete(() => getListPartner.perform());
  }

  void onChoseProduct(ModelAddCart value, WarehouseImportState state, int index) {
    final newList = List<ModelAddCart>.from(state.listImport);
    if (newList.any((item) => item.id == value.id)) {
      newList.removeWhere((item) => item.id == value.id);
    } else {
      newList.add(value);
    }
    onTriggerEvent<WarehouseImportBloc>().add(ChoseProductWarehouseImportEvent(newList));
  }

  void popupProduct() {
    popupBottom(child: SizedBox(
      width: double.infinity,
      child: BlocProvider.value(
        value: onTriggerEvent<WarehouseImportBloc>(),
        child: BlocBuilder<WarehouseImportBloc, WarehouseImportState>(
          builder: (context, state) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Utilities.screen(context).h * 0.8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Row(
                  children: [
                    Expanded(child: Text("Chọn sản phẩm vào kho", style: TextStyles.def.bold)),
                    IconButton(
                      onPressed: pop,
                      icon: const Icon(Icons.clear)
                    ),
                  ],
                ),
                if(state.listProduct.isEmpty) Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, ProductScreen.router),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, color: MyColor.slateBlue),
                        const SizedBox(width: 7),
                        Text("Thêm sản phẩm", style: TextStyles.def.bold.colors(MyColor.slateBlue)),
                      ],
                    )
                  ),
                ) else Expanded(
                  child: WidgetGridView.builder(
                    itemCount: state.listProduct.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final isSelected = state.listImport.any((item) => item.id == state.listProduct[index].id);
                      return GestureDetector(
                        onTap: () => onChoseProduct(ModelAddCart(
                          image: state.listProduct[index].image,
                          id: state.listProduct[index].id,
                          name: state.listProduct[index].name,
                          price: state.listProduct[index].price ?? 0,
                        ), state, index),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Positioned.fill(child: WidgetImage(imageUrl: state.listProduct[index].image)),
                                SizedBox(
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [MyColor.black.o0, MyColor.black.o7],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(state.listProduct[index].name ?? "Đang cập nhật",
                                        style: TextStyles.def.bold.size(12).colors(MyColor.white),
                                        maxLines: 1, overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                if(isSelected) ColoredBox(
                                  color: MyColor.black.o3,
                                  child: const Center(child: Icon(Icons.check, color: MyColor.green, size: 80,)),
                                )
                              ],
                            )
                        ),
                      );
                    },
                  )
                )
              ]),
            );
          }
        ),
      ),
    ));
  }

  void onImportProduct(WarehouseImportState state) async {
    final totalQuantity = state.listImport.fold<int>(0,
      (previousValue, item) => previousValue + item.quantityController.text.removeCommaMoney,
    );
    if(totalQuantity <= 0) return warningSnackBar(message: "Vui lòng chọn ít nhất sản phẩm");

    loadingFullScreen();
    final response = await addProductWarehouseAPI(ReqImportProduct(
      idWarehouse: args,
      dataOrder: jsonEncode(
        state.listImport.map((item) => DataOrderProduct(
          quantity: item.quantityController.text.removeCommaMoney,
          price: item.price,
          idProduct: item.id,
        ).toJson()).toList()
      ),
      idPartner: state.chosePartner?.id,
      partnerName: state.chosePartner?.name,
    ));
    hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        pop();
      } else {
        errorSnackBar(message: "Không thể nhập kho hàng");
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }

}

class GetListProduct with Repository {

  Future<ExceptionMultiApi> perform() async {
    final response = await listProductAPI(ReqListProduct(page: 1));
    if(response is Success<ModelListProduct>) {
      if(response.value.code == Result.isOk) {
        findController<WarehouseImportController>()
            .onTriggerEvent<WarehouseImportBloc>()
            .add(GetProductWarehouseImportEvent(response
            .value.data ?? []));
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không lấy được danh sách sản phẩm"));
      }
    }
    if(response is Failure<ModelListProduct>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}

class GetListPartner with Repository {

  Future<ExceptionMultiApi> perform() async {
    final response = await listPartnerAPI(1);
    if(response is Success<ModelListPartner>) {
      if(response.value.code == Result.isOk) {
        findController<WarehouseImportController>()
            .onTriggerEvent<WarehouseImportBloc>()
            .add(GetPartnerWarehouseImportEvent(response
            .value.data ?? []));
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không lấy được danh sách thương hiệu"));
      }
    }
    if(response is Failure<ModelListPartner>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}
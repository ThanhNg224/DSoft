import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_cart.dart';
import 'package:spa_project/model/request/req_get_list_service.dart';
import 'package:spa_project/model/request/req_list_product.dart';
import 'package:spa_project/model/response/model_list_combo.dart';
import 'package:spa_project/model/response/model_list_product.dart';
import 'package:spa_project/model/response/model_list_service.dart';
import 'package:spa_project/model/response/model_prepaid_card.dart';
import 'package:spa_project/view/order/order_add_cart/bloc/order_add_cart_bloc.dart';
import 'package:spa_project/view/order/order_create_info/order_create_info_controller.dart';
import 'package:spa_project/view/order/order_create_info/order_create_info_cubit.dart';

class OrderAddCartController extends BaseController with Repository {
  OrderAddCartController(super.context);

  int page = 1;
  Widget errorWidget = const SizedBox();
  bool isProductOrder = findController<OrderCreateInfoController>().isProductOrder;
  bool isServiceOrder = findController<OrderCreateInfoController>().isServiceOrder;
  bool isComboOrder = findController<OrderCreateInfoController>().isComboOrder;
  bool isPrepaidCard = findController<OrderCreateInfoController>().isPrepaidCard;

  late GetServiceList getServiceList = GetServiceList();
  late GetListProduct getListProduct = GetListProduct();
  late GetListCombo getListCombo = GetListCombo();
  late GetListPrepaidCard getListPrepaidCard = GetListPrepaidCard();

  @override
  void onInitState() {
    handleInitGetApi();
    final currentState = findController<OrderCreateInfoController>()
        .onTriggerEvent<OrderCreateInfoCubit>()
        .state;
    final List<ModelAddCart> list = List.from(currentState.listCart);
    if(list.isEmpty) return;
    onTriggerEvent<OrderAddCartBloc>().add(
      AddCartOrderAddCartEvent(list),
    );
    super.onInitState();
  }

  void onAddToCart(ModelAddCart data, int indexProduct) {
    final currentState = onTriggerEvent<OrderAddCartBloc>().state;
    final List<ModelAddCart> list = List.from(currentState.listCart);
    final int index = list.indexWhere((item) => item.id == data.id);
    if (isProductOrder) {
      final int availableQuantity = currentState.listProduct[indexProduct].quantity ?? 0;
      final int currentQuantity = index >= 0 ? list[index].quantity : 0;
      if (availableQuantity == 0 || currentQuantity >= availableQuantity) {
        return warningSnackBar(message: "Sản phẩm này đã hết");
      }
      _actionAddToCart(data, index, list);
    } else if (isServiceOrder) {
      _actionAddToCart(data, index, list);
    } else {
      _actionAddToCart(data, index, list);
    }
    findController<OrderCreateInfoController>()
        .onTriggerEvent<OrderCreateInfoCubit>()
        .setListAddCart(list);

    onTriggerEvent<OrderAddCartBloc>().add(AddCartOrderAddCartEvent(list));
  }

  void _actionAddToCart(ModelAddCart data, int index, List<ModelAddCart> list) {
    if (index >= 0) {
      list[index] = list[index].copyWith(quantity: list[index].quantity + 1);
    } else {
      list.insert(0, data);
      findController<OrderCreateInfoController>().listKey.currentState?.insertItem(0);
    }
  }

  void handleInitGetApi() {
    if(isProductOrder) {
      getListProduct.onGetListProduct();
    } else if(isServiceOrder) {
      getServiceList.getList();
    } else if(isComboOrder) {
      getListCombo.onGetListCombo();
    } else if(isPrepaidCard) {
      getListPrepaidCard.onGetListPrepaid();
    } else {
      return;
    }
  }

  String handleTitleAppBar() {
    if(isProductOrder) {
      return "sản phẩm";
    } else if(isServiceOrder) {
      return "dịch vụ";
    } else if(isComboOrder) {
      return "combo";
    } else if(isPrepaidCard) {
      return "thẻ tiền trước";
    } else {
      return "";
    }
  }
}

class GetServiceList with Repository {
  // int _page = 1;
  final _i = findController<OrderAddCartController>();

  void getList() async {
    _i.setScreenState = _i.screenStateLoading;
    final response = await listServiceAPI(ReqGetListService(
      page: 1
    ));
    if(response is Success<ModelListService>) {
      if(response.value.code == Result.isOk) {
        _i.onTriggerEvent<OrderAddCartBloc>().add(GetListServiceOrderAddCartEvent(response.value.data ?? []));
        _i.setScreenState = _i.screenStateOk;
      } else {
        _i.errorWidget = Utilities.errorMesWidget("Không thể lấy danh sách dịch vụ");
        _i.setScreenState = _i.screenStateError;
      }
    }
    if(response is Failure<ModelListService>) {
      _i.errorWidget = Utilities.errorCodeWidget(response.errorCode);
      _i.setScreenState = _i.screenStateError;
    }
  }
}

class GetListProduct with Repository {

  final _i = findController<OrderAddCartController>();

  ReqListProduct get _request => ReqListProduct(
    page: 1,
  );

  void onGetListProduct({bool isLoad = true}) async {
    if(isLoad) _i.setScreenState = _i.screenStateLoading;
    final response = await listProductAPI(_request);
    if(response is Success<ModelListProduct>) {
      if(response.value.code == Result.isOk) {
        _i.setScreenState = _i.screenStateOk;
        _i.onTriggerEvent<OrderAddCartBloc>().add(GetListOrderAddCartEvent(response.value.data ?? []));
      } else {
        _i.setScreenState = _i.screenStateError;
        _i.errorWidget = Utilities.errorMesWidget("Không tải được dữ liệu");
      }
    }
    if(response is Failure<ModelListProduct>) {
      _i.setScreenState = _i.screenStateError;
      _i.errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }
}

class GetListCombo with Repository {
  final _i = findController<OrderAddCartController>();

  void onGetListCombo({bool isLoad = true}) async {
    if(isLoad) _i.setScreenState = _i.screenStateLoading;
    final response = await listComboAPI(_i.page);
    if(response is Success<ModelListCombo>) {
      if(response.value.code == Result.isOk) {
        _i.setScreenState = _i.screenStateOk;
        _i.onTriggerEvent<OrderAddCartBloc>().add(GetListComboOrderAddCartEvent(response.value.data ?? []));
      } else {
        _i.setScreenState = _i.screenStateError;
        _i.errorWidget = Utilities.errorMesWidget("Không tải được dữ liệu");
      }
    }
    if(response is Failure<ModelListCombo>) {
      _i.setScreenState = _i.screenStateError;
      _i.errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }
}

class GetListPrepaidCard with Repository {
  final _i = findController<OrderAddCartController>();

  void onGetListPrepaid({bool isLoad = true}) async {
    if(isLoad) _i.setScreenState = _i.screenStateLoading;
    final response = await listPrepayCardAPI(_i.page);
    if(response is Success<ModelPrepaidCard>) {
      if(response.value.code == Result.isOk) {
        _i.setScreenState = _i.screenStateOk;
        _i.onTriggerEvent<OrderAddCartBloc>().add(GetListPrepaidOrderAddCartEvent(response.value.data ?? []));
      } else {
        _i.setScreenState = _i.screenStateError;
        _i.errorWidget = Utilities.errorMesWidget("Không tải được dữ liệu");
      }
    }
    if(response is Failure<ModelPrepaidCard>) {
      _i.setScreenState = _i.screenStateError;
      _i.errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }
}
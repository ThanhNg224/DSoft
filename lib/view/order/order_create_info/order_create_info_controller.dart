import 'dart:convert';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_cart.dart';
import 'package:spa_project/model/common/model_search_customer.dart';
import 'package:spa_project/model/request/req_create_order.dart';
import 'package:spa_project/model/request/req_get_list_staff.dart';
import 'package:spa_project/model/response/model_diagram_room_bed.dart';
import 'package:spa_project/model/response/model_list_repo.dart';
import 'package:spa_project/model/response/model_list_staff.dart';
import 'package:spa_project/view/book_add_edit/bloc/view_search_cubit.dart';
import 'package:spa_project/view/book_add_edit/view_search_customer.dart';
import 'package:spa_project/view/diagram_room_bed/diagram_room_bed_controller.dart';
import 'package:spa_project/view/order/order_create_info/order_create_info_cubit.dart';
import 'package:spa_project/view/order/order_prepaid_card/order_prepaid_card_controller.dart';
import 'package:spa_project/view/order/order_product/order_product_controller.dart';
import 'package:spa_project/view/order/order_service/order_service_controller.dart';
import 'package:spa_project/view/order/order_treatment/order_treatment_controller.dart';

class OrderCreateInfoController extends BaseController<ToOrderCreateInfo> with Repository {
  OrderCreateInfoController(super.context);

  bool isProductOrder = false;
  bool isServiceOrder = false;
  bool isComboOrder = false;
  bool isReceptionService = false;
  bool isPrepaidCard = false;

  ModelSearchCustomer nameCustomer = ModelSearchCustomer();
  final ServiceDateTimePicker dateTimePicker = ServiceDateTimePicker();
  DateTime dateTimeValue = DateTime.now();
  Widget errorWidget = const SizedBox();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  TextEditingController cDeCreasePrice = TextEditingController();
  TextEditingController cNote = TextEditingController();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final hasBedData = args?.bedData != null;

      isProductOrder = args?.type == OrderCreateInfoType.product;
      isServiceOrder = args?.type == OrderCreateInfoType.service;
      isComboOrder = args?.type == OrderCreateInfoType.comboTreatment;
      isReceptionService = isServiceOrder && hasBedData;
      isPrepaidCard = args?.type == OrderCreateInfoType.prepaidCard;
      if(isReceptionService) onTriggerEvent<OrderCreateInfoCubit>().setBtnTitleCreateInfoCubit("Nhận khách");
      print("isServiceOrder");
      print(isServiceOrder);
      print(isReceptionService);
    });
    onGetMultiple();
    super.onInitState();
  }

  void onOpenViewSearch() {
    Navigator.push(context, PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, _, __) => BlocProvider(
        create: (_)=> ViewSearchCubit(),
        child: const ViewSearchCustomer(isLimitedByRegion: true),
      ),
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    )).then((value) {
      if(value == null) return;
      final data = value as ModelSearchCustomer;
      nameCustomer.name = data.name;
      nameCustomer.id = data.id;
    });
  }

  void onOpenSelectDateTime() async {
    final time = await dateTimePicker.open(context);
    dateTimeValue = time;
  }

  void onGetMultiple() async {
    setScreenState = screenStateLoading;
    final listException = await Future.wait([
      GetListRepo().perform(),
      GetListStaff().perform(),
    ]);
    for(var item in listException) {
      if(!item.isNotError) {
        setScreenState = screenStateError;
        errorWidget = item.logo;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  void onRemoteItemInCart(
      int index,
      OrderCreateInfoState state,
      Widget Function(int index, OrderCreateInfoState state, Animation<double> animation) buildAnimatedItem) {
    final currentList = List<ModelAddCart>.from(state.listCart);
    listKey.currentState?.removeItem(
      index, (context, animation) => buildAnimatedItem(index, state, animation),
      duration: const Duration(milliseconds: 300),
    );
    currentList.removeAt(index);
    onTriggerEvent<OrderCreateInfoCubit>().setListAddCart(currentList);
  }

  void onIncrease(int index, OrderCreateInfoState state) {
    final listCart = List<ModelAddCart>.from(state.listCart);
    final updatedItem = listCart[index].copyWith(
      quantity: (listCart[index].quantity) + 1,
    );
    listCart[index] = updatedItem;
    onTriggerEvent<OrderCreateInfoCubit>().setListAddCart(listCart);
  }

  void onDecrease(int index, OrderCreateInfoState state) {
    final currentList = List<ModelAddCart>.from(state.listCart);
    final updatedItem = currentList[index].copyWith(
      quantity: (currentList[index].quantity) - 1,
    );
    if(currentList[index].quantity == 1) return;
    currentList[index] = updatedItem;
    onTriggerEvent<OrderCreateInfoCubit>().setListAddCart(currentList);
  }

  int makeMoney(List<ModelAddCart> list) {
    return list.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  int finalMoney(List<ModelAddCart> list) {
    final int originalMoney = makeMoney(list);
    final old = cDeCreasePrice.text.removeCommaMoney;
    if (old > 100) {
      return originalMoney - old;
    } else {
      return (originalMoney - (originalMoney * old / 100)).round();
    }
  }

  String nameOrder({bool capitalize = false}) {
    String name;
    if (isProductOrder) {
      name = "sản phẩm";
    } else if (isServiceOrder) {
      name = "dịch vụ";
    } else if (isComboOrder) {
      name = "combo";
    } else if(isPrepaidCard) {
      name = "thẻ trả trước";
    } else {
      name = "";
    }
    if (capitalize && name.isNotEmpty) {
      name = name[0].toUpperCase() + name.substring(1);
    }
    return name;
  }

  void handlePayment(OrderCreateInfoState state) {
    if (isProductOrder) {
      PaymentWithProduct().onComplete(state);
    } else if (isServiceOrder) {
      PaymentWithService().onComplete(state);
    } else if (isComboOrder) {
      PaymentWithCombo().onComplete(state);
    } else if(isPrepaidCard) {
      PaymentWithPrepaidCard().onComplete(state);
    } else {
      return;
    }
  }

  @override
  void onDispose() {
    cDeCreasePrice.dispose();
    cNote.dispose();
    super.onDispose();
  }

}

class GetListRepo with Repository {

  Future<ExceptionMultiApi> perform() async {
    final response = await listWarehouseAPI(1);
    if(response is Success<ModelListRepo>) {
      if(response.value.code == Result.isOk) {
        findController<OrderCreateInfoController>()
            .onTriggerEvent<OrderCreateInfoCubit>()
            .getRepoOrderCreateInfoCubit(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo:
        Utilities.errorMesWidget("Không thể lấy danh sách nhân viên"));
      }
    }
    if(response is Failure<ModelListRepo>) {
      return ExceptionMultiApi.error(logo:
      Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}

class GetListStaff with Repository {

  Future<ExceptionMultiApi> perform() async {
    final response = await listStaffAPI(ReqGetListStaff(page: 1));
    if(response is Success<ModelListStaff>) {
      if(response.value.code == Result.isOk) {
        findController<OrderCreateInfoController>()
            .onTriggerEvent<OrderCreateInfoCubit>()
            .getStaffOrderCreateInfoCubit(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo:
        Utilities.errorMesWidget("Không thể lấy danh sách nhân viên"));
      }
    }
    if(response is Failure<ModelListStaff>) {
      return ExceptionMultiApi.error(logo:
      Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
}

class PaymentWithProduct with Repository {

  final _internal = findController<OrderCreateInfoController>();

  bool _validator(OrderCreateInfoState state) {
    if(state.listCart.isEmpty) {
      _internal.warningSnackBar(message: "Chọn ít nhất 1 sản phẩm");
      return false;
    }
    String vaName = _internal.nameCustomer.name == null ? "Vui lòng nhập tên khách hàng" : "";
    String vaRepo = state.choseRepo == null ? "Vui lòng nhập kho" : "";
    String vaStaff = state.choseStaff == null ? "Vui lòng chọn nhân viên" : "";
    String vaPaymentMethod = state.chosePaymentMethod == null ? "Vui lòng chọn phương thức thanh toán" : "";
    _internal.onTriggerEvent<OrderCreateInfoCubit>().setValidator(
        vaStaff: vaStaff,
        vaRepo: vaRepo,
        vaPaymentMethod: vaPaymentMethod,
        vaName: vaName
    );
    return vaName.isEmpty
        && vaPaymentMethod.isEmpty
        && vaStaff.isEmpty
        && vaRepo.isEmpty;
  }

  void onComplete(OrderCreateInfoState state) async {
    if(!_validator(state)) return _internal.warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
    _internal.loadingFullScreen();
    final response = await createOrderProductAPI(ReqCreateOrder(
        idCustomer: _internal.nameCustomer.id,
        note: _internal.cNote.text,
        typeCollectionBill: state.chosePaymentMethod?.keyValue,
        dataOrder: jsonEncode(
            state.listCart.map((item) => DataOrderProduct(
              quantity: item.quantity,
              price: item.price,
              idProduct: item.id,
            ).toJson()).toList()
        ),
        idSpa: Utilities.getIdSpaDefault,
        idStaff: state.choseStaff?.id,
        promotion: _internal.cDeCreasePrice.text.removeCommaMoney,
        total: _internal.makeMoney(state.listCart),
        totalPay: _internal.finalMoney(state.listCart),
        idWarehouse: state.choseRepo?.id
    ));
    _internal.hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        findController<OrderProductController>().onGetListOrderProduct(false);
        _internal.pop();
        _internal.successSnackBar(message: "Đơn sản phẩm vừa tạo thành công");
      } else {
        _internal.errorSnackBar(message: response.value == 3
            ? "Sản phẩm trong kho không đủ"
            : "Không thể tạo đơn hàng"
        );
      }
    }
    if(response is Failure<int>) {
      _internal.popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }
}

class PaymentWithService with Repository {

  final _internal = findController<OrderCreateInfoController>();

  bool _validator(OrderCreateInfoState state) {
    if(state.listCart.isEmpty) {
      _internal.warningSnackBar(message: "Chọn ít nhất 1 sản phẩm");
      return false;
    }
    String vaName = _internal.nameCustomer.name == null ? "Vui lòng nhập tên khách hàng" : "";
    String vaStaff = state.choseStaff == null ? "Vui lòng chọn nhân viên" : "";
    String vaPaymentMethod = state.chosePaymentMethod == null ? "Vui lòng chọn phương thức thanh toán" : "";
    _internal.onTriggerEvent<OrderCreateInfoCubit>().setValidator(
        vaStaff: vaStaff,
        vaPaymentMethod: vaPaymentMethod,
        vaName: vaName
    );
    return !_internal.isReceptionService ? vaName.isEmpty
        && vaPaymentMethod.isEmpty
        && vaStaff.isEmpty : vaName.isEmpty
        && vaStaff.isEmpty;
  }

  void onComplete(OrderCreateInfoState state) async {
    if(!_validator(state)) return _internal.warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
    _internal.loadingFullScreen();
    final response = await createOrderServiceAPI(ReqCreateOrder(
        idCustomer: _internal.nameCustomer.id,
        note: _internal.cNote.text,
        typeCollectionBill: state.chosePaymentMethod?.keyValue,
        typeOrder: _internal.isReceptionService ? 3 : 1,
        dataOrder: jsonEncode(
          state.listCart.map((item) => DataOrderService(
            quantity: item.quantity,
            price: item.price,
            idService: item.id,
          ).toJson()).toList()
        ),
        idSpa: Utilities.getIdSpaDefault,
        idStaff: state.choseStaff?.id,
        promotion: _internal.cDeCreasePrice.text.removeCommaMoney,
        total: _internal.makeMoney(state.listCart),
        totalPay: _internal.finalMoney(state.listCart),
        idWarehouse: state.choseRepo?.id,
        idBed: _internal.args?.bedData?.id,
    ));
    _internal.hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        if(_internal.isServiceOrder) {
          _internal.isReceptionService
              ? findController<DiagramRoomBedController>().onGetDiagram(isLoad: false)
              : findController<OrderServiceController>().onGetListOrderService(isLoad: false);
        } else {
          _internal.errorSnackBar(message: "Đã có lỗi xảy ra vui lòng thực hiện lại");
        }
        // _internal.pop();
        _internal.successSnackBar(message: "Đơn ${_internal.nameOrder()} vừa tạo thành công");
      } else {
        _internal.errorSnackBar(message: "Không thể tạo đơn hàng");
      }
    }
    if(response is Failure<int>) {
      _internal.popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }
}

class PaymentWithCombo with Repository {

  final _internal = findController<OrderCreateInfoController>();

  bool _validator(OrderCreateInfoState state) {
    if(state.listCart.isEmpty) {
      _internal.warningSnackBar(message: "Chọn ít nhất 1 sản phẩm");
      return false;
    }
    String vaName = _internal.nameCustomer.name == null ? "Vui lòng nhập tên khách hàng" : "";
    String vaStaff = state.choseStaff == null ? "Vui lòng chọn nhân viên" : "";
    String vaPaymentMethod = state.chosePaymentMethod == null ? "Vui lòng chọn phương thức thanh toán" : "";
    _internal.onTriggerEvent<OrderCreateInfoCubit>().setValidator(
        vaStaff: vaStaff,
        vaPaymentMethod: vaPaymentMethod,
        vaName: vaName
    );
    return vaName.isEmpty
        && vaPaymentMethod.isEmpty
        && vaStaff.isEmpty;
  }

  void onComplete(OrderCreateInfoState state) async {
    if(!_validator(state)) return _internal.warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
    _internal.loadingFullScreen();
    final response = await createComboAPI(ReqCreateOrder(
        idCustomer: _internal.nameCustomer.id,
        note: _internal.cNote.text,
        typeCollectionBill: state.chosePaymentMethod?.keyValue,
        dataOrder: jsonEncode(
            state.listCart.map((item) => DataOrderCombo(
              quantity: item.quantity,
              price: item.price,
              idCombo: item.id,
            ).toJson()).toList()
        ),
        idSpa: Utilities.getIdSpaDefault,
        idStaff: state.choseStaff?.id,
        promotion: _internal.cDeCreasePrice.text.removeCommaMoney,
        total: _internal.makeMoney(state.listCart),
        totalPay: _internal.finalMoney(state.listCart),
        idWarehouse: state.choseRepo?.id
    ));
    _internal.hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        findController<OrderTreatmentController>().onGetListOrderCombo(isLoad: false);
        _internal.pop();
        _internal.successSnackBar(message: "Đơn ${_internal.nameOrder()} vừa tạo thành công");
      } else if(response.value == 3) {
        _internal.errorSnackBar(message: "Số lượng combo đã hết");
      } else {
        _internal.errorSnackBar(message: "Không thể tạo đơn hàng");
      }
    }
    if(response is Failure<int>) {
      _internal.popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }
}

class PaymentWithPrepaidCard with Repository {
  final _internal = findController<OrderCreateInfoController>();

  bool _validator(OrderCreateInfoState state) {
    if(state.listCart.isEmpty) {
      _internal.warningSnackBar(message: "Chọn ít nhất 1 sản phẩm");
      return false;
    }
    String vaName = _internal.nameCustomer.name == null ? "Vui lòng nhập tên khách hàng" : "";
    String vaStaff = state.choseStaff == null ? "Vui lòng chọn nhân viên" : "";
    String vaPaymentMethod = state.chosePaymentMethod == null ? "Vui lòng chọn phương thức thanh toán" : "";
    _internal.onTriggerEvent<OrderCreateInfoCubit>().setValidator(
        vaStaff: vaStaff,
        vaPaymentMethod: vaPaymentMethod,
        vaName: vaName
    );
    return vaName.isEmpty
        && vaPaymentMethod.isEmpty
        && vaStaff.isEmpty;
  }

  void onComplete(OrderCreateInfoState state) async {
    if(!_validator(state)) return _internal.warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
    _internal.loadingFullScreen();
    final response = await buyPrepayCardAPI(ReqCreateOrder(
        idCustomer: _internal.nameCustomer.id,
        note: _internal.cNote.text,
        typeCollectionBill: state.chosePaymentMethod?.keyValue,
        dataOrder: jsonEncode(
            state.listCart.map((item) => DataOrderPrepaidCard(
              quantity: item.quantity,
              price: item.price,
              idPrepayCard: item.id,
              priceSell: item.priceSell
            ).toJson()).toList()
        ),
        idStaff: state.choseStaff?.id,
        promotion: _internal.cDeCreasePrice.text.removeCommaMoney,
        total: _internal.makeMoney(state.listCart),
        totalPay: _internal.finalMoney(state.listCart),
        idWarehouse: state.choseRepo?.id
    ));
    _internal.hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        findController<OrderPrepaidCardController>().onGetListOrderPrepaidCard(isLoad: false);
        _internal.pop();
        _internal.successSnackBar(message: "Đơn ${_internal.nameOrder()} vừa tạo thành công");
      } else {
        _internal.errorSnackBar(message: "Không thể tạo đơn hàng");
      }
    }
    if(response is Failure<int>) {
      _internal.popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }
}

class ToOrderCreateInfo {
  OrderCreateInfoType type;
  Bed? bedData;

  ToOrderCreateInfo({required this.type, this.bedData});
}
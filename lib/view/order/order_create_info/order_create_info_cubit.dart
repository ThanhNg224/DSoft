import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_cart.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_list_repo.dart' as repo;
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/view/order/order_create_info/order_create_info_controller.dart';

class OrderCreateInfoCubit extends Cubit<OrderCreateInfoState> {
  OrderCreateInfoCubit() : super(OrderCreateInfoState(
    choseStaff: staff.Data(
      name: findController<OrderCreateInfoController>().os.modelMyInfo?.data?.name,
      id: findController<OrderCreateInfoController>().os.modelMyInfo?.data?.id
    )
  ));

  void setValidator({
    String? vaName,
    String? vaPaymentMethod,
    String? vaRepo,
    String? vaStaff
  }) => emit(state.copyWith(
    vaName: vaName,
    vaPaymentMethod: vaPaymentMethod,
    vaRepo: vaRepo,
    vaStaff: vaStaff
  ));

  void getRepoOrderCreateInfoCubit(List<repo.Data>? listRepo)
  => emit(state.copyWith(listRepo: listRepo));

  void getStaffOrderCreateInfoCubit(List<staff.Data>? listStaff)
  => emit(state.copyWith(listStaff: listStaff));

  void setListAddCart(List<ModelAddCart>? listCart)
  => emit(state.copyWith(listCart: listCart));

  void choseCreateInfoCubit({
    repo.Data? choseRepo,
    staff.Data? choseStaff,
    ModelPaymentMethod? chosePaymentMethod,
  }) => emit(state.copyWith(
    choseStaff: choseStaff,
    choseRepo: choseRepo,
    chosePaymentMethod: chosePaymentMethod
  ));

  void setTypeDeCreaseIsPercent(bool? value)
  => emit(state.copyWith(isPercent: value));

  void setBtnTitleCreateInfoCubit(String? title)
  => emit(state.copyWith(btnTitle: title));
}


class OrderCreateInfoState {
  String vaName;
  String vaRepo;
  String vaStaff;
  String vaPaymentMethod;
  List<repo.Data> listRepo;
  List<staff.Data> listStaff;
  List<ModelAddCart> listCart;
  repo.Data? choseRepo;
  staff.Data? choseStaff;
  ModelPaymentMethod? chosePaymentMethod;
  bool isPercent;
  String btnTitle;

  OrderCreateInfoState({
    this.vaName = "",
    this.vaRepo = "",
    this.vaStaff = "",
    this.vaPaymentMethod = "",
    this.listStaff = const [],
    this.listRepo = const [],
    this.listCart = const [],
    this.chosePaymentMethod,
    this.choseRepo,
    this.choseStaff,
    this.isPercent = true,
    this.btnTitle = "Thanh toán"
  });

  OrderCreateInfoState copyWith({
    String? vaName,
    List<repo.Data>? listRepo,
    List<staff.Data>? listStaff,
    List<ModelAddCart>? listCart,
    repo.Data? choseRepo,
    staff.Data? choseStaff,
    ModelPaymentMethod? chosePaymentMethod,
    bool? isPercent,
    String? vaRepo,
    String? vaStaff,
    String? vaPaymentMethod,
    String? btnTitle
  }) => OrderCreateInfoState(
    vaName: vaName ?? this.vaName,
    vaPaymentMethod: vaPaymentMethod ?? this.vaPaymentMethod,
    vaRepo: vaRepo ?? this.vaRepo,
    vaStaff: vaStaff ?? this.vaStaff,
    listRepo: listRepo ?? this.listRepo,
    listStaff: listStaff ?? this.listStaff,
    listCart: listCart ?? this.listCart,
    chosePaymentMethod: chosePaymentMethod ?? this.chosePaymentMethod,
    choseRepo: choseRepo ?? this.choseRepo,
    choseStaff: choseStaff ?? this.choseStaff,
    isPercent: isPercent ?? this.isPercent,
    btnTitle: btnTitle ?? this.btnTitle
  );
}
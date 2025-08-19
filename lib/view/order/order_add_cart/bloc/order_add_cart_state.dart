part of 'order_add_cart_bloc.dart';

class OrderAddCartState {
  List<product.Data> listProduct;
  List<ModelAddCart> listCart;
  List<service.Data> listService;
  List<combo.Data> listCombo;
  List<prepaid.Data> listPrepaid;

  OrderAddCartState({
    this.listProduct = const [],
    this.listCart = const [],
    this.listService = const [],
    this.listCombo = const [],
    this.listPrepaid = const [],
  });

  OrderAddCartState copyWith({
    List<product.Data>? listProduct,
    List<ModelAddCart>? listCart,
    List<service.Data>? listService,
    List<combo.Data>? listCombo,
    List<prepaid.Data>? listPrepaid,
  }) => OrderAddCartState(
    listProduct: listProduct ?? this.listProduct,
    listCart: listCart ?? this.listCart,
    listService: listService ?? this.listService,
    listCombo: listCombo ?? this.listCombo,
    listPrepaid: listPrepaid ?? this.listPrepaid,
  );
}

class InitOrderAddCartState extends OrderAddCartState {}
part of 'order_add_cart_bloc.dart';

class OrderAddCartEvent {}

class GetListOrderAddCartEvent extends OrderAddCartEvent {
  List<product.Data>? listProduct;
  GetListOrderAddCartEvent(this.listProduct);
}

class AddCartOrderAddCartEvent extends OrderAddCartEvent {
  List<ModelAddCart>? listCart;
  AddCartOrderAddCartEvent(this.listCart);
}

class GetListServiceOrderAddCartEvent extends OrderAddCartEvent {
  List<service.Data>? listService;
  GetListServiceOrderAddCartEvent(this.listService);
}

class GetListComboOrderAddCartEvent extends OrderAddCartEvent {
  List<combo.Data>? listCombo;
  GetListComboOrderAddCartEvent(this.listCombo);
}

class GetListPrepaidOrderAddCartEvent extends OrderAddCartEvent {
  List<prepaid.Data>? listPrepaid;
  GetListPrepaidOrderAddCartEvent(this.listPrepaid);
}
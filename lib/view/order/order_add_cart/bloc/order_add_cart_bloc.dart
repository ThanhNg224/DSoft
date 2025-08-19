import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_cart.dart';
import 'package:spa_project/model/response/model_list_combo.dart' as combo;
import 'package:spa_project/model/response/model_list_product.dart' as product;
import 'package:spa_project/model/response/model_list_service.dart' as service;
import 'package:spa_project/model/response/model_prepaid_card.dart' as prepaid;

part 'order_add_cart_event.dart';
part 'order_add_cart_state.dart';

class OrderAddCartBloc extends Bloc<OrderAddCartEvent, OrderAddCartState> {
  OrderAddCartBloc() : super(InitOrderAddCartState()) {
    on<GetListOrderAddCartEvent>((event, emit) {
      emit(state.copyWith(listProduct: event.listProduct));
    });
    on<AddCartOrderAddCartEvent>((event, emit) {
      emit(state.copyWith(listCart: event.listCart));
    });
    on<GetListServiceOrderAddCartEvent>((event, emit) {
      emit(state.copyWith(listService: event.listService));
    });
    on<GetListComboOrderAddCartEvent>((event, emit) {
      emit(state.copyWith(listCombo: event.listCombo));
    });
    on<GetListPrepaidOrderAddCartEvent>((event, emit) {
      emit(state.copyWith(listPrepaid: event.listPrepaid));
    });
  }
}
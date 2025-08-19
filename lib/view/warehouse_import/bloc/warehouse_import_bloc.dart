import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_cart.dart';
import 'package:spa_project/model/response/model_list_product.dart' as product;
import 'package:spa_project/model/response/model_partner.dart' as partner;

part 'warehouse_import_event.dart';
part 'warehouse_import_state.dart';

class WarehouseImportBloc extends Bloc<WarehouseImportEvent, WarehouseImportState> {
  WarehouseImportBloc() : super(InitWarehouseImportState()) {
    on<GetProductWarehouseImportEvent>((event, emit) {
      emit(state.copyWith(listProduct: event.listProduct));
    });
    on<GetPartnerWarehouseImportEvent>((event, emit) {
      emit(state.copyWith(listPartner: event.listPartner));
    });
    on<SetPartnerWarehouseImportEvent>((event, emit) {
      emit(state.copyWith(chosePartner: event.value));
    });
    on<ChoseProductWarehouseImportEvent>((event, emit) {
      emit(state.copyWith(listImport: event.listImport));
    });
  }

}

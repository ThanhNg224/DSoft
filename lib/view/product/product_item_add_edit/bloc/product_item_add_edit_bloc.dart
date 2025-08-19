
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_cate_product.dart';
import 'package:spa_project/model/response/model_list_trademark.dart';

part 'product_item_add_edit_event.dart';
part 'product_item_add_edit_state.dart';

class ProductItemAddEditBloc extends Bloc<ProductItemAddEditEvent, ProductItemAddEditState> {
  ProductItemAddEditBloc() : super(InitProductItemAddEditState()) {
    on<GetListCateProductItemAddEditEvent>((event, emit) {
      emit(state.copyWith(listCate: event.listCate));
    });
    on<GetListTradeProductItemAddEditEvent>((event, emit) {
      emit(state.copyWith(listTrademark: event.listTrademark));
    });
    on<ChoseImageProductItemAddEditEvent>((event, emit) {
      emit(state.copyWith(fileImage: event.image));
    });
    on<ValidateProductItemAddEditEvent>((event, emit) {
      emit(state.copyWith(
        vaName: event.vaName,
        vaCate: event.vaCate,
        vaPrice: event.vaPrice,
        vaTrademark: event.vaTrademark,
      ));
    });
    on<ChangeStatusProductItemAddEditEvent>((event, emit) {
      int value = state.statusProduct == StatusAccountStaff.isLock
          ? StatusAccountStaff.isActive
          : StatusAccountStaff.isLock;
      emit(state.copyWith(statusProduct: value));
    });
    on<ChoseDropDowProductItemAddEditEvent>((event, emit) {
      emit(state.copyWith(
        choseTrademark: event.choseTrademark,
        choseCate: event.choseCate
      ));
    });
    on<ChangeSlideProductItemAddEditEvent>((event, emit) {
      emit(state.copyWith(
        commissionStaffPercent: event.commissionStaffPercent,
        commissionAffiliatePercent: event.commissionAffiliatePercent
      ));
    });
    on<SetTitleViewProductItemAddEditEvent>((event, emit) {
      emit(state.copyWith(titleView: event.titleView));
    });
  }
}
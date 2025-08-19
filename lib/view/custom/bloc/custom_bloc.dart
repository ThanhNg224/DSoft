
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spa_project/model/response/model_category_customer.dart' as cate;
import 'package:spa_project/model/response/model_list_source_custom.dart' as source;
import '../../../model/response/model_list_customer.dart' as customer;

part 'custom_event.dart';
part 'custom_state.dart';

class CustomBloc extends Bloc<CustomEvent, CustomState> {
  CustomBloc() : super(InitCustomState()) {
    on<InitCustomEvent>((event, emit) {
      emit(InitCustomState());
    });
    on<GetListCustomEvent>((event, emit) {
      emit(state.copyWith(listCustomer: event.response));
    });
    on<SetStateLoadingSearchCustomEvent>((event, emit) {
      emit(state.copyWith(isLoadingSearch: event.value));
    });
    on<GetListCateCustomEvent>((event, emit) {
      emit(state.copyWith(listCate: event.listCate));
    });
    on<GetListSourceCustomEvent>((event, emit) {
      emit(state.copyWith(listSource: event.listSource));
    });
    on<SetPageIndexCustomEvent>((event, emit) {
      emit(state.copyWith(pageIndex: event.value));
    });
  }
}
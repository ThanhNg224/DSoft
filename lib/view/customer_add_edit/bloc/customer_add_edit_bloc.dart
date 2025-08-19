
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_gender.dart';
import 'package:spa_project/model/response/model_category_customer.dart' as cate;
import 'package:spa_project/model/response/model_detail_customer.dart';
import 'package:spa_project/model/response/model_list_source_custom.dart' as source;

part 'customer_add_edit_event.dart';
part 'customer_add_edit_state.dart';

class CustomerAddEditBloc extends Bloc<CustomerAddEditEvent, CustomerAddEditState> {
  CustomerAddEditBloc() : super(InitCustomerAddEditState()) {
    on<SetAvatarCustomerAddEditEvent>((event, emit) {
      emit(state.copyWith(avatar: event.avatar));
    });
    on<SetValidateCustomerAddEditEvent>((event, emit) {
      emit(state.copyWith(vaName: event.vaName, vaPhone: event.vaPhone));
    });
    on<SelectGenderCustomerAddEditEvent>((event, emit) {
      emit(state.copyWith(currentGender: event.gender, setGenderNull: event.setGenderNull));
    });
    on<SetStatusCustomerAddEditEvent>((event, emit) {
      emit(state.copyWith(isAddCustomer: event.value));
    });
    on<GetListCateCustomerAddEditEvent>((event, emit) {
      emit(state.copyWith(listCate: event.listCate));
    });
    on<GetListSourceCustomerAddEditEvent>((event, emit) {
      emit(state.copyWith(listSource: event.listSource));
    });
    on<ChoseDropDowCustomerAddEditEvent>((event, emit) {
      emit(state.copyWith(selectCate: event.selectCate, selectSource: event.selectSource));
    });
  }
}
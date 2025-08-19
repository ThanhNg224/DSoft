import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_category_service.dart' as cate;
import 'package:spa_project/model/response/model_list_service.dart' as ser;

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(InitServiceState()) {
    on<SetPageViewServiceEvent>((event, emit) {
      emit(state.copyWith(pageIndex: event.page));
    });
    on<GetListCateServiceEvent>((event, emit) {
      emit(state.copyWith(listCate: event.listCate));
    });
    on<GetListServiceServiceEvent>((event, emit) {
      emit(state.copyWith(listService: event.listService));
    });
    on<SetCateSelectServiceEvent>((event, emit) {
      emit(state.copyWith(cateSelect: event.cateSelect));
    });
  }
}
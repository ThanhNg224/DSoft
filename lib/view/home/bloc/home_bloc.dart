
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_bil_statistical.dart' as bil;
import 'package:spa_project/model/response/model_business_report.dart';
import 'package:spa_project/model/response/model_list_book.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitHomeState()) {
    on<InitHomeEvent>((event, emit) {
      emit(InitHomeState());
    });
    on<GetBusinessReportHomeEvent>((event, emit) {
      emit(state.copyWith(report: event.response));
    });
    on<GetListCustomerBookHomeEvent>((event, emit) {
      emit(state.copyWith(listBook: event.response));
    });
    on<GetListBilStatistical>((event, emit) {
      emit(state.copyWith(listBilStatistical: event.response));
    });
    on<ChangePageHomeEvent>((event, emit) {
      emit(state.copyWith(page: event.page));
    });
  }
}
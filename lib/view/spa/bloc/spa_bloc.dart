import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_spa.dart' as lis_spa;

part 'spa_state.dart';
part 'spa_event.dart';

class SpaBloc extends Bloc<SpaEvent, SpaState> {
  SpaBloc() : super(InitSpaState()) {
    on<GetListSpaEvent>((event, emit) {
      emit(state.copyWith(listSpa: event.value));
    });
  }
}
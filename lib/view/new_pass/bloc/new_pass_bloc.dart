
import 'package:spa_project/base_project/package.dart';

part 'new_pass_state.dart';
part 'new_pass_event.dart';

class NewPassBloc extends Bloc<NewPassEvent, NewPassState> {
  NewPassBloc() : super(InitNewPassState()) {
    on<InitNewPassEvent>((event, emit) {
      emit(InitNewPassState());
    });
    on<ValidateNewPassEvent>((event, emit) {
      emit(state.copyWith(
        validatePass: event.vaPass,
        validatePassConfirm: event.vaPassConfirm
      ));
    });
    on<ShowNewPassEvent>((event, emit) {
      emit(state.copyWith(
        showPass: event.showPass,
        showPassConfirm: event.showPassConfirm
      ));
    });
  }
}
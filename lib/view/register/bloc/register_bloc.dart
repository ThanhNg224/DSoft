
import 'package:spa_project/base_project/package.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(InitRegisterState()) {
    on<InitRegisterEvent>((event, emit) {
      emit(InitRegisterState());
    });
    on<HideShowPassRegisterEvent>((event, emit) {
      emit(state.copyWith(
        isShowPass: event.isShowPass,
        isShowConfirm: event.isShowConfirm
      ));
    });
    on<ValidateRegisterEvent>((event, emit) {
      emit(state.copyWith(
        vaName: event.vaName,
        vaPass: event.vaPass,
        vaPassConfirm: event.vaPassConfirm,
        vaPhone: event.vaPhone
      ));
    });
  }
}
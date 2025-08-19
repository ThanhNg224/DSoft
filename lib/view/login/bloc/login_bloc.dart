
import 'package:spa_project/base_project/package.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<InitLoginEvent>((event, emit) {
      emit(InitLoginState());
    });
    on<OnShowPassWorkEvent>((event, emit) {
      emit(state.copyWith(isShowPassWork: event.isShowPassWork));
    });
    on<SetScrollingEvent>((event, emit) {
      emit(state.copyWith(scrolling: event.scrolling));
    });
    on<SetValidateEvent>((event, emit) {
      emit(state.copyWith(
        validatePassword: event.validatePassword,
        validateNumber: event.validateNumber
      ));
    });
    on<RememberMeLoginEvent>((event, emit) {
      emit(state.copyWith(rememberMe: event.isRememberMe));
    });
  }
}
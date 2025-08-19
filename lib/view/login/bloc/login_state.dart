part of 'login_bloc.dart';

class LoginState {
  bool isShowPassWork;
  bool scrolling;
  String validateNumber;
  String validatePassword;
  bool rememberMe;
  LoginState({
    this.isShowPassWork = false,
    this.scrolling = false,
    this.validateNumber = "",
    this.validatePassword = "",
    this.rememberMe = false
  });

  LoginState copyWith({
    bool? isShowPassWork,
    bool? scrolling,
    String? validateNumber,
    String? validatePassword,
    bool? rememberMe,
  }) {
    return LoginState(
      isShowPassWork: isShowPassWork ?? this.isShowPassWork,
      scrolling: scrolling ?? this.scrolling,
      validateNumber: validateNumber ?? this.validateNumber,
      validatePassword: validatePassword ?? this.validatePassword,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}

class InitLoginState extends LoginState {}
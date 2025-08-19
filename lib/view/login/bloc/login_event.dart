part of 'login_bloc.dart';

class LoginEvent {
  bool? isShowPassWork;
  bool? scrolling;
  String? validateNumber;
  String? validatePassword;
  LoginEvent({
    this.isShowPassWork, this.scrolling,
    this.validatePassword, this.validateNumber
  });
}

class InitLoginEvent extends LoginEvent {}

class OnShowPassWorkEvent extends LoginEvent {
  OnShowPassWorkEvent(bool value) : super(isShowPassWork: value);
}

class SetScrollingEvent extends LoginEvent {
  SetScrollingEvent(bool value) : super(scrolling: value);
}

class SetValidateEvent extends LoginEvent {
  SetValidateEvent({
    String? validateNum, String? validatePass
  }) : super(validateNumber: validateNum, validatePassword: validatePass);
}

class RememberMeLoginEvent extends LoginEvent {
  bool isRememberMe;
  RememberMeLoginEvent(this.isRememberMe);
}
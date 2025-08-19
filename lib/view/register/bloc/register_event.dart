
part of 'register_bloc.dart';

class RegisterEvent {}

class InitRegisterEvent extends RegisterEvent {}

class HideShowPassRegisterEvent extends RegisterEvent {
  bool? isShowPass;
  bool? isShowConfirm;

  HideShowPassRegisterEvent({this.isShowPass, this.isShowConfirm});
}

class ValidateRegisterEvent extends RegisterEvent {
  String? vaName;
  String? vaPhone;
  String? vaPass;
  String? vaPassConfirm;

  ValidateRegisterEvent({
    this.vaPhone,
    this.vaPassConfirm,
    this.vaPass,
    this.vaName,
  });
}
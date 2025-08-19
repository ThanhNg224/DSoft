
part of 'new_pass_bloc.dart';

class NewPassEvent {}

class InitNewPassEvent extends NewPassEvent {}

class ValidateNewPassEvent extends NewPassEvent {
  String? vaPass;
  String? vaPassConfirm;

  ValidateNewPassEvent({
    this.vaPass, this.vaPassConfirm
  });
}

class ShowNewPassEvent extends NewPassEvent {
  bool? showPass;
  bool? showPassConfirm;

  ShowNewPassEvent({
    this.showPass,
    this.showPassConfirm
  });
}
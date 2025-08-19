
part of 'new_pass_bloc.dart';

class NewPassState {
  bool showPass;
  bool showPassConfirm;
  String validatePass;
  String validatePassConfirm;

  NewPassState({
    this.showPass = false,
    this.showPassConfirm = false,
    this.validatePass = "",
    this.validatePassConfirm = "",
  });

  NewPassState copyWith({
    bool? showPass,
    bool? showPassConfirm,
    String? validatePass,
    String? validatePassConfirm,
  }) {
    return NewPassState(
      showPass: showPass ?? this.showPass,
      showPassConfirm: showPassConfirm ?? this.showPassConfirm,
      validatePass: validatePass ?? this.validatePass,
      validatePassConfirm: validatePassConfirm ?? this.validatePassConfirm,
    );
  }
}

class InitNewPassState extends NewPassState {}
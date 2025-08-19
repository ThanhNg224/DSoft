
part of 'register_bloc.dart';

class RegisterState {
  bool isShowPass;
  bool isShowConfirm;
  String vaName;
  String vaPhone;
  String vaPass;
  String vaPassConfirm;

  RegisterState({
    this.isShowConfirm = false,
    this.isShowPass = false,
    this.vaName = '',
    this.vaPass = '',
    this.vaPassConfirm = '',
    this.vaPhone = '',
  });

  RegisterState copyWith({
    bool? isShowPass,
    bool? isShowConfirm,
    String? vaName,
    String? vaPhone,
    String? vaPass,
    String? vaPassConfirm,
  }) => RegisterState(
    isShowPass: isShowPass ?? this.isShowPass,
    isShowConfirm: isShowConfirm ?? this.isShowConfirm,
    vaName: vaName ?? this.vaName,
    vaPhone: vaPhone ?? this.vaPhone,
    vaPass: vaPass ?? this.vaPass,
    vaPassConfirm: vaPassConfirm ?? this.vaPassConfirm,
  );
}

class InitRegisterState extends RegisterState {}
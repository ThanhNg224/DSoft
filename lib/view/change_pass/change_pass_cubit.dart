import 'package:spa_project/base_project/package.dart';

class ChangePassState {
  String vaPass;
  String vaPassNew;
  String vaPassConfirm;
  bool showPass;
  bool showPassNew;
  bool showPassConfirm;

  ChangePassState({
    this.vaPass = "",
    this.vaPassNew = "",
    this.vaPassConfirm = "",
    this.showPass = false,
    this.showPassNew = false,
    this.showPassConfirm = false,
  });

  ChangePassState copyWith({
    String? vaPass,
    String? vaPassNew,
    String? vaPassConfirm,
    bool? showPass,
    bool? showPassNew,
    bool? showPassConfirm,
  }) => ChangePassState(
    vaPass: vaPass ?? this.vaPass,
    vaPassConfirm: vaPassConfirm ?? this.vaPassConfirm,
    vaPassNew: vaPassNew ?? this.vaPassNew,
    showPass: showPass ?? this.showPass,
    showPassConfirm: showPassConfirm ?? this.showPassConfirm,
    showPassNew: showPassNew ?? this.showPassNew
  );
}

class InitChangePassState extends ChangePassState {}

class ChangePassCubit extends Cubit<ChangePassState> {
  ChangePassCubit() : super(InitChangePassState()) {
    initChangePass();
  }

  void initChangePass() => emit(InitChangePassState());

  void validateChangePassEvent({
    String? vaPass,
    String? vaPassNew,
    String? vaPassConfirm,
  }) => emit(state.copyWith(
    vaPass: vaPass,
    vaPassNew: vaPassNew,
    vaPassConfirm: vaPassConfirm,
  ));

  void showPassEvent() => emit(state.copyWith(showPass: !state.showPass));

  void showPassNewEvent() => emit(state.copyWith(showPassNew: !state.showPassNew));

  void showPassConfirmEvent() => emit(state.copyWith(showPassConfirm: !state.showPassConfirm));
}
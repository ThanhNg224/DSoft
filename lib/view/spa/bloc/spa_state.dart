part of 'spa_bloc.dart';

class SpaState {
  List<lis_spa.Data> listSpa;

  SpaState({this.listSpa = const []});

  SpaState copyWith({
    List<lis_spa.Data>? listSpa,
  }) => SpaState(
    listSpa: listSpa ?? this.listSpa
  );
}

class InitSpaState extends SpaState {}
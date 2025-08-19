part of 'spa_bloc.dart';

class SpaEvent {}

class GetListSpaEvent extends SpaEvent {
  List<lis_spa.Data> value;

  GetListSpaEvent(this.value);
}
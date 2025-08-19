
part of 'home_bloc.dart';

class HomeEvent {}

class InitHomeEvent extends HomeEvent {}

class GetBusinessReportHomeEvent extends HomeEvent {
  ModelBusinessReport response;
  GetBusinessReportHomeEvent(this.response);
}

class GetListCustomerBookHomeEvent extends HomeEvent {
  ModelListBook response;
  GetListCustomerBookHomeEvent(this.response);
}

class GetListBilStatistical extends HomeEvent {
  List<bil.Data> response;
  GetListBilStatistical(this.response);
}

class ChangePageHomeEvent extends HomeEvent {
  int? page;
  ChangePageHomeEvent(this.page);
}

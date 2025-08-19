part of 'service_bloc.dart';

class ServiceEvent {}

class SetPageViewServiceEvent extends ServiceEvent {
  int? page;
  SetPageViewServiceEvent(this.page);
}

class GetListCateServiceEvent extends ServiceEvent {
  List<cate.Data>? listCate;
  GetListCateServiceEvent(this.listCate);
}

class GetListServiceServiceEvent extends ServiceEvent {
  List<ser.Data>? listService;
  GetListServiceServiceEvent(this.listService);
}

class SetCateSelectServiceEvent extends ServiceEvent {
  cate.Data? cateSelect;
  SetCateSelectServiceEvent(this.cateSelect);
}
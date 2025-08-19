part of 'service_bloc.dart';

class ServiceState {
  int pageIndex;
  List<cate.Data> listCate;
  List<ser.Data> listService;
  cate.Data? cateSelect;

  ServiceState({
    this.pageIndex = 0,
    this.listService = const [],
    this.listCate = const [],
    this.cateSelect
  });

  ServiceState copyWith({
    int? pageIndex,
    List<cate.Data>? listCate,
    List<ser.Data>? listService,
    cate.Data? cateSelect
  }) => ServiceState(
    pageIndex: pageIndex ?? this.pageIndex,
    listCate: listCate ?? this.listCate,
    listService: listService ?? this.listService,
    cateSelect: cateSelect ?? this.cateSelect
  );
}

class InitServiceState extends ServiceState {}
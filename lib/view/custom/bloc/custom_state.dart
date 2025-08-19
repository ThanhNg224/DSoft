
part of 'custom_bloc.dart';

class CustomState {
  List<customer.Data> listCustomer;
  bool isLoadingSearch;
  List<cate.Category> listCate;
  List<source.Data> listSource;
  int pageIndex;

  CustomState({
    this.listCustomer = const [],
    this.listCate = const [],
    this.listSource = const [],
    this.isLoadingSearch = false,
    this.pageIndex = 0
  });

  CustomState copyWith({
    List<customer.Data>? listCustomer,
    List<cate.Category>? listCate,
    List<source.Data>? listSource,
    bool? isLoadingSearch,
    int? pageIndex
  }) => CustomState(
    listCustomer: listCustomer ?? this.listCustomer,
    isLoadingSearch: isLoadingSearch ?? this.isLoadingSearch,
    listCate: listCate ?? this.listCate,
    listSource: listSource ?? this.listSource,
    pageIndex: pageIndex ?? this.pageIndex,
  );
}

class InitCustomState extends CustomState {}
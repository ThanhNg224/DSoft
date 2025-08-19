
part of 'custom_bloc.dart';

class CustomEvent {}

class InitCustomEvent extends CustomEvent {}

class GetListCustomEvent extends CustomEvent {
  List<customer.Data>? response;

  GetListCustomEvent(this.response);
}

class SetStateLoadingSearchCustomEvent extends CustomEvent {
  bool? value;
  SetStateLoadingSearchCustomEvent(this.value);
}

class GetListCateCustomEvent extends CustomEvent {
  List<cate.Category>? listCate;
  GetListCateCustomEvent(this.listCate);
}

class GetListSourceCustomEvent extends CustomEvent {
  List<source.Data>? listSource;
  GetListSourceCustomEvent(this.listSource);
}

class SetPageIndexCustomEvent extends CustomEvent {
  int? value;
  SetPageIndexCustomEvent(this.value);
}
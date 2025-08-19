
part of 'customer_add_edit_bloc.dart';

class CustomerAddEditEvent {}

class SetAvatarCustomerAddEditEvent extends CustomerAddEditEvent {
  String avatar;
  SetAvatarCustomerAddEditEvent(this.avatar);
}

class SetValidateCustomerAddEditEvent extends CustomerAddEditEvent {
  String? vaName;
  String? vaPhone;

  SetValidateCustomerAddEditEvent({this.vaName, this.vaPhone});
}

class SelectGenderCustomerAddEditEvent extends CustomerAddEditEvent {
  ModelGender? gender;
  bool setGenderNull;
  SelectGenderCustomerAddEditEvent({this.gender, this.setGenderNull = false});
}

class SetStatusCustomerAddEditEvent extends CustomerAddEditEvent {
  bool value;
  SetStatusCustomerAddEditEvent(this.value);
}

class GetListCateCustomerAddEditEvent extends CustomerAddEditEvent {
  List<cate.Category>? listCate;
  GetListCateCustomerAddEditEvent(this.listCate);
}

class GetListSourceCustomerAddEditEvent extends CustomerAddEditEvent {
  List<source.Data>? listSource;
  GetListSourceCustomerAddEditEvent(this.listSource);
}

class ChoseDropDowCustomerAddEditEvent extends CustomerAddEditEvent {
  cate.Category? selectCate;
  source.Data? selectSource;
  ChoseDropDowCustomerAddEditEvent({this.selectCate, this.selectSource});
}
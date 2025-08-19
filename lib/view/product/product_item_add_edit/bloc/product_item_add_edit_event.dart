part of 'product_item_add_edit_bloc.dart';

class ProductItemAddEditEvent {}

class GetListCateProductItemAddEditEvent extends ProductItemAddEditEvent {
  List<ModelDetailCateProduct>? listCate;
  GetListCateProductItemAddEditEvent(this.listCate);
}

class GetListTradeProductItemAddEditEvent extends ProductItemAddEditEvent {
  List<Data>? listTrademark;
  GetListTradeProductItemAddEditEvent(this.listTrademark);
}

class ChangeStatusProductItemAddEditEvent extends ProductItemAddEditEvent {}

class ChoseImageProductItemAddEditEvent extends ProductItemAddEditEvent {
  String? image;
  ChoseImageProductItemAddEditEvent(this.image);
}

class ValidateProductItemAddEditEvent extends ProductItemAddEditEvent {
  String? vaName;
  String? vaPrice;
  String? vaCate;
  String? vaTrademark;
  ValidateProductItemAddEditEvent({this.vaTrademark, this.vaPrice, this.vaCate, this.vaName});
}

class ChoseDropDowProductItemAddEditEvent extends ProductItemAddEditEvent {
  ModelDetailCateProduct? choseCate;
  Data? choseTrademark;
  ChoseDropDowProductItemAddEditEvent({this.choseTrademark, this.choseCate});
}

class SetTitleViewProductItemAddEditEvent extends ProductItemAddEditEvent {
  String? titleView;
  SetTitleViewProductItemAddEditEvent(this.titleView);
}

class ChangeSlideProductItemAddEditEvent extends ProductItemAddEditEvent {
  int? commissionStaffPercent;
  int? commissionAffiliatePercent;
  ChangeSlideProductItemAddEditEvent({
    this.commissionStaffPercent,
    this.commissionAffiliatePercent
  });
}
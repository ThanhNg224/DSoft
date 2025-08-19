part of 'product_item_add_edit_bloc.dart';

class ProductItemAddEditState {
  List<ModelDetailCateProduct> listCate;
  List<Data> listTrademark;
  int statusProduct;
  String fileImage;
  String vaName;
  String vaPrice;
  String vaCate;
  String vaTrademark;
  ModelDetailCateProduct? choseCate;
  Data? choseTrademark;
  int commissionStaffPercent;
  int commissionAffiliatePercent;
  String titleView;

  ProductItemAddEditState({
    this.listCate = const [],
    this.listTrademark = const [],
    this.statusProduct = 1,
    this.fileImage = "",
    this.vaName = "",
    this.vaPrice = "",
    this.vaCate = "",
    this.vaTrademark = "",
    this.choseCate,
    this.titleView = "Thêm sản phẩm",
    this.choseTrademark,
    this.commissionStaffPercent = 0,
    this.commissionAffiliatePercent = 0,
  });

  ProductItemAddEditState copyWith({
    List<ModelDetailCateProduct>? listCate,
    List<Data>? listTrademark,
    int? statusProduct,
    String? fileImage,
    String? vaName,
    String? vaPrice,
    String? vaCate,
    String? titleView,
    String? vaTrademark,
    ModelDetailCateProduct? choseCate,
    Data? choseTrademark,
    int? commissionStaffPercent,
    int? commissionAffiliatePercent,
  }) => ProductItemAddEditState(
    listCate: listCate ?? this.listCate,
    listTrademark: listTrademark ?? this.listTrademark,
    statusProduct: statusProduct ?? this.statusProduct,
    fileImage: fileImage ?? this.fileImage,
    vaName: vaName ?? this.vaName,
    vaCate: vaCate ?? this.vaCate,
    vaPrice: vaPrice ?? this.vaPrice,
    vaTrademark: vaTrademark ?? this.vaTrademark,
    choseCate: choseCate ?? this.choseCate,
    choseTrademark: choseTrademark ?? this.choseTrademark,
    commissionAffiliatePercent: commissionAffiliatePercent ?? this.commissionAffiliatePercent,
    commissionStaffPercent: commissionStaffPercent ?? this.commissionStaffPercent,
    titleView: titleView ?? this.titleView
  );
}

class InitProductItemAddEditState extends ProductItemAddEditState {}
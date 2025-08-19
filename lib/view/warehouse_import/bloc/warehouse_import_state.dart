part of 'warehouse_import_bloc.dart';

class WarehouseImportState {
  List<product.Data> listProduct;
  List<partner.Data> listPartner;
  partner.Data ? chosePartner;
  List<ModelAddCart> listImport;

  WarehouseImportState({
    this.listProduct = const [],
    this.listPartner = const [],
    this.listImport = const [],
    this.chosePartner
  });

  WarehouseImportState copyWith({
    List<product.Data>? listProduct,
    List<partner.Data>? listPartner,
    partner.Data? chosePartner,
    List<ModelAddCart>? listImport
  }) => WarehouseImportState(
    listProduct: listProduct ?? this.listProduct,
    listPartner: listPartner ?? this.listPartner,
    chosePartner: chosePartner ?? this.chosePartner,
    listImport: listImport ?? this.listImport,
  );
}

class InitWarehouseImportState extends WarehouseImportState {}
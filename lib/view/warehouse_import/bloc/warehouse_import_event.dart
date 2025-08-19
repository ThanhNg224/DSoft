part of 'warehouse_import_bloc.dart';

class WarehouseImportEvent {}

class GetProductWarehouseImportEvent extends WarehouseImportEvent {
  List<product.Data>? listProduct;
  GetProductWarehouseImportEvent(this.listProduct);
}

class GetPartnerWarehouseImportEvent extends WarehouseImportEvent {
  List<partner.Data> listPartner;
  GetPartnerWarehouseImportEvent(this.listPartner);
}

class SetPartnerWarehouseImportEvent extends WarehouseImportEvent {
  partner.Data? value;
  SetPartnerWarehouseImportEvent(this.value);
}

class ChoseProductWarehouseImportEvent extends WarehouseImportEvent {
  List<ModelAddCart>? listImport;
  ChoseProductWarehouseImportEvent(this.listImport);
}
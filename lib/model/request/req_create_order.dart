class ReqCreateOrder {
  String? dataOrder;
  int? idCustomer;
  int? idBed;
  int? promotion;
  int? total;
  int? totalPay;
  String? typeCollectionBill;
  int? idCard;
  String? note;
  int? idStaff;
  int? idWarehouse;
  int? typeOrder;
  int? idSpa;

  ReqCreateOrder(
      {this.dataOrder,
        this.idCustomer,
        this.idBed,
        this.promotion,
        this.total,
        this.totalPay,
        this.typeCollectionBill,
        this.idCard,
        this.note,
        this.idWarehouse,
        this.typeOrder,
        this.idSpa,
        this.idStaff});

  ReqCreateOrder.fromJson(Map<String, dynamic> json) {
    dataOrder = json['data_order'];
    idCustomer = json['id_customer'];
    idBed = json['id_bed'];
    promotion = json['promotion'];
    total = json['total'];
    totalPay = json['total_pay'];
    typeCollectionBill = json['type_collection_bill'];
    idCard = json['id_card'];
    idWarehouse = json['id_warehouse'];
    note = json['note'];
    idStaff = json['id_staff'];
    typeOrder = json['typeOrder'];
    idSpa = json['id_spa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (idCustomer != null) data['id_customer'] = idCustomer;
    if (dataOrder != null) data['data_order'] = dataOrder;
    if (idBed != null) data['id_bed'] = idBed;
    if (promotion != null) data['promotion'] = promotion;
    if (total != null) data['total'] = total;
    if (totalPay != null) data['total_pay'] = totalPay;
    if (typeCollectionBill != null) data['type_collection_bill'] = typeCollectionBill;
    if (idCard != null) data['id_card'] = idCard;
    if (note != null) data['note'] = note;
    if (idWarehouse != null) data['id_warehouse'] = idWarehouse;
    if (idStaff != null) data['id_staff'] = idStaff;
    if (typeOrder != null) data['typeOrder'] = typeOrder;
    if (idSpa != null) data['id_spa'] = idSpa;
    return data;
  }
}

class DataOrderProduct {
  int? idProduct;
  int? quantity;
  int? price;

  DataOrderProduct({this.idProduct, this.quantity, this.price});

  DataOrderProduct.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = idProduct;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class DataOrderService {
  int? idService;
  int? quantity;
  int? price;

  DataOrderService({this.idService, this.quantity, this.price});

  DataOrderService.fromJson(Map<String, dynamic> json) {
    idService = json['id_service'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_service'] = idService;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class DataOrderCombo {
  int? idCombo;
  int? quantity;
  int? price;

  DataOrderCombo({this.idCombo, this.quantity, this.price});

  DataOrderCombo.fromJson(Map<String, dynamic> json) {
    idCombo = json['id_combo'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_combo'] = idCombo;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class DataOrderPrepaidCard {
  int? idPrepayCard;
  int? quantity;
  int? price;
  int? priceSell;

  DataOrderPrepaidCard({this.idPrepayCard, this.quantity, this.price, this.priceSell});

  DataOrderPrepaidCard.fromJson(Map<String, dynamic> json) {
    idPrepayCard = json['id_prepaycard'];
    quantity = json['quantity'];
    price = json['price'];
    priceSell = json['price_sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_prepaycard'] = idPrepayCard;
    data['quantity'] = quantity;
    data['price'] = price;
    data['price_sell'] = priceSell;
    return data;
  }
}

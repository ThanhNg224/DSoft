class ModelWarehouseHistory {
  List<Data>? data;
  int? code;
  String? messages;
  int? totalData;

  ModelWarehouseHistory({this.data, this.code, this.messages, this.totalData});

  ModelWarehouseHistory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    messages = json['messages'];
    totalData = json['totalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['messages'] = messages;
    data['totalData'] = totalData;
    return data;
  }
}

class Data {
  int? id;
  int? idMember;
  int? idSpa;
  int? idStaff;
  int? idWarehouse;
  int? idPartner;
  int? createdAt;
  Warehouse? warehouse;
  Parent? parent;
  List<Product>? product;

  Data(
      {this.id,
        this.idMember,
        this.idSpa,
        this.idStaff,
        this.idWarehouse,
        this.idPartner,
        this.createdAt,
        this.warehouse,
        this.parent,
        this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    idStaff = json['id_staff'];
    idWarehouse = json['id_warehouse'];
    idPartner = json['id_partner'];
    createdAt = json['created_at'];
    warehouse = json['Warehouse'] != null
        ? Warehouse.fromJson(json['Warehouse'])
        : null;
    parent =
    json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['id_staff'] = idStaff;
    data['id_warehouse'] = idWarehouse;
    data['id_partner'] = idPartner;
    data['created_at'] = createdAt;
    if (warehouse != null) {
      data['Warehouse'] = warehouse!.toJson();
    }
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Warehouse {
  int? id;
  String? name;
  dynamic description;
  int? credit;
  int? idMember;
  int? idSpa;
  int? createdAt;

  Warehouse(
      {this.id,
        this.name,
        this.description,
        this.credit,
        this.idMember,
        this.idSpa,
        this.createdAt});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    credit = json['credit'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['credit'] = credit;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['created_at'] = createdAt;
    return data;
  }
}

class Parent {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  dynamic note;
  int? idMember;
  int? createdAt;
  int? updatedAt;

  Parent(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.address,
        this.note,
        this.idMember,
        this.createdAt,
        this.updatedAt});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    note = json['note'];
    idMember = json['id_member'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['note'] = note;
    data['id_member'] = idMember;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Product {
  int? id;
  int? idMember;
  int? idWarehouseProduct;
  int? idProduct;
  int? imporPrice;
  int? quantity;
  int? inventoryQuantity;
  int? idWarehouse;
  int? createdAt;
  Prod? prod;

  Product(
      {this.id,
        this.idMember,
        this.idWarehouseProduct,
        this.idProduct,
        this.imporPrice,
        this.quantity,
        this.inventoryQuantity,
        this.idWarehouse,
        this.createdAt,
        this.prod});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMember = json['id_member'];
    idWarehouseProduct = json['id_warehouse_product'];
    idProduct = json['id_product'];
    imporPrice = json['impor_price'];
    quantity = json['quantity'];
    inventoryQuantity = json['inventory_quantity'];
    idWarehouse = json['id_warehouse'];
    createdAt = json['created_at'];
    prod = json['prod'] != null ? Prod.fromJson(json['prod']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_member'] = idMember;
    data['id_warehouse_product'] = idWarehouseProduct;
    data['id_product'] = idProduct;
    data['impor_price'] = imporPrice;
    data['quantity'] = quantity;
    data['inventory_quantity'] = inventoryQuantity;
    data['id_warehouse'] = idWarehouse;
    data['created_at'] = createdAt;
    if (prod != null) {
      data['prod'] = prod!.toJson();
    }
    return data;
  }
}

class Prod {
  int? id;
  String? name;
  int? idCategory;
  String? description;
  dynamic info;
  String? image;
  String? code;
  int? price;
  int? quantity;
  int? idTrademark;
  String? status;
  String? slug;
  dynamic view;
  int? idMember;
  int? idSpa;
  int? commissionStaffFix;
  int? commissionStaffPercent;
  int? commissionAffiliateFix;
  int? commissionAffiliatePercent;
  int? updatedAt;
  int? createdAt;

  Prod(
      {this.id,
        this.name,
        this.idCategory,
        this.description,
        this.info,
        this.image,
        this.code,
        this.price,
        this.quantity,
        this.idTrademark,
        this.status,
        this.slug,
        this.view,
        this.idMember,
        this.idSpa,
        this.commissionStaffFix,
        this.commissionStaffPercent,
        this.commissionAffiliateFix,
        this.commissionAffiliatePercent,
        this.updatedAt,
        this.createdAt});

  Prod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idCategory = json['id_category'];
    description = json['description'];
    info = json['info'];
    image = json['image'];
    code = json['code'];
    price = json['price'];
    quantity = json['quantity'];
    idTrademark = json['id_trademark'];
    status = json['status'];
    slug = json['slug'];
    view = json['view'];
    idMember = json['id_member'];
    idSpa = json['id_spa'];
    commissionStaffFix = json['commission_staff_fix'];
    commissionStaffPercent = json['commission_staff_percent'];
    commissionAffiliateFix = json['commission_affiliate_fix'];
    commissionAffiliatePercent = json['commission_affiliate_percent'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['id_category'] = idCategory;
    data['description'] = description;
    data['info'] = info;
    data['image'] = image;
    data['code'] = code;
    data['price'] = price;
    data['quantity'] = quantity;
    data['id_trademark'] = idTrademark;
    data['status'] = status;
    data['slug'] = slug;
    data['view'] = view;
    data['id_member'] = idMember;
    data['id_spa'] = idSpa;
    data['commission_staff_fix'] = commissionStaffFix;
    data['commission_staff_percent'] = commissionStaffPercent;
    data['commission_affiliate_fix'] = commissionAffiliateFix;
    data['commission_affiliate_percent'] = commissionAffiliatePercent;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}

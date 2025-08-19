import 'package:flutter/cupertino.dart';

class ModelAddCart {
  final int? id;
  final String? name;
  final int price;
  final String? image;
  int quantity;
  late final TextEditingController _quantityController;
  int? priceSell; /// With prepaid card

  ModelAddCart({
    this.id,
    this.name,
    this.price = 0,
    this.image,
    this.quantity = 1,
    this.priceSell,
  }) {
    _quantityController = TextEditingController(text: quantity.toString());
  }

  TextEditingController get quantityController => _quantityController;

  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
    _quantityController.text = newQuantity.toString();
  }

  ModelAddCart copyWith({
    int? id,
    String? name,
    int? price,
    String? image,
    int? quantity,
    int? priceSell
  }) {
    final newModel = ModelAddCart(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      priceSell: priceSell ?? this.priceSell,
    );
    return newModel;
  }

  void dispose() => _quantityController.dispose();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ModelAddCart &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = id;
    data['quantity'] = _quantityController.text;
    data['price'] = price;
    return data;
  }
}
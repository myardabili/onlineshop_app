// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:onlineshop_app/features/home/data/models/product_detail_model.dart';

class ProductQuantity {
  Data product;
  int quantity;
  ProductQuantity({
    required this.product,
    required this.quantity,
  });

  @override
  bool operator ==(covariant ProductQuantity other) {
    if (identical(this, other)) return true;

    return other.product == product && other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  @override
  String toString() =>
      'ProductQuantity(product: $product, quantity: $quantity)';

  ProductQuantity copyWith({
    Data? product,
    int? quantity,
  }) {
    return ProductQuantity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

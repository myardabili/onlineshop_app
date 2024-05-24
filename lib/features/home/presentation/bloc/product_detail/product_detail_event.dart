part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetProductDetail extends ProductDetailEvent {
  final int productId;

  const OnGetProductDetail({required this.productId});
  @override
  List<Object> get props => [productId];
}

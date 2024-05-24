part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailLoading extends ProductDetailState {}

final class ProductDetailFailure extends ProductDetailState {
  final String message;

  const ProductDetailFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class ProductDetailLoaded extends ProductDetailState {
  final Data product;

  const ProductDetailLoaded({required this.product});
  @override
  List<Object> get props => [product];
}

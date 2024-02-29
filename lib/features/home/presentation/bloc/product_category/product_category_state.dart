part of 'product_category_bloc.dart';

sealed class ProductCategoryState extends Equatable {
  const ProductCategoryState();

  @override
  List<Object> get props => [];
}

final class ProductCategoryInitial extends ProductCategoryState {}

final class ProductCategoryLoading extends ProductCategoryState {}

final class ProductCategoryFailure extends ProductCategoryState {
  final String message;

  const ProductCategoryFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class ProductCategoryLoaded extends ProductCategoryState {
  final List<Product> product;

  const ProductCategoryLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

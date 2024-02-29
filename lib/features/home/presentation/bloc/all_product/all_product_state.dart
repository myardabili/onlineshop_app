part of 'all_product_bloc.dart';

sealed class AllProductState extends Equatable {
  const AllProductState();

  @override
  List<Object> get props => [];
}

final class AllProductInitial extends AllProductState {}

final class AllProductLoading extends AllProductState {}

final class AllProductFailure extends AllProductState {
  final String message;

  const AllProductFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class AllProductLoaded extends AllProductState {
  final List<Product> product;

  const AllProductLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

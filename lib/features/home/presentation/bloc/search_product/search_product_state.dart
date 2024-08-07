part of 'search_product_bloc.dart';

sealed class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object> get props => [];
}

final class SearchProductInitial extends SearchProductState {}

final class SearchProductLoading extends SearchProductState {}

final class SearchProductFailure extends SearchProductState {
  final String message;

  const SearchProductFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class SearchProductLoaded extends SearchProductState {
  final List<Product> product;

  const SearchProductLoaded({required this.product});
  @override
  List<Object> get props => [product];
}

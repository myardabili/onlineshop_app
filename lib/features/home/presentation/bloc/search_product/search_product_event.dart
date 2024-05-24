part of 'search_product_bloc.dart';

sealed class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object> get props => [];
}

class OnSearchProduct extends SearchProductEvent {
  final String query;

  const OnSearchProduct({required this.query});
  @override
  List<Object> get props => [query];
}

part of 'product_category_bloc.dart';

sealed class ProductCategoryEvent extends Equatable {
  const ProductCategoryEvent();

  @override
  List<Object> get props => [];
}

class OnGetProductCategory extends ProductCategoryEvent {
  // final int categoryId;

  // const OnGetProductCategory({required this.categoryId});

  // @override
  // List<Object> get props => [categoryId];
}

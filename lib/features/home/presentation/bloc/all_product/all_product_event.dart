part of 'all_product_bloc.dart';

sealed class AllProductEvent extends Equatable {
  const AllProductEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllProduct extends AllProductEvent {}

part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryFailure extends CategoryState {
  final String message;

  const CategoryFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class CategoryLoaded extends CategoryState {
  final List<Category> category;

  const CategoryLoaded({required this.category});

  @override
  List<Object> get props => [category];
}

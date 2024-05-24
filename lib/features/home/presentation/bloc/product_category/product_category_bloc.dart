import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/features/home/data/datasources/product_remote_datasource.dart';
import 'package:onlineshop_app/features/home/data/models/product_model.dart';

part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final ProductRemoteDatasource _datasource;
  ProductCategoryBloc(this._datasource) : super(ProductCategoryInitial()) {
    on<OnGetProductCategory>((event, emit) async {
      emit(ProductCategoryLoading());
      final result = await _datasource.productCategory(event.categoryId);
      result.fold(
        (failure) => emit(ProductCategoryFailure(message: failure)),
        (data) => emit(ProductCategoryLoaded(product: data.data!.data!)),
      );
    });
  }
}

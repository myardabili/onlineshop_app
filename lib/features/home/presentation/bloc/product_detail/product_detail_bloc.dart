// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/home/data/datasources/product_remote_datasource.dart';
import 'package:onlineshop_app/features/home/data/models/product_detail_model.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRemoteDatasource _datasource;
  ProductDetailBloc(
    this._datasource,
  ) : super(ProductDetailInitial()) {
    on<OnGetProductDetail>((event, emit) async {
      emit(ProductDetailLoading());
      final result = await _datasource.getProductDetail(event.productId);
      result.fold(
        (failure) => emit(ProductDetailFailure(message: failure)),
        (data) => emit(ProductDetailLoaded(product: data.data!)),
      );
    });
  }
}

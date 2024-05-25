// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/home/data/datasources/product_remote_datasource.dart';
import 'package:onlineshop_app/features/home/data/models/search_product_model.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final ProductRemoteDatasource _datasource;
  SearchProductBloc(
    this._datasource,
  ) : super(SearchProductInitial()) {
    on<OnSearchProduct>((event, emit) async {
      emit(SearchProductLoading());
      final result = await _datasource.searchProduct(event.query);
      result.fold(
        (failure) => emit(SearchProductFailure(message: failure)),
        (data) => emit(SearchProductLoaded(product: data.data!.data!)),
      );
    });
  }
}

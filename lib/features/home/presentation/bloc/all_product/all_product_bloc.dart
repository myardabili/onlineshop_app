// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/home/data/datasources/product_remote_datasource.dart';
import 'package:onlineshop_app/features/home/data/models/product_model.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  final ProductRemoteDatasource _datasource;
  AllProductBloc(
    this._datasource,
  ) : super(AllProductInitial()) {
    on<OnGetAllProduct>((event, emit) async {
      emit(AllProductLoading());
      final result = await _datasource.allProduct();
      result.fold(
        (failure) => emit(AllProductFailure(message: failure)),
        (data) => emit(AllProductLoaded(product: data.data!.data!)),
      );
    });
  }
}

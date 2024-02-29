// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/home/data/datasources/category_remote_datasource.dart';
import 'package:onlineshop_app/features/home/data/models/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRemoteDatasource _datasource;
  CategoryBloc(
    this._datasource,
  ) : super(CategoryInitial()) {
    on<OnGetCategory>((event, emit) async {
      emit(CategoryLoading());
      final result = await _datasource.getCategory();
      result.fold(
        (failure) => emit(CategoryFailure(message: failure)),
        (data) => emit(CategoryLoaded(category: data.data!)),
      );
    });
  }
}

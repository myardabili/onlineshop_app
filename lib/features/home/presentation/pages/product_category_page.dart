// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/components.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/product_category/product_category_bloc.dart';
import 'package:onlineshop_app/features/home/presentation/widgets/product_shimmer.dart';

import '../../../../api/urls.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';

class ProductCategoryPage extends StatefulWidget {
  final int categoryId;
  const ProductCategoryPage({
    super.key,
    required this.categoryId,
  });

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  @override
  void initState() {
    context.read<ProductCategoryBloc>().add(
          OnGetProductCategory(categoryId: widget.categoryId),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        // centerTitle: true,
        title: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoaded) {
              final category = state.category.firstWhere(
                (category) => category.id == widget.categoryId,
              );
              return Text(
                category.name!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              );
            }
            return const SizedBox();
          },
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),
      body: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
        builder: (context, state) {
          if (state is ProductCategoryLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ProductShimmer(),
            );
          }
          if (state is ProductCategoryLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 0.7,
              ),
              padding: const EdgeInsets.all(20),
              itemCount: state.product.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      RouteConstants.productDetail,
                      pathParameters: PathParameters().toMap(),
                      extra: state.product[index].id,
                    );
                  },
                  child: _productItemCard(state, index, context),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';
import 'package:onlineshop_app/core/components/components.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';

import 'package:onlineshop_app/features/home/presentation/bloc/search_product/search_product_bloc.dart';

import '../../../../api/urls.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';

class SearchProductPage extends StatefulWidget {
  final String query;
  const SearchProductPage({
    super.key,
    required this.query,
  });

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<SearchProductBloc>().add(OnSearchProduct(query: widget.query));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _searchProductForm(context),
            const SpaceHeight(height: 20),
            BlocBuilder<SearchProductBloc, SearchProductState>(
              builder: (context, state) {
                if (state is SearchProductLoading) {
                  return const CircleLoading();
                }
                if (state is SearchProductLoaded) {
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Result for "${searchController.text}"',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${state.product.length} founds',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0,
                              childAspectRatio: 0.7,
                            ),
                            padding: const EdgeInsets.all(20),
                            itemCount: state.product.length,
                            itemBuilder: (context, index) {
                              return _productItemCard(context, state, index);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchProductForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          // color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextFormField(
          onFieldSubmitted: (_) {
            context
                .read<SearchProductBloc>()
                .add(OnSearchProduct(query: searchController.text));
          },
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search product here...',
            suffixIcon: const Icon(Icons.search),
            contentPadding: const EdgeInsets.all(16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _productItemCard(
      BuildContext context, SearchProductLoaded state, int index) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          RouteConstants.productDetail,
          pathParameters: PathParameters().toMap(),
          extra: state.product[index].id,
        );
      },
      child: Container(
        height: 150,
        width: 30,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              state.product[index].image!.contains('http')
                  ? state.product[index].image!
                  : '${URLs.baseUrlImage}${state.product[index].image!}',
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            const SpaceHeight(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                state.product[index].name!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SpaceHeight(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                state.product[index].price!.currencyFormatRp,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

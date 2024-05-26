import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/all_product/all_product_bloc.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';
import '../../../../../core/components/spaces.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/router/app_router.dart';
import '../title_content.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    context.read<AllProductBloc>().add(OnGetAllProduct());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContent(
          title: 'Popular Product',
          onSeeAllTap: () {},
        ),
        const SpaceHeight(height: 20.0),
        BlocBuilder<AllProductBloc, AllProductState>(
          builder: (context, state) {
            if (state is AllProductLoading) {
              return const CircleLoading();
            }
            if (state is AllProductFailure) {
              return Text(state.message);
            }
            if (state is AllProductLoaded) {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 0.75,
                  ),
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
                  });
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }

  Widget _productItemCard(
      AllProductLoaded state, int index, BuildContext context) {
    return Container(
      height: 150,
      width: 30,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
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
                : '${URLs.baseUrlImage}${state.product[index].image}',
            width: MediaQuery.of(context).size.width,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          const SpaceHeight(height: 10),
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
    );
  }
}

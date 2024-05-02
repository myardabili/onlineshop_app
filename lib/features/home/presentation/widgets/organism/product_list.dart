import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/core/assets/assets.gen.dart';
import 'package:onlineshop_app/core/constants/app_colors.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/product_category/product_category_bloc.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';

import '../../../../../core/components/spaces.dart';
import '../../bloc/checkout/checkout_bloc.dart';
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
    context.read<ProductCategoryBloc>().add(OnGetProductCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContent(
          title: 'Most Popular',
          onSeeAllTap: () {},
        ),
        const SpaceHeight(height: 20.0),
        BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
          builder: (context, state) {
            if (state is ProductCategoryLoading) {
              return const CircleLoading();
            }
            if (state is ProductCategoryFailure) {
              return Text(state.message);
            }
            if (state is ProductCategoryLoaded) {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 55.0,
                  ),
                  itemCount: state.product.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.05),
                                blurRadius: 7.0,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  state.product[index].image!.contains('http')
                                      ? state.product[index].image!
                                      : '${URLs.baseUrlImage}${state.product[index].image}',
                                  width: 170.0,
                                  height: 112.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SpaceHeight(height: 14.0),
                              Flexible(
                                child: Text(
                                  state.product[index].name!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Text(
                                state.product[index].price!.currencyFormatRp,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<CheckoutBloc>()
                                  .add(AddItem(item: state.product[index]));
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.1),
                                    blurRadius: 10.0,
                                    offset: const Offset(0, 2),
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                              ),
                              child: Assets.icons.order.svg(),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }
}

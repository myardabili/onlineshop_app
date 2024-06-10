import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/constants/app_colors.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../api/urls.dart';
import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/router/app_router.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../widgets/button_shimmer.dart';
import '../widgets/product_detail_shimmer.dart';

const Map<int, String> categoryMap = {
  1: 'Clothes',
  2: 'Shoes',
  3: 'Electronics',
  4: 'Fashion & Beauty',
  5: 'Accessories',
};

const Map<int, String> isAvailable = {
  0: 'No Available',
  1: 'Available',
};

class ProductDetailPage extends StatefulWidget {
  final int productId;
  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    context
        .read<ProductDetailBloc>()
        .add(OnGetProductDetail(productId: widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Detail',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoaded) {
                  final totalQuantity = state.items.fold<int>(
                      0,
                      (previousValue, element) =>
                          previousValue + element.quantity);
                  return totalQuantity > 0
                      ? badges.Badge(
                          position: badges.BadgePosition.topEnd(top: 1, end: 4),
                          badgeAnimation: const badges.BadgeAnimation.scale(),
                          badgeContent: Text(
                            totalQuantity.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          child: IconButton(
                            onPressed: () {
                              context.pushNamed(
                                RouteConstants.cart,
                                pathParameters: PathParameters().toMap(),
                              );
                            },
                            icon: Assets.icons.cart.svg(height: 20),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            context.pushNamed(RouteConstants.cart,
                                pathParameters: PathParameters().toMap());
                          },
                          icon: Assets.icons.cart.svg(height: 20),
                        );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return const ProductDetailShimmer();
          }
          if (state is ProductDetailFailure) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is ProductDetailLoaded) {
            return ListView(
              children: [
                _imageProduct(state),
                _detailProduct(state),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: _bottomNavbar(),
    );
  }

  Widget _bottomNavbar() {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: _buttonNavbarItem(),
    );
  }

  Widget _buttonNavbarItem() {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoading) {
          return const ButtonShimmer();
        }
        if (state is ProductDetailLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                      ),
                    ),
                    Text(
                      state.product.price!.currencyFormatRp,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<CheckoutBloc>()
                          .add(AddItem(item: state.product));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _detailProduct(ProductDetailLoaded state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categoryMap[state.product.categoryId] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
                Text(
                  isAvailable[state.product.isAvailable] ?? '-',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SpaceHeight(height: 8.0),
            Text(
              state.product.name!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(height: 30.0),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(height: 20.0),
            Text(
              state.product.description!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageProduct(ProductDetailLoaded state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            state.product.image!.contains('http')
                ? state.product.image!
                : '${URLs.baseUrlImage}${state.product.image!}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

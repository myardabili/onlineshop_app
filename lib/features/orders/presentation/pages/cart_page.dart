import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/components.dart';
import 'package:onlineshop_app/core/constants/app_colors.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/router/app_router.dart';
import '../../../home/presentation/bloc/checkout/checkout_bloc.dart';
import '../widgets/cart_tile.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const CircleLoading();
                }
                if (state is CheckoutLoaded) {
                  final totalQuantity = state.items.fold<int>(
                      0,
                      (previousValue, element) =>
                          previousValue + element.quantity);
                  return totalQuantity > 0
                      ? badges.Badge(
                          position: badges.BadgePosition.topEnd(top: 1, end: 5),
                          badgeContent: Text(
                            totalQuantity.toString(),
                            style: const TextStyle(color: AppColors.white),
                          ),
                          child: IconButton(
                            onPressed: () {
                              context.goNamed(RouteConstants.cart,
                                  pathParameters: PathParameters().toMap());
                            },
                            icon: Assets.icons.cart.svg(height: 20),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            context.goNamed(RouteConstants.cart,
                                pathParameters: PathParameters().toMap());
                          },
                          icon: Assets.icons.cart.svg(height: 20),
                        );
                }
                return const SizedBox.shrink();
              },
            ),
            // child: IconButton(
            //   onPressed: () {
            //     context.goNamed(
            //       RouteConstants.cart,
            //       pathParameters: PathParameters(
            //         rootTab: RootTab.order,
            //       ).toMap(),
            //     );
            //   },
            //   icon: Assets.icons.cart.svg(height: 20.0),
            // ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoading) {
                return const CircleLoading();
              }
              if (state is CheckoutFailure) {
                return Text(state.message);
              }
              if (state is CheckoutLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) => CartTile(
                    data: state.items[index],
                  ),
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 50,
                      thickness: 1,
                      color: AppColors.primary.withOpacity(0.5),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _totalPrice(),
            const SpaceHeight(height: 20.0),
            _buttonCheckout(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<CheckoutBloc, CheckoutState> _buttonCheckout() {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutLoaded) {
          final totalQty = state.items.fold<int>(
              0, (previousValue, element) => previousValue + element.quantity);
          return Button.filled(
            disabled: totalQty == 0,
            onPressed: () async {
              final isAuth = await AuthLocalDatasource().isAuth();
              if (!isAuth) {
                context.pushNamed(
                  RouteConstants.login,
                );
              } else {
                context.goNamed(
                  RouteConstants.address,
                  pathParameters: PathParameters(
                    rootTab: RootTab.order,
                  ).toMap(),
                );
              }
            },
            label: 'Checkout ($totalQty)',
          );
        }
        return Button.filled(
          disabled: false,
          onPressed: () {},
          label: 'Checkout (0)',
        );
      },
    );
  }

  Widget _totalPrice() {
    return Row(
      children: [
        const Text(
          'Total',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoaded) {
              final totalPrice = state.items.fold<int>(
                  0,
                  (previousValue, element) =>
                      previousValue +
                      (element.quantity * element.product.price!));
              return Text(
                totalPrice.currencyFormatRp,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              );
            }
            return Text(
              0.currencyFormatRp,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
      ],
    );
  }
}

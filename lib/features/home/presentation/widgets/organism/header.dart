import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/assets/assets.gen.dart';
import 'package:onlineshop_app/core/components/spaces.dart';
import 'package:badges/badges.dart' as badges;
import 'package:onlineshop_app/core/router/app_router.dart';
import 'package:onlineshop_app/features/home/presentation/widgets/circle_loading.dart';

import '../../bloc/checkout/checkout_bloc.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discover',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Find anything what you want!',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
        const Spacer(),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10),
          ),
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
                        badgeContent: Text(
                          totalQuantity.toString(),
                          style: const TextStyle(color: Colors.white),
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
        ),
        const SpaceWidth(width: 16.0),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Assets.icons.notification.svg(height: 20),
          ),
        ),
      ],
    );
  }
}

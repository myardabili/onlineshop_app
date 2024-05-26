import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/features/home/presentation/pages/product_category_page.dart';
import 'package:onlineshop_app/features/home/presentation/pages/product_detail_page.dart';
import 'package:onlineshop_app/features/profile/presentation/pages/profile_detail_page.dart';
import 'package:onlineshop_app/features/profile/presentation/pages/profile_page.dart';

import '../../features/address/presentation/models/address_model.dart';
import '../../features/address/presentation/pages/add_address_page.dart';
import '../../features/address/presentation/pages/address_page.dart';
import '../../features/address/presentation/pages/edit_address_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/home/presentation/pages/dashboard_page.dart';
import '../../features/orders/presentation/pages/cart_page.dart';
import '../../features/orders/presentation/pages/order_detail_page.dart';
import '../../features/orders/presentation/pages/payment_detail_page.dart';
import '../../features/orders/presentation/pages/payment_waiting_page.dart';
import '../../features/profile/presentation/pages/history_order_page.dart';
import '../../features/profile/presentation/pages/shipping_detail_page.dart';
import '../../features/profile/presentation/pages/tracking_order_page.dart';

part 'route_constants.dart';
part 'enums/root_tab.dart';
part 'models/path_parameters.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: RouteConstants.rootPath,
    routes: [
      GoRoute(
        name: RouteConstants.splash,
        path: RouteConstants.splashPath,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: RouteConstants.login,
        path: RouteConstants.loginPath,
        builder: (context, state) => const LoginPage(),
        routes: [
          // GoRoute(
          //   name: RouteConstants.verification,
          //   path: RouteConstants.verificationPath,
          //   builder: (context, state) => const VerificationPage(),
          // ),
          GoRoute(
            name: RouteConstants.register,
            path: RouteConstants.registerPath,
            builder: (context, state) => const RegisterPage(),
          ),
        ],
      ),
      GoRoute(
        name: RouteConstants.root,
        path: RouteConstants.rootPath,
        builder: (context, state) {
          final tab = int.tryParse(state.pathParameters['root_tab'] ?? '') ?? 0;
          return DashboardPage(
            key: state.pageKey,
            currentTab: tab,
          );
        },
        routes: [
          GoRoute(
              name: RouteConstants.productCategory,
              path: RouteConstants.productCategoryPath,
              builder: (context, state) {
                final args = state.extra as int;
                return ProductCategoryPage(categoryId: args);
              }),
          GoRoute(
            name: RouteConstants.orderList,
            path: RouteConstants.orderListPath,
            builder: (context, state) => const HistoryOrderPage(),
          ),
          GoRoute(
            name: RouteConstants.profileDetail,
            path: RouteConstants.profileDetailPath,
            builder: (context, state) => const ProfileDetailPage(),
          ),
          GoRoute(
            name: RouteConstants.productDetail,
            path: RouteConstants.productDetailPath,
            builder: (context, state) {
              final args = state.extra as int;
              return ProductDetailPage(productId: args);
            },
          ),
          GoRoute(
            name: RouteConstants.cart,
            path: RouteConstants.cartPath,
            builder: (context, state) => const CartPage(),
            routes: [
              GoRoute(
                name: RouteConstants.orderDetail,
                path: RouteConstants.orderDetailPath,
                builder: (context, state) => const OrderDetailPage(),
                routes: [
                  GoRoute(
                    name: RouteConstants.paymentDetail,
                    path: RouteConstants.paymentDetailPath,
                    builder: (context, state) => const PaymentDetailPage(),
                    routes: [
                      GoRoute(
                        name: RouteConstants.paymentWaiting,
                        path: RouteConstants.paymentWaitingPath,
                        builder: (context, state) {
                          final args = state.extra as int;
                          return PaymentWaitingPage(
                            orderId: args,
                          );
                        },
                      ),
                      GoRoute(
                        name: RouteConstants.trackingOrder,
                        path: RouteConstants.trackingOrderPath,
                        builder: (context, state) {
                          final args = state.extra as int;
                          return TrackingOrderPage(
                            orderId: args,
                          );
                        },
                        routes: [
                          GoRoute(
                            name: RouteConstants.shippingDetail,
                            path: RouteConstants.shippingDetailPath,
                            builder: (context, state) {
                              final args = state.extra as String;
                              return ShippingDetailPage(
                                resi: args,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                name: RouteConstants.address,
                path: RouteConstants.addressPath,
                builder: (context, state) => const AddressPage(),
                routes: [
                  GoRoute(
                    name: RouteConstants.addAddress,
                    path: RouteConstants.addAddressPath,
                    builder: (context, state) => const AddAddressPage(),
                  ),
                  GoRoute(
                    name: RouteConstants.editAddress,
                    path: RouteConstants.editAddressPath,
                    builder: (context, state) {
                      final args = state.extra as AddressModel;
                      return EditAddressPage(data: args);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    },
  );
}

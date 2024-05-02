import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../data/models/bank_account_model.dart';
import '../bloc/order/order_bloc.dart';
import '../widgets/countdown_timer.dart';

class PaymentWaitingPage extends StatefulWidget {
  const PaymentWaitingPage({super.key});

  @override
  State<PaymentWaitingPage> createState() => _PaymentWaitingPageState();
}

class _PaymentWaitingPageState extends State<PaymentWaitingPage> {
  @override
  Widget build(BuildContext context) {
    void onTimerCompletion() {
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        builder: (BuildContext context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  child: ColoredBox(
                    color: AppColors.light,
                    child: SizedBox(height: 8.0, width: 55.0),
                  ),
                ),
                const SpaceHeight(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pesananmu dalam Proses',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.light,
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Assets.images.processOrder.image(),
                ),
                const SpaceHeight(height: 50.0),
                Row(
                  children: [
                    Flexible(
                      child: Button.outlined(
                        onPressed: () {
                          context.pushNamed(
                            RouteConstants.trackingOrder,
                            pathParameters: PathParameters().toMap(),
                          );
                        },
                        label: 'Lacak Pesanan',
                      ),
                    ),
                    const SpaceWidth(width: 20.0),
                    Flexible(
                      child: Button.filled(
                        onPressed: () {
                          context.goNamed(
                            RouteConstants.root,
                            pathParameters: PathParameters().toMap(),
                          );
                        },
                        label: 'Back to Home',
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(height: 20.0),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting for payment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Row(
            children: [
              const Icon(Icons.schedule),
              const SpaceWidth(width: 12.0),
              const Flexible(
                child: Text(
                  'Selesaikan Pembayaran Dalam',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SpaceWidth(width: 12.0),
              CountdownTimer(
                minute: 1,
                onTimerCompletion: onTimerCompletion,
              ),
            ],
          ),
          const SpaceHeight(height: 20.0),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const CircleLoading();
              }
              if (state is OrderLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      banks
                          .where((element) =>
                              element.code ==
                              state.orderModel.order!.paymentVaName!)
                          .first
                          .name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Image.asset(
                      height: 100,
                      width: 100,
                      banks
                          .where((element) =>
                              element.code ==
                              state.orderModel.order!.paymentVaName!)
                          .first
                          .image,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SpaceHeight(height: 14.0),
          const Divider(),
          const SpaceHeight(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'No Virtual Account',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      if (state is OrderLoaded) {
                        return Text(
                          state.orderModel.order!.paymentVaNumber!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Button.outlined(
                textColor: AppColors.primary,
                width: 125.0,
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: 'test dong'))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Copied to clipboard'),
                      duration: Duration(seconds: 1),
                      backgroundColor: AppColors.primary,
                    ));
                  });
                },
                label: 'Copy',
                icon: Assets.icons.copy.svg(),
              ),
            ],
          ),
          const SpaceHeight(height: 14.0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Total Pembayaran',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoaded) {
                  return Text(
                    state.orderModel.order!.totalCost!.currencyFormatRp,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Button.filled(
              onPressed: () {
                context.goNamed(
                  RouteConstants.root,
                  pathParameters: PathParameters().toMap(),
                );
              },
              label: 'Belanja Lagi',
            ),
            const SpaceHeight(height: 20.0),
            Button.outlined(
              onPressed: () {
                context.pushNamed(
                  RouteConstants.trackingOrder,
                  pathParameters: PathParameters().toMap(),
                );
              },
              label: 'Cek Status Pembayaran',
            ),
          ],
        ),
      ),
    );
  }
}

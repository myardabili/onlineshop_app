import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:onlineshop_app/features/orders/presentation/bloc/order/order_bloc.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../data/models/bank_account_model.dart';
import '../widgets/payment_method.dart';

class PaymentDetailPage extends StatelessWidget {
  const PaymentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPayment = ValueNotifier<int>(0);

    List<BankAccountModel> banksLimit = [banks[0], banks[1]];

    void seeAllTap() {
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: AppColors.white,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Metode Pembayaran',
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
                const SpaceHeight(height: 16.0),
                ValueListenableBuilder(
                  valueListenable: selectedPayment,
                  builder: (context, value, _) => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PaymentMethod(
                      isActive: value == banks[index].code,
                      data: banks[index],
                      onTap: () {
                        // selectedPayment.value = banks[index].code;
                        // if (banksLimit.first != banks[index]) {
                        //   banksLimit[1] = banks[index];
                        // }
                        context.pop();
                      },
                    ),
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(height: 14.0),
                    itemCount: banks.length,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    void buyNowTap() {
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
                          context.goNamed(
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
        title: const Text('Payment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SpaceHeight(height: 30.0),
          Row(
            children: [
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: seeAllTap,
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SpaceHeight(height: 20.0),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoaded) {
                final paymentVaName = state.paymentVaName;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => PaymentMethod(
                    isActive: paymentVaName == banksLimit[index].code,
                    data: banksLimit[index],
                    onTap: () {
                      context.read<CheckoutBloc>().add(AddPaymentMethod(
                            paymentMethod: banksLimit[index].code,
                          ));
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      const SpaceHeight(height: 14.0),
                  itemCount: banksLimit.length,
                );
              }
              return const SizedBox();
            },
          ),
          const SpaceHeight(height: 36.0),
          const Divider(),
          const SpaceHeight(height: 8.0),
          const Text(
            'Ringkasan Pembayaran',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(height: 12.0),
          Row(
            children: [
              const Text(
                'Total Belanja',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoaded) {
                    final subtotal = state.items.fold<int>(
                        0,
                        (previousValue, element) =>
                            previousValue +
                            (element.product.price! * element.quantity));
                    return Text(
                      subtotal.currencyFormatRp,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                  return Text(
                    0.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SpaceHeight(height: 5.0),
          Row(
            children: [
              const Text(
                'Biaya Kirim',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoaded) {
                    final shippingCost = state.shippingCost;
                    return Text(
                      shippingCost.currencyFormatRp,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                  return Text(
                    0.currencyFormatRp,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SpaceHeight(height: 8.0),
          const Divider(),
          const SpaceHeight(height: 24.0),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Total Tagihan',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    if (state is CheckoutLoaded) {
                      final total = state.items.fold<int>(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  (element.product.price! * element.quantity)) +
                          state.shippingCost;
                      return Text(
                        total.currencyFormatRp,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }
                    return Text(
                      0.currencyFormatRp,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SpaceHeight(height: 20.0),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoaded) {
                  final paymentMethod = state.paymentMethod;
                  return BlocListener<OrderBloc, OrderState>(
                    listener: (context, orderState) {
                      if (orderState is OrderLoaded) {
                        context.pushNamed(
                          RouteConstants.paymentWaiting,
                          pathParameters: PathParameters().toMap(),
                          extra: orderState.orderModel.order!.id!,
                        );
                      }
                      if (orderState is OrderFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: AppColors.red,
                          content: Text(orderState.message),
                        ));
                      }
                    },
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, orderState) {
                        if (orderState is OrderLoading) {
                          return const CircleLoading();
                        }
                        return Button.filled(
                          disabled: paymentMethod == '',
                          onPressed: () {
                            context.read<OrderBloc>().add(OnOrder(
                                  addressId: state.addressId,
                                  paymentMethod: paymentMethod,
                                  shippingService: state.shippingService,
                                  shippingCost: state.shippingCost,
                                  paymentVaName: state.paymentVaName,
                                  products: state.items,
                                ));
                          },
                          label: 'Bayar Sekarang',
                        );
                      },
                    ),
                  );
                }
                return Button.filled(
                  disabled: false,
                  onPressed: () {
                    context.pushNamed(
                      RouteConstants.paymentWaiting,
                      pathParameters: PathParameters().toMap(),
                    );
                  },
                  label: 'Bayar Sekarang',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

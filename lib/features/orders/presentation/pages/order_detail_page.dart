import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/orders/presentation/bloc/cost/cost_bloc.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../home/presentation/bloc/checkout/checkout_bloc.dart';
import '../widgets/cart_tile.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    context.read<CostBloc>().add(const OnGetCost(
          origin: '5779',
          destination: '2103',
          weight: 1000,
          courier: 'jne',
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Orders'),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(
                RouteConstants.cart,
                pathParameters: PathParameters(
                  rootTab: RootTab.order,
                ).toMap(),
              );
            },
            icon: Assets.icons.cart.svg(height: 24.0),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) => CartTile(
                    data: state.items[index],
                  ),
                  separatorBuilder: (context, index) =>
                      const SpaceHeight(height: 16.0),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SpaceHeight(height: 36.0),
          const _SelectShipping(),
          // const _ShippingSelected(),
          const SpaceHeight(height: 36.0),
          const Divider(),
          const SpaceHeight(height: 8.0),
          const Text(
            'Detail Belanja :',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(height: 12.0),
          Row(
            children: [
              const Text(
                'Total Harga (Produk)',
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
                          (element.product.price! * element.quantity),
                    );
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
          const SpaceHeight(height: 5.0),
          Row(
            children: [
              const Text(
                'Total Ongkos Kirim',
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
                  'Total Belanja',
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
            Button.filled(
              onPressed: () {
                context.goNamed(
                  RouteConstants.paymentDetail,
                  pathParameters: PathParameters().toMap(),
                );
              },
              label: 'Pilih Pembayaran',
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectShipping extends StatelessWidget {
  const _SelectShipping();

  @override
  Widget build(BuildContext context) {
    void onSelectShippingTap() {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    child: ColoredBox(
                      color: AppColors.light,
                      child: SizedBox(height: 8.0, width: 55.0),
                    ),
                  ),
                ),
                const SpaceHeight(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Metode Pengiriman',
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
                const SpaceHeight(height: 18.0),
                // Container(
                //   decoration: ShapeDecoration(
                //     shape: RoundedRectangleBorder(
                //       side: const BorderSide(
                //         width: 1.50,
                //         color: AppColors.stroke,
                //       ),
                //       borderRadius: BorderRadius.circular(14),
                //     ),
                //   ),
                //   child: ListTile(
                //     leading: Assets.icons.routing.svg(),
                //     subtitle: const Text('Dikirim dari Kabupaten Banyuwangi'),
                //     trailing: const Text(
                //       'berat: 1kg',
                //       textAlign: TextAlign.right,
                //       style: TextStyle(
                //         color: AppColors.primary,
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
                // const SpaceHeight(height: 12.0),
                // const Text(
                //   'Estimasi tiba 20 - 23 Januari (Rp. 20.000)',
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // const SpaceHeight(height: 30.0),
                const Divider(color: AppColors.stroke),
                BlocBuilder<CostBloc, CostState>(
                  builder: (context, state) {
                    if (state is CostLoaded) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item =
                              state.cost.rajaongkir!.results![0].costs![index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            onTap: () {
                              context
                                  .read<CheckoutBloc>()
                                  .add(AddShippingService(
                                    shippingService: 'jne',
                                    shippingCost: item.cost![0].value!,
                                  ));
                              context.pop();
                            },
                            title: Text(
                                '${item.service} - ${item.description} (${item.cost![0].value!.currencyFormatRp})'),
                            subtitle:
                                Text('Estimasi tiba ${item.cost![0].etd} Hari'),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const Divider(color: AppColors.stroke),
                        itemCount:
                            state.cost.rajaongkir!.results![0].costs!.length,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: onSelectShippingTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.stroke),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pilih Pengiriman',
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _ShippingSelected extends StatelessWidget {
  const _ShippingSelected();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.stroke),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Reguler',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  'Edit',
                  style: TextStyle(fontSize: 16),
                ),
                SpaceWidth(width: 4.0),
                Icon(Icons.chevron_right),
              ],
            ),
            SpaceHeight(height: 12.0),
            Text(
              'JNE (Rp. 25.000)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text('Estimasi tiba 2 Januari 2024'),
          ],
        ),
      ),
    );
  }
}

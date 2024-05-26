import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/get_address/get_address_bloc.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/router/app_router.dart';
import '../../../home/presentation/bloc/checkout/checkout_bloc.dart';
import '../widgets/address_tile.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    context.read<GetAddressBloc>().add(OnGetAddress());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Pilih atau tambahkan alamat pengiriman',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SpaceHeight(height: 20.0),
          BlocBuilder<GetAddressBloc, GetAddressState>(
            builder: (context, state) {
              if (state is GetAddressLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetAddressLoaded) {
                return BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, checkoutState) {
                    if (checkoutState is CheckoutLoaded) {
                      final addressId = checkoutState.addressId;
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => AddressTile(
                          isSelected: addressId == state.address[index].id,
                          data: state.address[index],
                          onTap: () {
                            context.read<CheckoutBloc>().add(AddAddressId(
                                addressId: state.address[index].id!));
                          },
                          onEditTap: () {
                            context.goNamed(
                              RouteConstants.editAddress,
                              pathParameters: PathParameters(
                                rootTab: RootTab.order,
                              ).toMap(),
                              extra: state.address[index],
                            );
                          },
                        ),
                        separatorBuilder: (context, index) =>
                            const SpaceHeight(height: 16.0),
                        itemCount: state.address.length,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SpaceHeight(height: 40.0),
          Button.outlined(
            onPressed: () {
              context.pushNamed(
                RouteConstants.addAddress,
                pathParameters: PathParameters(
                  rootTab: RootTab.order,
                ).toMap(),
              );
            },
            label: 'Add address',
          ),
          const SpaceHeight(height: 50.0),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal (Estimasi)',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
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
                          fontSize: 16.0,
                        ),
                      );
                    }
                    return Text(
                      0.currencyFormatRp,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SpaceHeight(height: 12.0),
            Button.filled(
              onPressed: () {
                context.pushNamed(
                  RouteConstants.orderDetail,
                  pathParameters: PathParameters(
                    rootTab: RootTab.order,
                  ).toMap(),
                );
              },
              label: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}

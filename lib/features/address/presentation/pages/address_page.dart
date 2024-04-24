import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/address/presentation/bloc/get_address/get_address_bloc.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/router/app_router.dart';
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
    // final List<AddressModel> addresses = [
    //   AddressModel(
    //     country: 'Indonesia',
    //     firstName: 'Saiful',
    //     lastName: 'Bahri',
    //     address: 'Jl. Merdeka No. 123',
    //     city: 'Jakarta Selatan',
    //     province: 'DKI Jakarta',
    //     zipCode: 12345,
    //     phoneNumber: '08123456789',
    //     isPrimary: true,
    //   ),
    //   AddressModel(
    //     country: 'Indonesia',
    //     firstName: 'Saiful',
    //     lastName: '',
    //     address: 'Jl. Cendrawasih No. 456',
    //     city: 'Bandung',
    //     province: 'Jawa Barat',
    //     zipCode: 67890,
    //     phoneNumber: '08987654321',
    //   ),
    // ];
    // int selectedIndex = addresses.indexWhere((element) => element.isPrimary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
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
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => AddressTile(
                    data: state.address[index],
                    onTap: () {},
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
          ),
          const SpaceHeight(height: 40.0),
          Button.outlined(
            onPressed: () {
              context.goNamed(
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
                Text(
                  20000.currencyFormatRp,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SpaceHeight(height: 12.0),
            Button.filled(
              onPressed: () {
                context.goNamed(
                  RouteConstants.orderDetail,
                  pathParameters: PathParameters(
                    rootTab: RootTab.order,
                  ).toMap(),
                );
              },
              label: 'Lanjutkan',
            ),
          ],
        ),
      ),
    );
  }
}

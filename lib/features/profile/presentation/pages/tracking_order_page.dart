// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';

import 'package:onlineshop_app/features/profile/presentation/bloc/order_detail/order_detail_bloc.dart';
import 'package:onlineshop_app/features/profile/presentation/widgets/product_tile.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/router/app_router.dart';

class TrackingOrderPage extends StatefulWidget {
  final int orderId;
  const TrackingOrderPage({
    super.key,
    required this.orderId,
  });

  @override
  State<TrackingOrderPage> createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {
  @override
  void initState() {
    context
        .read<OrderDetailBloc>()
        .add(OnGetOrderDetail(orderId: widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Orders'),
      ),
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
          if (state is OrderDetailLoading) {
            return const CircleLoading();
          }
          if (state is OrderDetailFailure) {
            return Text(state.message);
          }
          if (state is OrderDetailLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.orderDetail.orderItems!.length,
                  itemBuilder: (context, index) => ProductTile(
                    data: state.orderDetail.orderItems![index],
                  ),
                  separatorBuilder: (context, index) =>
                      const SpaceHeight(height: 16.0),
                ),
                const SpaceHeight(height: 40.0),
                // TrackingHorizontal(trackRecords: trackRecords),
                Button.outlined(
                  onPressed: () {
                    context.pushNamed(
                      RouteConstants.shippingDetail,
                      pathParameters: PathParameters().toMap(),
                      extra: state.orderDetail.shippingResi.toString(),
                    );
                  },
                  label: 'Detail pelacakan pengiriman',
                ),
                const SpaceHeight(height: 20.0),
                const Text(
                  'Info Pengiriman',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SpaceHeight(height: 20.0),
                const Text(
                  'Alamat Pesanan',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  state.orderDetail.address!.fullAddress!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SpaceHeight(height: 16.0),
                const Text(
                  'Penerima',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  state.orderDetail.address!.name!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text('No data'),
          );
        },
      ),
    );
  }
}

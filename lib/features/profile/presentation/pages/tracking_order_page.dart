import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';

import 'package:onlineshop_app/features/profile/presentation/bloc/order_detail/order_detail_bloc.dart';
import 'package:onlineshop_app/features/profile/presentation/widgets/product_tile.dart';
import 'package:onlineshop_app/features/profile/presentation/widgets/row_text.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';
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
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.orderDetail.orderItems!.length,
                  itemBuilder: (context, index) => ProductTile(
                    data: state.orderDetail.orderItems![index],
                  ),
                  separatorBuilder: (context, index) => Divider(
                    height: 50,
                    thickness: 1,
                    color: AppColors.primary.withOpacity(0.5),
                  ),
                ),
                const SpaceHeight(height: 40.0),
                const Text(
                  'Order Detail',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SpaceHeight(height: 10.0),
                RowText(
                  label: 'Penerima',
                  value: state.orderDetail.address!.name!,
                ),
                const SpaceHeight(height: 6.0),
                RowText(
                  label: 'Alamat Pesanan',
                  value: state.orderDetail.address!.fullAddress!,
                ),
                const SpaceHeight(height: 6.0),
                RowText(
                  label: 'No. Resi',
                  value: state.orderDetail.shippingResi!,
                ),
              ],
            );
          }
          return const Center(
            child: Text('No data'),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            BlocBuilder<OrderDetailBloc, OrderDetailState>(
              builder: (context, state) {
                if (state is OrderDetailLoading) {
                  return const CircleLoading();
                }
                if (state is OrderDetailFailure) {
                  return Text(state.message);
                }
                if (state is OrderDetailLoaded) {
                  return Button.filled(
                    onPressed: () {
                      context.pushNamed(
                        RouteConstants.shippingDetail,
                        pathParameters: PathParameters().toMap(),
                        extra: state.orderDetail.shippingResi.toString(),
                      );
                    },
                    label: 'Detail pelacakan pengiriman',
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

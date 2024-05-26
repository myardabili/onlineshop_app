import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/profile/data/models/history_order_model.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/router/app_router.dart';

class OrderCard extends StatelessWidget {
  final HistoryOrder data;
  const OrderCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No. Resi: ${data.shippingResi ?? '-'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  data.status ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                // Button.filled(
                //   onPressed: () {},
                //   label: 'Lacak',
                //   height: 20.0,
                //   width: 94.0,
                //   fontSize: 11.0,
                // ),
              ],
            ),
            const SpaceHeight(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.totalCost!.currencyFormatRp,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Button.filled(
                  onPressed: () {
                    context.pushNamed(
                      RouteConstants.trackingOrder,
                      pathParameters: PathParameters().toMap(),
                      extra: data.id!,
                    );
                  },
                  label: 'Lacak',
                  height: 40.0,
                  width: 150.0,
                  fontSize: 16.0,
                ),
              ],
            ),
            // RowText(label: 'Status', value: data.status ?? '-'),
            // const SpaceHeight(height: 12.0),
            // RowText(
            //     label: 'Total Harga', value: data.totalCost!.currencyFormatRp),
          ],
        ),
      ),
    );
  }
}

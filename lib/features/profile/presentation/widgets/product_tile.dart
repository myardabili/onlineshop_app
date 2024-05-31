import 'package:flutter/material.dart';
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/profile/data/models/order_detail_model.dart';

import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';

class ProductTile extends StatelessWidget {
  final OrderItem data;
  const ProductTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 85,
          width: 85,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.network(
            data.product!.image!.contains('http')
                ? data.product!.image!
                : '${URLs.baseUrlImage}${data.product!.image}',
            fit: BoxFit.cover,
          ),
        ),
        const SpaceWidth(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.product!.name!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SpaceHeight(height: 4),
            Text(
              'Qty: ${data.quantity}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SpaceHeight(height: 4),
            Text(
              data.product!.price!.currencyFormatRp,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

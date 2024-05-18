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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Image.network(
              // '${URLs.baseUrlImage}${data.product!.image!}',
              data.product!.image!.contains('http')
                  ? data.product!.image!
                  : '${URLs.baseUrlImage}${data.product!.image}',
              width: 68.0,
              height: 68.0,
            ),
          ),
          const SpaceWidth(width: 14.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.product!.name!,
                style: const TextStyle(
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${data.product!.price!.currencyFormatRp} x ${data.quantity} = ${(data.product!.price! * data.quantity!).currencyFormatRp}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

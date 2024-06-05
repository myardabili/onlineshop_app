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
      ],
    );
  }
}

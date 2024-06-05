import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:onlineshop_app/features/home/data/models/product_quantity.dart';

import '../../../../api/urls.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';

class CartTile extends StatelessWidget {
  final ProductQuantity data;
  const CartTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _productImage(),
        const SpaceWidth(width: 12),
        _productInfo(context),
      ],
    );
  }

  Widget _productImage() {
    return Container(
      height: 85,
      width: 85,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.network(
        data.product.image!.contains('http')
            ? data.product.image!
            : '${URLs.baseUrlImage}${data.product.image}',
        fit: BoxFit.cover,
      ),
    );
  }
}

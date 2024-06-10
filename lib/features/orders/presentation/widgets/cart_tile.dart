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

  Widget _productInfo(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.product.name!,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.product.price!.currencyFormatRp,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              _buttonQty(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttonQty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: InkWell(
            onTap: () {
              context.read<CheckoutBloc>().add(RemoveItem(item: data.product));
            },
            child: const ColoredBox(
              color: AppColors.primary,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.remove,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        const SpaceWidth(width: 4.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${data.quantity}'),
        ),
        const SpaceWidth(width: 4.0),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: InkWell(
            onTap: () {
              context.read<CheckoutBloc>().add(AddItem(item: data.product));
            },
            child: const ColoredBox(
              color: AppColors.primary,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

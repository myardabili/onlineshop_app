import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ListTileItem extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final Widget leading;
  const ListTileItem({
    super.key,
    required this.label,
    required this.onTap,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        iconColor: AppColors.primary,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: leading,
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: AppColors.primary,
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

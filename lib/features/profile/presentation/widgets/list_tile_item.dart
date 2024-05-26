// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ListTileItem extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final Widget leading;
  final Widget? trailing;
  const ListTileItem({
    super.key,
    required this.label,
    required this.onTap,
    required this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: AppColors.primary,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: leading,
      trailing: trailing,
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:onlineshop_app/core/components/circle_loading.dart';
import 'package:onlineshop_app/core/extensions/int_ext.dart';
import 'package:onlineshop_app/features/home/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:onlineshop_app/features/orders/presentation/bloc/check_payment_status/check_payment_status_bloc.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../data/models/bank_account_model.dart';
import '../bloc/order/order_bloc.dart';
import '../widgets/countdown_timer.dart';

class PaymentWaitingPage extends StatefulWidget {
  final int orderId;
  const PaymentWaitingPage({
    super.key,
    required this.orderId,
  });

  @override
  State<PaymentWaitingPage> createState() => _PaymentWaitingPageState();
}

class _PaymentWaitingPageState extends State<PaymentWaitingPage> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        context
            .read<CheckPaymentStatusBloc>()
            .add(OnCheckPaymentStatus(orderId: widget.orderId));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void onTimerCompletion() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                child: ColoredBox(
                  color: AppColors.white,
                  child: SizedBox(height: 8.0, width: 55.0),
                ),
              ),
              const SpaceHeight(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Successful',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.white,
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SpaceHeight(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Assets.images.processOrder.image(),
              ),
              const SpaceHeight(height: 50.0),
              Row(
                children: [
                  Flexible(
                    child: Button.outlined(
                      onPressed: () {
                        context.pushNamed(
                          RouteConstants.trackingOrder,
                          pathParameters: PathParameters().toMap(),
                        );
                      },
                      label: 'Track Orders',
                    ),
                  ),
                  const SpaceWidth(width: 20.0),
                  Flexible(
                    child: Button.filled(
                      onPressed: () {
                        context.goNamed(
                          RouteConstants.root,
                          pathParameters: PathParameters().toMap(),
                        );
                      },
                      label: 'Back to Home',
                    ),
                  ),
                ],
              ),
              const SpaceHeight(height: 20.0),
            ],
          ),
        );
      },
    );
  }

  @override
  
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/core/components/circle_loading.dart';

import 'package:onlineshop_app/features/profile/presentation/bloc/tracking/tracking_bloc.dart';

import '../../../../core/components/spaces.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/tracking_vertical.dart';

class ShippingDetailPage extends StatefulWidget {
  final String resi;
  const ShippingDetailPage({
    super.key,
    required this.resi,
  });

  @override
  State<ShippingDetailPage> createState() => _ShippingDetailPageState();
}

class _ShippingDetailPageState extends State<ShippingDetailPage> {
  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nomor resi disalin!'),
          duration: Duration(seconds: 1),
          backgroundColor: AppColors.primary,
        ),
      );
    });
  }

  @override
  void initState() {
    context
        .read<TrackingBloc>()
        .add(OnGetTracking(waybill: widget.resi, courier: 'sicepat'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengiriman - ${widget.resi}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // ProductTile(
          //   data: orders.first,
          // ),
          // const SpaceHeight(height: 36.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.stroke),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: BlocBuilder<TrackingBloc, TrackingState>(
              builder: (context, state) {
                if (state is TrackingLoading) {
                  return const CircleLoading();
                }
                if (state is TrackingFailure) {
                  return Text(state.message);
                }
                if (state is TrackingLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Text(
                              'No. Resi',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.resi,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.grey,
                              ),
                            ),
                            const SpaceWidth(width: 5.0),
                            InkWell(
                              onTap: () => copyToClipboard(widget.resi),
                              child: const Text(
                                'SALIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: AppColors.light,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TrackignVertical(
                            trackRecords:
                                state.tracking.rajaongkir?.result?.manifest ??
                                    []),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

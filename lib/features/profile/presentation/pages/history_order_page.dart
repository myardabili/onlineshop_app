import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/features/profile/presentation/widgets/history_order_shimmer.dart';

import '../../../../core/components/spaces.dart';
import '../bloc/history_order/history_order_bloc.dart';
import '../widgets/order_card.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  @override
  void initState() {
    context.read<HistoryOrderBloc>().add(OnGetHistoryOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
        builder: (context, state) {
          if (state is HistoryOrderFailure) {
            return Text(state.message);
          }
          if (state is HistoryOrderLoading) {
            return const HistoryOrderShimmer();
          }
          if (state is HistoryOrderLoaded) {
            if (state.orders.orders!.isEmpty) {
              return const Center(
                child: Text('No Data'),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              separatorBuilder: (context, index) =>
                  const SpaceHeight(height: 16.0),
              itemCount: state.orders.orders!.length,
              itemBuilder: (context, index) => OrderCard(
                data: state.orders.orders![index],
              ),
            );
          }
          return const Center(
            child: Text('Pesanan Anda Belum Ada!'),
          );
        },
      ),
    );
  }
}

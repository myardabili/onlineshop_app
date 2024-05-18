import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:onlineshop_app/features/profile/data/models/history_order_model.dart';
import 'package:onlineshop_app/features/profile/data/models/order_detail_model.dart';
import 'package:onlineshop_app/features/profile/data/models/tracking_model.dart';

import '../../../../core/constants/variable.dart';

class HistoryOrderRemoteDatasource {
  Future<Either<String, HistoryOrderModel>> getOrders() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${URLs.base}/api/orders'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${authData!.accessToken}'
      },
    );
    if (response.statusCode == 200) {
      return Right(HistoryOrderModel.fromJson(response.body));
    } else {
      return const Left('Error');
    }
  }

  Future<Either<String, OrderDetailModel>> getOrderById(int orderId) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${URLs.base}/api/order/$orderId'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${authData!.accessToken}'
      },
    );

    if (response.statusCode == 200) {
      return Right(OrderDetailModel.fromJson(response.body));
    } else {
      return const Left('Error');
    }
  }

  Future<Either<String, TrackingModel>> getWaybill(
      String waybill, String courier) async {
    final response =
        await http.post(Uri.parse('${URLs.baseRO}/waybill'), headers: {
      'key': Variable.rajaOngkirKey,
    }, body: {
      'waybill': waybill,
      'courier': courier,
    });

    if (response.statusCode == 200) {
      return Right(TrackingModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:onlineshop_app/features/orders/data/models/order_model.dart';
import 'package:onlineshop_app/features/orders/data/models/order_request_model.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderModel>> order(
      OrderRequestModel orderRequestModel) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${URLs.base}/api/order'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${authData!.accessToken}'
      },
      body: orderRequestModel.toJson(),
    );
    if (response.statusCode == 200) {
      return Right(OrderModel.fromJson(response.body));
    } else {
      return const Left('Error');
    }
  }
}

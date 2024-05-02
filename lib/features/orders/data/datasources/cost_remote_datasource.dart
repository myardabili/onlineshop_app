import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/core/constants/variable.dart';
import 'package:onlineshop_app/features/orders/data/models/cost_model.dart';

class CostRemoteDatasource {
  Future<Either<String, CostModel>> getCost(
      String origin, String destination, String courier) async {
    final response = await http.post(
      Uri.parse('${URLs.baseRO}/cost'),
      headers: {
        'key': Variable.rajaOngkirKey,
      },
      body: {
        'origin': origin,
        'originType': 'subdistrict',
        'destination': destination,
        'destinationType': 'subdistrict',
        'weight': '1000',
        'courier': courier,
      },
    );
    if (response.statusCode == 200) {
      return Right(CostModel.fromJson(response.body));
    } else {
      return const Left('Error');
    }
  }
}

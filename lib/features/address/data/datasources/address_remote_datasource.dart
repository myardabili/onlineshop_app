import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/features/address/data/models/address_model.dart';
import 'package:onlineshop_app/features/address/data/models/address_request_model.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_local_datasource.dart';

class AddressRemoteDatasource {
  Future<Either<String, AddressModel>> getAddress() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${URLs.base}/api/addresses'),
      headers: {
        'Authorization': 'Bearer ${authData!.accessToken}',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Right(AddressModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, String>> addAddress(AddressRequestModel data) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${URLs.base}/api/addresses'),
      headers: {
        'Authorization': 'Bearer ${authData!.accessToken}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
      body: data.toJson(),
    );
    if (response.statusCode == 201) {
      return const Right('Success');
    } else {
      return const Left('Error');
    }
  }
}

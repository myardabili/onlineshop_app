import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_local_datasource.dart';

import '../models/user_model.dart';

class UserRemoteDatasource {
  Future<Either<String, UserModel>> getUser() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${URLs.base}/api/user'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData!.accessToken}'
      },
    );
    if (response.statusCode == 200) {
      return Right(UserModel.fromJson(response.body));
    } else {
      return const Left('Server error');
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:onlineshop_app/features/auth/data/models/login_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, LoginModel>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('${URLs.base}/api/login'),
      body: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      return Right(LoginModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, LoginModel>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${URLs.base}/api/logout'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      AuthLocalDatasource().removeAuthData;
      return Right(LoginModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}

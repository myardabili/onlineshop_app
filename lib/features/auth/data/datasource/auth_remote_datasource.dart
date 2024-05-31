import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:onlineshop_app/features/auth/data/models/login_model.dart';
import 'package:onlineshop_app/features/auth/data/models/register_model.dart';
import 'package:onlineshop_app/features/auth/data/models/register_request_model.dart';

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

  Future<Either<String, RegisterModel>> register(
      RegisterRequestModel model) async {
    final response = await http.post(
      Uri.parse('${URLs.base}/api/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: model.toJson(),
    );
    if (response.statusCode == 201) {
      return Right(RegisterModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${URLs.base}/api/logout'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      await AuthLocalDatasource().removeAuthData();
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> updateFcmToken(String fcmToken) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response =
        await http.post(Uri.parse('${URLs.base}/api/update-fcm'), headers: {
      'Authorization': 'Bearer ${authData?.accessToken}',
      'Accept': 'application/json',
    }, body: {
      'fcm_id': fcmToken
    });

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}

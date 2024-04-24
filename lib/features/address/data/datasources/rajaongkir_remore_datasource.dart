import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/core/constants/variable.dart';
import 'package:onlineshop_app/features/address/data/models/city_model.dart';
import 'package:onlineshop_app/features/address/data/models/province_model.dart';
import 'package:onlineshop_app/features/address/data/models/subdistrict_model.dart';

class RajaongkirRemoteDatasource {
  Future<Either<String, ProvinceModel>> getProvince() async {
    final response = await http.get(
      Uri.parse('${URLs.baseRO}/province'),
      headers: {
        'key': Variable.rajaOngkirKey,
      },
    );
    if (response.statusCode == 200) {
      return Right(ProvinceModel.fromJson(response.body));
    } else {
      return const Left('Error');
    }
  }

  Future<Either<String, CityModel>> getCity(String provinceId) async {
    final response = await http.get(
      Uri.parse('${URLs.baseRO}/city?province=$provinceId'),
      headers: {
        'key': Variable.rajaOngkirKey,
      },
    );
    if (response.statusCode == 200) {
      return Right(CityModel.fromJson(response.body));
    } else {
      return const Left('Error');
    }
  }

  Future<Either<String, SubdistrictModel>> getSubdistrict(String cityId) async {
    final response = await http.get(
      Uri.parse('${URLs.baseRO}/subdistrict?city=$cityId'),
      headers: {
        'key': Variable.rajaOngkirKey,
      },
    );
    if (response.statusCode == 200) {
      return Right(SubdistrictModel.fromJson(response.body));
    } else {
      return const Left('Error');
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:onlineshop_app/api/urls.dart';
import 'package:onlineshop_app/features/home/data/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  Future<Either<String, CategoryModel>> getCategory() async {
    final response = await http.get(Uri.parse('${URLs.base}/api/categories'));
    if (response.statusCode == 200) {
      return Right(CategoryModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}

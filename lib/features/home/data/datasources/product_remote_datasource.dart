import 'package:dartz/dartz.dart';
import 'package:onlineshop_app/api/urls.dart';
import 'package:http/http.dart' as http;
import 'package:onlineshop_app/features/home/data/models/product_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductModel>> allProduct() async {
    final response = await http.get(Uri.parse('${URLs.base}/api/products'));
    if (response.statusCode == 200) {
      return Right(ProductModel.fromJson(response.body));
      // return Right(List<ProductModel>.from(
      //     jsonDecode(response.body).map((x) => ProductModel.fromMap(x))));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, ProductModel>> productCategory(int categoryId) async {
    final response = await http
        .get(Uri.parse('${URLs.base}/api/products?category_id=$categoryId'));
    if (response.statusCode == 200) {
      return Right(ProductModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}

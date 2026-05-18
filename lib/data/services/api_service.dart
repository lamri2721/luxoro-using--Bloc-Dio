import 'package:dio/dio.dart';
import '../model/product_model.dart';

class ApiService {
  final Dio dio = Dio();

  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get(baseUrl);

    return (response.data as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }

  Future<void> addProduct(ProductModel product) async {
    await dio.post(baseUrl, data: product.toJson());
  }

  Future<void> updateProduct(ProductModel product) async {
    await dio.put(
      '$baseUrl/${product.id}',
      data: product.toJson(),
    );
  }

  Future<void> deleteProduct(int id) async {
    await dio.delete('$baseUrl/$id');
  }
}

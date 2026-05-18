import '../model/product_model.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService apiService = ApiService();

  Future<List<ProductModel>> getProducts() {
    return apiService.getProducts();
  }

  Future<void> addProduct(ProductModel product) {
    return apiService.addProduct(product);
  }

  Future<void> updateProduct(ProductModel product) {
    return apiService.updateProduct(product);
  }

  Future<void> deleteProduct(int id) {
    return apiService.deleteProduct(id);
  }
}

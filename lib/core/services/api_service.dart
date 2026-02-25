import '../models/product_model.dart';
import '../models/user_model.dart';
import '../utils/constants/api_constants.dart';
import 'network_caller.dart';

class ApiService {
  static Future<List<ProductModel>> getAllProducts() async {
    final response = await NetworkCaller.getRequest(ApiConstants.products);
    if (response.isSuccess) {
      final List<dynamic> data = response.body;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    }
    throw Exception(response.errorMessage ?? 'Failed to load products');
  }

  static Future<List<String>> getCategories() async {
    final response = await NetworkCaller.getRequest(ApiConstants.categories);
    if (response.isSuccess) {
      final List<dynamic> data = response.body;
      return data.cast<String>();
    }
    throw Exception(response.errorMessage ?? 'Failed to load categories');
  }

  static Future<List<ProductModel>> getProductsByCategory(
    String category,
  ) async {
    final response = await NetworkCaller.getRequest(
      ApiConstants.productsByCategory(category),
    );
    if (response.isSuccess) {
      final List<dynamic> data = response.body;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    }
    throw Exception(
      response.errorMessage ?? 'Failed to load products for $category',
    );
  }

  static Future<String?> login(String username, String password) async {
    final response = await NetworkCaller.postRequest(
      ApiConstants.login,
      body: {'username': username, 'password': password},
    );
    if (response.isSuccess) {
      return response.body['token'] as String?;
    }
    return null;
  }

  static Future<UserModel?> getUserProfile(int userId) async {
    final response = await NetworkCaller.getRequest(ApiConstants.user(userId));
    if (response.isSuccess) {
      return UserModel.fromJson(response.body);
    }
    return null;
  }
}

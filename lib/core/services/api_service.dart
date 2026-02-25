import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';
import '../models/user_model.dart';

/// Centralized API service for FakeStore API.
///
/// Endpoints used:
/// - GET  /products              → All products
/// - GET  /products/categories   → Category list
/// - GET  /products/category/:cat → Products by category
/// - POST /auth/login            → Login (returns JWT token)
/// - GET  /users/:id             → User profile
class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  /// Fetch all products.
  static Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      }
      throw Exception('Failed to load products: ${response.statusCode}');
    } catch (e) {
      debugPrint('Error fetching products: $e');
      rethrow;
    }
  }

  /// Fetch all category names.
  static Future<List<String>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/products/categories'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>();
      }
      throw Exception('Failed to load categories: ${response.statusCode}');
    } catch (e) {
      debugPrint('Error fetching categories: $e');
      rethrow;
    }
  }

  /// Fetch products by category.
  static Future<List<ProductModel>> getProductsByCategory(
    String category,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/products/category/$category'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      }
      throw Exception(
        'Failed to load products for $category: ${response.statusCode}',
      );
    } catch (e) {
      debugPrint('Error fetching products by category: $e');
      rethrow;
    }
  }

  /// Login with username and password.
  /// Returns a JWT token string on success.
  static Future<String?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['token'] as String?;
      }
      return null;
    } catch (e) {
      debugPrint('Error logging in: $e');
      return null;
    }
  }

  /// Fetch user profile by ID.
  static Future<UserModel?> getUserProfile(int userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users/$userId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserModel.fromJson(data);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
      return null;
    }
  }
}

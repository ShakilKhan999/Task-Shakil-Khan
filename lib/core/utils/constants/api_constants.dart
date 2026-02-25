class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://fakestoreapi.com';

  static const String products = '/products';
  static const String categories = '/products/categories';
  static String productsByCategory(String category) =>
      '/products/category/$category';
  static const String login = '/auth/login';
  static String user(int id) => '/users/$id';
}

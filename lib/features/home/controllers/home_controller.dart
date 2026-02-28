import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/product_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/api_service.dart';

class HomeController extends GetxController {
  final RxList<String> categories = <String>[].obs;
  final RxInt currentTabIndex = 0.obs;

  final RxList<ProductModel> currentProducts = <ProductModel>[].obs;
  final Map<String, List<ProductModel>> _categoryProductsCache = {};
  final RxList<ProductModel> allProducts = <ProductModel>[].obs;

  final RxBool isLoading = true.obs;
  final RxBool isRefreshing = false.obs;

  final RxBool isLoggedIn = false.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoginLoading = false.obs;

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    _loadInitialData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> _loadInitialData() async {
    try {
      isLoading.value = true;

      final results = await Future.wait([
        ApiService.getCategories(),
        ApiService.getAllProducts(),
      ]);

      categories.value = results[0] as List<String>;
      allProducts.value = results[1] as List<ProductModel>;

      for (final product in allProducts) {
        _categoryProductsCache
            .putIfAbsent(product.category, () => [])
            .add(product);
      }

      currentProducts.value = List.from(allProducts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void switchTab(int index) {
    if (currentTabIndex.value == index) return;
    currentTabIndex.value = index;

    if (index == 0) {
      currentProducts.value = List.from(allProducts);
    } else {
      final category = categories[index - 1];
      currentProducts.value = List.from(_categoryProductsCache[category] ?? []);
    }
  }

  Future<void> refreshProducts() async {
    try {
      isRefreshing.value = true;

      if (currentTabIndex.value == 0) {
        final products = await ApiService.getAllProducts();
        allProducts.value = products;

        _categoryProductsCache.clear();
        for (final product in allProducts) {
          _categoryProductsCache
              .putIfAbsent(product.category, () => [])
              .add(product);
        }
        currentProducts.value = List.from(allProducts);
      } else {
        final category = categories[currentTabIndex.value - 1];
        final products = await ApiService.getProductsByCategory(category);
        _categoryProductsCache[category] = products;
        currentProducts.value = List.from(products);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to refresh. Please try again.');
    } finally {
      isRefreshing.value = false;
    }
  }

  void swipeToNextTab() {
    final maxIndex = categories.length;
    if (currentTabIndex.value < maxIndex) {
      switchTab(currentTabIndex.value + 1);
    }
  }

  void swipeToPreviousTab() {
    if (currentTabIndex.value > 0) {
      switchTab(currentTabIndex.value - 1);
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      isLoginLoading.value = true;
      final token = await ApiService.login(username, password);

      if (token != null) {
        final user = await ApiService.getUserProfile(1);
        if (user != null) {
          currentUser.value = user;
          isLoggedIn.value = true;
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      isLoginLoading.value = false;
    }
  }

  void logout() {
    isLoggedIn.value = false;
    currentUser.value = null;
  }
}

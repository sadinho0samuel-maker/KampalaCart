import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

final productServiceProvider = Provider((ref) => ProductService());

final productsProvider = FutureProvider.family<List<ProductModel>, int>((ref, page) async {
  final service = ref.watch(productServiceProvider);
  return service.getProducts(page: page);
});

final productDetailProvider = FutureProvider.family<ProductModel, String>((ref, productId) async {
  final service = ref.watch(productServiceProvider);
  return service.getProductById(productId);
});

final productSearchProvider = FutureProvider.family<List<ProductModel>, String>((ref, query) async {
  final service = ref.watch(productServiceProvider);
  if (query.isEmpty) return [];
  return service.searchProducts(query);
});

final productsByCategoryProvider =
    FutureProvider.family<List<ProductModel>, String>((ref, category) async {
  final service = ref.watch(productServiceProvider);
  return service.getProductsByCategory(category);
});

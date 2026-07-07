import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/product_model.dart';

class ProductService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.timeout,
      receiveTimeout: ApiConfig.timeout,
    ),
  );

  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20}) async {
    try {
      final response = await _dio.get(
        '/products',
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = response.data['data'] as List;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await _dio.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<ProductModel>> getProductsByCategory(
    String category, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/products/category/$category',
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = response.data['data'] as List;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<ProductModel>> searchProducts(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/products/search',
        queryParameters: {'q': query, 'page': page, 'limit': limit},
      );
      final data = response.data['data'] as List;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    if (error.response != null) {
      return error.response?.data['message'] ?? 'An error occurred';
    }
    return error.message ?? 'Network error';
  }
}

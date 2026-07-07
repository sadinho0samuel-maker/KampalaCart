import 'package:dio/dio.dart';
import '../config/api_config.dart';

class CartService {
  final Dio _dio;

  CartService(this._dio) {
    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.connectTimeout = ApiConfig.timeout;
    _dio.options.receiveTimeout = ApiConfig.timeout;
  }

  Future<Map<String, dynamic>> getCart() async {
    try {
      final response = await _dio.get('/cart');
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> addItem({
    required String productId,
    required int quantity,
    required num price,
  }) async {
    try {
      final response = await _dio.post(
        '/cart/add',
        data: {
          'productId': productId,
          'quantity': quantity,
          'price': price,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateItem(String productId, int quantity) async {
    try {
      await _dio.put(
        '/cart/$productId',
        data: {'quantity': quantity},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> removeItem(String productId) async {
    try {
      await _dio.delete('/cart/$productId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> clearCart() async {
    try {
      await _dio.delete('/cart');
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

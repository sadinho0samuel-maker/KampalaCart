import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/order_model.dart';

class OrderService {
  final Dio _dio;

  OrderService(this._dio) {
    _dio.options.baseUrl = ApiConfig.baseUrl;
    _dio.options.connectTimeout = ApiConfig.timeout;
    _dio.options.receiveTimeout = ApiConfig.timeout;
  }

  Future<OrderModel> createOrder({
    required List<Map<String, dynamic>> items,
    required num total,
    required String shippingAddress,
  }) async {
    try {
      final response = await _dio.post(
        '/orders',
        data: {
          'items': items,
          'total': total,
          'shippingAddress': shippingAddress,
        },
      );
      return OrderModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<OrderModel>> getOrders({int page = 1, int limit = 20}) async {
    try {
      final response = await _dio.get(
        '/orders',
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = response.data['data'] as List;
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<OrderModel> getOrderById(String id) async {
    try {
      final response = await _dio.get('/orders/$id');
      return OrderModel.fromJson(response.data);
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

class OrderModel {
  final String id;
  final String status;
  final num total;
  final String paymentStatus;
  final String createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.total,
    required this.paymentStatus,
    required this.createdAt,
    this.items = const [],
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      status: json['status'] ?? 'pending',
      total: json['total'] ?? 0,
      paymentStatus: json['paymentStatus'] ?? 'pending',
      createdAt: json['createdAt'] ?? '',
      items: (json['items'] as List?)
              ?.map((item) => OrderItemModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class OrderItemModel {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final num price;

  OrderItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      quantity: json['quantity'] ?? 1,
      price: json['price'] ?? 0,
    );
  }
}

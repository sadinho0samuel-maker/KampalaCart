class CartItemModel {
  final String id;
  final String productId;
  final String productName;
  final num productPrice;
  final String? productImage;
  int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    this.productImage,
    this.quantity = 1,
  });

  num get total => productPrice * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productPrice: json['productPrice'] ?? 0,
      productImage: json['productImage'],
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'productName': productName,
        'productPrice': productPrice,
        'productImage': productImage,
        'quantity': quantity,
      };
}

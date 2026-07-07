class ProductModel {
  final String id;
  final String name;
  final String description;
  final num price;
  final num discountPercentage;
  final String category;
  final int stock;
  final List<String> images;
  final num rating;
  final int reviewCount;
  final bool isActive;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPercentage = 0,
    required this.category,
    required this.stock,
    this.images = const [],
    this.rating = 0,
    this.reviewCount = 0,
    this.isActive = true,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      discountPercentage: json['discountPercentage'] ?? 0,
      category: json['category'] ?? '',
      stock: json['stock'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
      rating: json['rating'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'category': category,
        'stock': stock,
        'images': images,
        'rating': rating,
        'reviewCount': reviewCount,
        'isActive': isActive,
      };

  num get discountedPrice => price * (1 - (discountPercentage / 100));
}

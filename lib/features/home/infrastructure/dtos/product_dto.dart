import '../../domain/product.dart';

/// Data Transfer Object for [Product].
class ProductDto {
  const ProductDto({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.rating = 0.0,
    this.description = '',
    this.imageUrl = '',
    this.sizes = const [],
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final String description;
  final String imageUrl;
  final List<String> sizes;

  factory ProductDto.fromJson(Map<String, dynamic> json, {String? docId}) {
    return ProductDto(
      id: docId ?? json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      sizes: (json['sizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'rating': rating,
      'description': description,
      'imageUrl': imageUrl,
      'sizes': sizes,
    };
  }

  Product toDomain() {
    return Product(
      id: id,
      name: name,
      category: category,
      price: price,
      rating: rating,
      description: description,
      imageUrl: imageUrl,
      sizes: sizes,
    );
  }
}

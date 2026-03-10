import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String category,
    required double price,
    @Default(0.0) double rating,
    @Default('') String description,
    @Default('') String imageUrl,
    @Default([]) List<String> sizes,
  }) = _Product;

  const Product._();

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

import 'package:stok_takip_uygulamasi/model/ProductCategory.dart';
import 'package:stok_takip_uygulamasi/model/ProductVariantElements.dart';

class Product {
  List<Null>? productTransactions;
  List<ProductVariantElements>? productVariantElements;

  ProductCategory? category;
  int? categoryId;
  String productName;
  String? barkod;
  String? urunKimlikNo;
  String? sistemSeriNo;
  int? id;

  Product({
    this.productTransactions,
    this.productVariantElements,
    this.category,
    this.categoryId,
    required this.productName,
    this.barkod,
    this.urunKimlikNo,
    this.sistemSeriNo,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final items = json['productVariantElements']?.cast<Map<String, dynamic>>();

    return Product(
      categoryId: json['categoryId'],
      productName: json['productName'],
      barkod: json['barkod'],
      urunKimlikNo: json['urunKimlikNo'],
      sistemSeriNo: json['sistemSeriNo'],
      id: json['id'],
      category: json['category'] != null ? new ProductCategory.fromJson(json['category']) : null,
      productVariantElements: json['productVariantElements'] != null ? List<ProductVariantElements>.from(items?.map(
                (itemsJson) => ProductVariantElements.fromJsonModel(itemsJson))) : null
    );
  }

  static Product fromJsonModel(Map<String, dynamic> json) =>
      Product.fromJson(json);
}

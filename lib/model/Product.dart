import 'package:stok_takip_uygulamasi/model/Category.dart';
import 'package:stok_takip_uygulamasi/model/ProductVariantElements.dart';

class Product {
  List<Null>? productTransactions;
  List<ProductVariantElements> productVariantElements;

  Category category;
  int? categoryId;
  String? productName;
  String? barkod;
  String? urunKimlikNo;
  String? sistemSeriNo;
  int? id;

  Product({
    this.productTransactions,
    required this.productVariantElements,
    required this.category,
    this.categoryId,
    this.productName,
    this.barkod,
    this.urunKimlikNo,
    this.sistemSeriNo,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final items = json['productVariantElements'].cast<Map<String, dynamic>>();


    return Product(
        categoryId: json['categoryId'],
        productName: json['productName'],
        barkod: json['barkod'],
        urunKimlikNo: json['urunKimlikNo'],
        sistemSeriNo: json['sistemSeriNo'],
        id: json['id'],
        category: Category.fromJson(json['category']),
        productVariantElements: List<ProductVariantElements>.from(items.map((itemsJson) => ProductVariantElements.fromJsonModel(itemsJson))),
    );

  }


  static Product fromJsonModel(Map<String, dynamic> json) =>
      Product.fromJson(json);
}

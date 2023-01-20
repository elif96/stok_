import 'package:stok_takip_uygulamasi/model/VariantElement.dart';

class ProductVariantElements {
  VariantElement variantElement;
  int? productId;
  int? variantElementId;
  int? id;

  ProductVariantElements(
      {required this.variantElement,
      this.productId,
      this.variantElementId,
      this.id});

  factory ProductVariantElements.fromJson(Map<String, dynamic> json) {
    return ProductVariantElements(
        variantElement: VariantElement.fromJson(json['variantElement']),
        productId: json['productId'],
        variantElementId: json['variantElementId'],
        id: json['id']);
  }

  static ProductVariantElements fromJsonModel(Map<String, dynamic> json) =>
      ProductVariantElements.fromJson(json);
}

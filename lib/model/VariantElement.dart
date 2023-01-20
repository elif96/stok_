import 'package:stok_takip_uygulamasi/model/Variant.dart';

class VariantElement{
  Variant variant;
  Null? variantElementDtos;
  int? variantId;
  String? varyantElemanAdi;
  int? id;

  VariantElement(
      {required this.variant,
        this.variantElementDtos,
        this.variantId,
        this.varyantElemanAdi,
        this.id});

  factory VariantElement.fromJson(Map<String, dynamic> json) {
    return VariantElement(
        variant: Variant.fromJson(json['variant']),
        variantElementDtos: json['variantElementDtos'],
        variantId: json['variantId'],
        varyantElemanAdi: json['varyantElemanAdi'],
        id: json['id']
    );
  }

  static VariantElement fromJsonModel(Map<String, dynamic> json) =>
      VariantElement.fromJson(json);
}
import 'package:stok_takip_uygulamasi/model/BaseCategory.dart';
import 'package:stok_takip_uygulamasi/model/Marka.dart';
import 'package:stok_takip_uygulamasi/model/Model.dart';
import 'package:stok_takip_uygulamasi/model/Product.dart';
import 'package:stok_takip_uygulamasi/model/Varyant.dart';

class Category {
  String? ad;
  int? brandId;
  int? brandModelId;
  int? baseCategoryId;
  int? birim;
  int? envanterTuru;
  String? barkod;
  int? id;

  Category({
    this.ad,
    this.brandId,
    this.brandModelId,
    this.baseCategoryId,
    this.birim,
    this.envanterTuru,
    this.barkod,
    this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      ad: json['ad'],
      brandId: json['brandId'],
      brandModelId: json['brandModelId'],
      baseCategoryId: json['baseCategoryId'],
      birim: json['birim'],
      envanterTuru: json['envanterTuru'],
      barkod: json['barkod'],
      id: json['id'],
    );
  }

  static Category fromJsonModel(Map<String, dynamic> json) =>
      Category.fromJson(json);

}
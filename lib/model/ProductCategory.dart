class ProductCategory {
  String? ad;
  int? brandId;
  int? brandModelId;
  int? baseCategoryId;
  int? birim;
  int? envanterTuru;
  String? barkod;
  int? id;


  ProductCategory({
    this.ad,
    this.brandId,
    this.brandModelId,
    this.baseCategoryId,
    this.birim,
    this.envanterTuru,
    this.barkod,
    this.id});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
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

  static ProductCategory fromJsonModel(Map<String, dynamic> json) =>
      ProductCategory.fromJson(json);
}
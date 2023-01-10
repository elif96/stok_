class Product {
  int? categoryId;
  String? productName;
  String? barkod;
  String? urunKimlikNo;
  String? sistemSeriNo;
  int? id;

  Product(
      {this.categoryId,
      this.productName,
      this.barkod,
      this.urunKimlikNo,
      this.sistemSeriNo,
      this.id});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        categoryId: json['categoryId'],
        productName: json['productName'],
        barkod: json['barkod'],
        urunKimlikNo: json['urunKimlikNo'],
        sistemSeriNo: json['sistemSeriNo'],
        id: json['id']);
  }

  static Product fromJsonModel(Map<String, dynamic> json) =>
      Product.fromJson(json);
}

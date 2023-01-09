class Product {
  int? id;
  int? categoryId;
  String? barkod;
  String? urunKimlikNo;
  String? sistemSeriNo;
  String? productName;

  Product({required id, required categoryId, required barkod, required urunKimlikNo, required sistemSeriNo, required productName});


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['categoryId'],
      barkod: json['barkod'],
      urunKimlikNo: json['urunKimlikNo'],
      sistemSeriNo: json['sistemSeriNo'],
      productName: json['productName'],
    );
  }

  static Product fromJsonModel(Map<String, dynamic> json) => Product.fromJson(json);

}

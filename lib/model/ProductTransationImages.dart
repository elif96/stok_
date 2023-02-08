class ProductTransactionImages{
  String? imageFileName;
  int? productTransactionId;
  int? id;

  ProductTransactionImages(
      {
        this.imageFileName,
        this.productTransactionId,
        this.id
      });
  factory ProductTransactionImages.fromJson(Map<String, dynamic> json) {
    return ProductTransactionImages(
        imageFileName: json['imageFileName'],
        productTransactionId: json['productTransactionId'],
        id: json['id']
    );
  }

  static ProductTransactionImages fromJsonModel(Map<String, dynamic> json) =>
      ProductTransactionImages.fromJson(json);
}
class Model {
  int? brandId;
  String? modelAdi;
  int? id;

  Model({this.brandId, this.modelAdi, this.id});


  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      brandId: json['brandId'],
      modelAdi: json['modelAdi'],
      id: json['id'],
    );
  }

  static Model fromJsonModel(Map<String, dynamic> json) => Model.fromJson(json);

}

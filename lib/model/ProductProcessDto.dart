class ProductProcessDto {
  String? islemAdi;
  String? islemAciklama;
  int? islemTuru;
  String? onayIsteyenUser;
  String? onayiBeklenenUser;
  int? anaDepoId;
  int? hedefDepoID;
  String? islemTarihi;
  int? id;

  ProductProcessDto({this.islemAdi,
    this.islemAciklama,
    this.islemTuru,
    this.onayIsteyenUser,
    this.onayiBeklenenUser,
    this.anaDepoId,
    this.hedefDepoID,
    this.islemTarihi,
    this.id});

  factory ProductProcessDto.fromJson(Map<String, dynamic> json) {
    return ProductProcessDto(
      islemAciklama: json['islemAciklama'],
      islemTuru: json['islemTuru'],
      onayIsteyenUser: json['onayIsteyenUser'],
      onayiBeklenenUser: json['onayiBeklenenUser'],
      anaDepoId: json['anaDepoId'],
      hedefDepoID: json['hedefDepoID'],
      islemTarihi: json['islemTarihi'],
      id: json['id'],
    );
  }

  static ProductProcessDto fromJsonModel(Map<String, dynamic> json) => ProductProcessDto.fromJson(json);

}

// class ProductProcessDto {
//   String? islemAdi;
//   String? islemAciklama;
//   int? islemTuru;
//   String? onayIsteyenUser;
//   String? onayiBeklenenUser;
//   int? anaDepoId;
//   int? hedefDepoID;
//   String? islemTarihi;
//   int? id;
//
//   ProductProcessDto(
//       {this.islemAdi,
//         this.islemAciklama,
//         this.islemTuru,
//         this.onayIsteyenUser,
//         this.onayiBeklenenUser,
//         this.anaDepoId,
//         this.hedefDepoID,
//         this.islemTarihi,
//         this.id});
//
//   factory ProductProcessDto.fromJson(Map<String, dynamic> json) {
//     return ProductProcessDto(
//         islemAdi: json['islemAdi'],
//         islemAciklama: json['islemAciklama'],
//         islemTuru: json['islemTuru'],
//         onayIsteyenUser: json['onayIsteyenUser'],
//         onayiBeklenenUser: json['onayiBeklenenUser'],
//         anaDepoId: json['anaDepoId'],
//         hedefDepoID: json['hedefDepoID'],
//         islemTarihi: json['islemTarihi'],
//         id: json['id']);
//   }
//
//   static ProductProcessDto fromJsonModel(Map<String, dynamic> json) =>
//       ProductProcessDto.fromJson(json);
// }

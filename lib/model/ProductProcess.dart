// class ProductProcess {
//   List<ProductProcessData> data = <ProductProcessData>[];
//   Null errors;
//
//   ProductProcess({required this.data, this.errors});
//
//   ProductProcess.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <ProductProcessData>[];
//       json['data'].forEach((v) {
//         data.add(new ProductProcessData.fromJson(v));
//       });
//     }
//     errors = json['errors'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     data['errors'] = this.errors;
//     return data;
//   }
// }

import 'package:stok_takip_uygulamasi/model/AnaDepo.dart';
import 'package:stok_takip_uygulamasi/model/HedefDepo.dart';
import 'package:stok_takip_uygulamasi/model/ProductTransactions.dart';

class ProductProcess {
  List<ProductTransactions>? productTransactions;

  AnaDepo? anaDepo;
  HedefDepo? hedefDepo;
  String? islemAdi;
  String? islemAciklama;
  int? islemTuru;
  String? onayIsteyenUser;
  String? onayiBeklenenUser;
  int? anaDepoId;
  int? hedefDepoID;
  String? islemTarihi;
  String? onayTarihi;
  String? onayciAciklamasi;
  int? id;

  ProductProcess(
      {this.productTransactions,
      this.anaDepo,
      this.hedefDepo,
      this.islemAdi,
      this.islemAciklama,
      this.islemTuru,
      this.onayIsteyenUser,
      this.onayiBeklenenUser,
      this.anaDepoId,
      this.hedefDepoID,
      this.islemTarihi,
      this.onayTarihi,
      this.onayciAciklamasi,
      this.id});

  factory ProductProcess.fromJson(Map<String, dynamic> json) {
    final items = json['productTransactions']?.cast<Map<String, dynamic>>();
    return ProductProcess(
      islemAdi: json['islemAdi'],
      islemAciklama: json['islemAciklama'],
      islemTuru: json['islemTuru'],
      onayIsteyenUser: json['onayIsteyenUser'],
      onayiBeklenenUser: json['onayiBeklenenUser'],
      anaDepoId: json['anaDepoId'],
      hedefDepoID: json['hedefDepoID'],
      islemTarihi: json['islemTarihi'],
      id: json['id'],
      anaDepo: json['anaDepo'] != null ? new AnaDepo.fromJson(json['anaDepo']) : null,
      hedefDepo: json['hedefDepo'] != null ? new HedefDepo.fromJson(json['hedefDepo']) : null,

        productTransactions: json['productTransactions'] != null ? List<ProductTransactions>.from(items?.map(
              (itemsJson) => ProductTransactions.fromJsonModel(itemsJson))) : null
    );
  }

  static ProductProcess fromJsonModel(Map<String, dynamic> json) =>
      ProductProcess.fromJson(json);
}

class ProductProcess {
  List<ProductProcessData> data = <ProductProcessData>[];
  Null errors;

  ProductProcess({required this.data, this.errors});

  ProductProcess.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductProcessData>[];
      json['data'].forEach((v) {
        data.add(new ProductProcessData.fromJson(v));
      });
    }    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class ProductProcessData {
  String? islemAdi;
  String? islemAciklama;
  int? islemTuru;
  String? onayIsteyenUser;
  String? onayiBeklenenUser;
  int? anaDepoId;
  int? hedefDepoID;
  String? islemTarihi;
  int? id;

  ProductProcessData(
      {this.islemAdi,
        this.islemAciklama,
        this.islemTuru,
        this.onayIsteyenUser,
        this.onayiBeklenenUser,
        this.anaDepoId,
        this.hedefDepoID,
        this.islemTarihi,
        this.id});

  ProductProcessData.fromJson(Map<String, dynamic> json) {
    islemAdi = json['islemAdi'];
    islemAciklama = json['islemAciklama'];
    islemTuru = json['islemTuru'];
    onayIsteyenUser = json['onayIsteyenUser'];
    onayiBeklenenUser = json['onayiBeklenenUser'];
    anaDepoId = json['anaDepoId'];
    hedefDepoID = json['hedefDepoID'];
    islemTarihi = json['islemTarihi'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['islemAdi'] = this.islemAdi;
    data['islemAciklama'] = this.islemAciklama;
    data['islemTuru'] = this.islemTuru;
    data['onayIsteyenUser'] = this.onayIsteyenUser;
    data['onayiBeklenenUser'] = this.onayiBeklenenUser;
    data['anaDepoId'] = this.anaDepoId;
    data['hedefDepoID'] = this.hedefDepoID;
    data['islemTarihi'] = this.islemTarihi;
    data['id'] = this.id;
    return data;
  }
}
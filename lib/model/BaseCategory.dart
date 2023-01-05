class BaseCategory {
  String? hesapKodu;
  String? duzey1;
  String? duzey2;
  String? duzey3;
  String? duzey4;
  String? duzey5;
  String? duzeyKodu;
  String? malzemeAdi;
  int? parentId;
  int? id;

  BaseCategory({this.hesapKodu,
    this.duzey1,
    this.duzey2,
    this.duzey3,
    this.duzey4,
    this.duzey5,
    this.duzeyKodu,
    this.malzemeAdi,
    this.parentId,
    this.id});

  factory BaseCategory.fromJson(Map<String, dynamic> json) {
    return BaseCategory(
        hesapKodu: json['hesapKodu'],
        duzey1: json['duzey1'],
        duzey2: json['duzey2'],
        duzey3: json['duzey3'],
        duzey4: json['duzey4'],
        duzey5: json['duzey5'],
        duzeyKodu: json['duzeyKodu'],
        malzemeAdi: json['malzemeAdi'],
        parentId: json['parentId'],
        id: json['id'],
    );
  }

  static BaseCategory fromJsonModel(Map<String, dynamic> json) =>
      BaseCategory.fromJson(json);

}

class Data {
  String? hesapKodu;
  String? duzey1;
  String? duzey2;
  String? duzey3;
  String? duzey4;
  String? duzey5;
  String? duzeyKodu;
  String? malzemeAdi;
  int? parentId;
  int? id;

  Data({this.hesapKodu,
    this.duzey1,
    this.duzey2,
    this.duzey3,
    this.duzey4,
    this.duzey5,
    this.duzeyKodu,
    this.malzemeAdi,
    this.parentId,
    this.id});

  Data.fromJson(Map<String, dynamic> json) {
    hesapKodu = json['hesapKodu'];
    duzey1 = json['duzey1'];
    duzey2 = json['duzey2'];
    duzey3 = json['duzey3'];
    duzey4 = json['duzey4'];
    duzey5 = json['duzey5'];
    duzeyKodu = json['duzeyKodu'];
    malzemeAdi = json['malzemeAdi'];
    parentId = json['parentId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hesapKodu'] = this.hesapKodu;
    data['duzey1'] = this.duzey1;
    data['duzey2'] = this.duzey2;
    data['duzey3'] = this.duzey3;
    data['duzey4'] = this.duzey4;
    data['duzey5'] = this.duzey5;
    data['duzeyKodu'] = this.duzeyKodu;
    data['malzemeAdi'] = this.malzemeAdi;
    data['parentId'] = this.parentId;
    data['id'] = this.id;
    return data;
  }
}
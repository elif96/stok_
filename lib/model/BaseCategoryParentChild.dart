class BaseCategoryParentChild {
  List<BaseCategoryParentChildData> data = <BaseCategoryParentChildData>[];
  Null? errors;

  BaseCategoryParentChild({required this.data, this.errors});

  BaseCategoryParentChild.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BaseCategoryParentChildData>[];
      json['data'].forEach((v) {
        data.add(new BaseCategoryParentChildData.fromJson(v));
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

class BaseCategoryParentChildData {
  List<Children>? children;
  Parent? parent;
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

  BaseCategoryParentChildData(
      {this.children,
        this.parent,
        this.hesapKodu,
        this.duzey1,
        this.duzey2,
        this.duzey3,
        this.duzey4,
        this.duzey5,
        this.duzeyKodu,
        this.malzemeAdi,
        this.parentId,
        this.id});

  BaseCategoryParentChildData.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
    parent =
    json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
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
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
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

class Children {
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

  Children(
      {this.hesapKodu,
        this.duzey1,
        this.duzey2,
        this.duzey3,
        this.duzey4,
        this.duzey5,
        this.duzeyKodu,
        this.malzemeAdi,
        this.parentId,
        this.id});

  Children.fromJson(Map<String, dynamic> json) {
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

class Parent {
  String? hesapKodu;
  String? duzey1;
  String? duzey2;
  String? duzey3;
  String? duzey4;
  String? duzey5;
  String? duzeyKodu;
  String? malzemeAdi;
  Null? parentId;
  int? id;

  Parent(
      {this.hesapKodu,
        this.duzey1,
        this.duzey2,
        this.duzey3,
        this.duzey4,
        this.duzey5,
        this.duzeyKodu,
        this.malzemeAdi,
        this.parentId,
        this.id});

  Parent.fromJson(Map<String, dynamic> json) {
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
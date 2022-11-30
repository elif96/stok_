// class Marka {
//   int? id;
//   String? markaAdi;
//
//   Marka({this.id, this.markaAdi});
//
//   Marka.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     markaAdi = json['markaAdi'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['markaAdi'] = this.markaAdi;
//     return data;
//   }
// }

class Marka {
  List<Data> data = <Data>[];
  Null errors;

  Marka({required this.data, this.errors});
 

  Marka.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    errors = json['errors'];
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

class Data {
  String? markaAdi;
  int? id;

  Data({this.markaAdi, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    markaAdi = json['markaAdi'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['markaAdi'] = this.markaAdi;
    data['id'] = this.id;
    return data;
  }
}
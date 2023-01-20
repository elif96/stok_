class Variant {
  String? varyantAdi;
  int? id;

  Variant({this.varyantAdi, this.id});

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
    varyantAdi: json['varyantAdi'],
    id: json['id'],
    );
  }

  static Variant fromJsonModel(Map<String, dynamic> json) => Variant.fromJson(json);

}





// class Varyant {
//   List<Data> data = <Data>[];
//   Null errors;
//
//   Varyant({required this.data, this.errors});
//
//
//   Varyant.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data.add(new Data.fromJson(v));
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
//
// class Data {
//   String? varyantAdi;
//   int? id;
//
//   Data({this.varyantAdi, this.id});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     varyantAdi = json['varyantAdi'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['varyantAdi'] = this.varyantAdi;
//     data['id'] = this.id;
//     return data;
//   }
// }
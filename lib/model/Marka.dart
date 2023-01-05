class Marka {
  String? markaAdi;
  int? id;

  Marka({this.markaAdi, this.id});

  factory Marka.fromJson(Map<String, dynamic> json) {
    return Marka(
      markaAdi: json['markaAdi'],
      id: json['id'],
    );
  }

  static Marka fromJsonModel(Map<String, dynamic> json) => Marka.fromJson(json);

}


// class Data {
//   String? markaAdi;
//   int? id;
//
//   Data({this.markaAdi, this.id});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     markaAdi = json['markaAdi'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['markaAdi'] = this.markaAdi;
//     data['id'] = this.id;
//     return data;
//   }
// }
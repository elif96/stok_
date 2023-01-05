class Deneme {
  List<dynamic> data = <dynamic>[];
  Null errors;

  Deneme({required this.data, this.errors});

 fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <dynamic>[];
      json['data'].forEach((v) {
        data.add(new Warehouses.fromJson(v));
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

class Warehouses {
  int? cins;
  String? ad;
  int? departmentId;
  int? biUserId;
  int? id;

  Warehouses({this.cins, this.ad, this.departmentId, this.biUserId, this.id});

  Warehouses.fromJson(Map<String, dynamic> json) {
    cins = json['cins'];
    ad = json['ad'];
    departmentId = json['departmentId'];
    biUserId = json['biUserId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cins'] = this.cins;
    data['ad'] = this.ad;
    data['departmentId'] = this.departmentId;
    data['biUserId'] = this.biUserId;
    data['id'] = this.id;
    return data;
  }
}
class AnaDepo{
  int? cins;
  String? ad;
  int? departmentId;
  String? username;
  int? id;

  AnaDepo({this.cins, this.ad, this.departmentId, this.username, this.id});

  factory AnaDepo.fromJson(Map<String, dynamic> json) {
    return AnaDepo(
      cins: json['cins'],
      ad: json['ad'],
      departmentId: json['departmentId'],
      username: json['username'],
      id: json['id'],
        );
  }

  static AnaDepo fromJsonModel(Map<String, dynamic> json) =>
      AnaDepo.fromJson(json);
}
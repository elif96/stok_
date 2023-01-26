class HedefDepo{
  int? cins;
  String? ad;
  int? departmentId;
  String? username;
  int? id;

  HedefDepo({this.cins, this.ad, this.departmentId, this.username, this.id});

  factory HedefDepo.fromJson(Map<String, dynamic> json) {
    return HedefDepo(
      cins: json['cins'],
      ad: json['ad'],
      departmentId: json['departmentId'],
      username: json['username'],
      id: json['id'],
    );
  }

  static HedefDepo fromJsonModel(Map<String, dynamic> json) =>
      HedefDepo.fromJson(json);
}
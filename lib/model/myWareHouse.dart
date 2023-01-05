class myWareHouse {
  int? cins;
  String? ad;
  int? departmentId;
  int? biUserId;
  int? id;
  myWareHouse({this.cins, this.ad, this.departmentId, this.biUserId, this.id});


  factory myWareHouse.fromJson(Map<String, dynamic> json) {
    return myWareHouse(
      cins: json["cins"],
      ad: json["ad"],
      departmentId: json["departmentId"],
      biUserId: json["biUserId"],
      id: json["id"],
    );
    }
  // Magic goes here. you can use this function to from json method.
  static myWareHouse fromJsonModel(Map<String, dynamic> json) => myWareHouse.fromJson(json);
}

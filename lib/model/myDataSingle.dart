class myDataSingle<T> {
  T? data;
  Null errors;

  myDataSingle({this.data, this.errors});

  factory myDataSingle.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return myDataSingle<T>(
      errors: json["errors"],
      data: create(json["data"]),
    );
  }


}


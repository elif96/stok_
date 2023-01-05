class myData<T> {
  List<T>? data;
  Null errors;

  myData({this.data, this.errors});

  factory myData.fromJson(Map<String, dynamic> json, Function fromJsonModel) {
    final items = json['data'].cast<Map<String, dynamic>>();
    return myData<T>(
      errors: json['errors'],
      data: List<T>.from(items.map((itemsJson) => fromJsonModel(itemsJson))),
    );
  }
}

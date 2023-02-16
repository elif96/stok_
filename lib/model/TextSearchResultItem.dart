class TextSearchResultItem {
  final String label;
  dynamic value;

  TextSearchResultItem({required this.label, this.value});

  factory TextSearchResultItem.fromJson(Map<String, dynamic> json) {
    return TextSearchResultItem(label: json['label'], value: json['value']);
  }
}

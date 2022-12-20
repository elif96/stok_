class Envanter{
  late String title;
  late String description;

  Envanter({required this.title, required this.description});


  factory Envanter.fromJson(Map<String, dynamic> json) {
    return Envanter(
      title :json['title'] as String,
      description :json['description'] as String,

    );

  }
}
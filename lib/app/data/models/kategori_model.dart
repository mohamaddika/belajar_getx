class Kategori {
  int id;
  String title;
  // String image;

  Kategori({
    required this.id,
    required this.title,
    // required this.image,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'],
      title: json['title'],
      // image: json['image'],
    );
  }
}

class Eslatma {
  int? id;
  String title;
  String detail;

  Eslatma({this.id, required this.title, required this.detail});

  // From Map to Eslatma object
  factory Eslatma.fromMap(Map<String, dynamic> json) => Eslatma(
        id: json['id'],
        title: json['title'],
        detail: json['detail'],
      );

  // From Eslatma object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
    };
  }
}

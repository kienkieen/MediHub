class Diseases {
  String id;
  String name;

  Diseases({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Diseases.fromMap(Map<String, dynamic> map) {
    return Diseases(id: map['id'] ?? '', name: map['name'] ?? '');
  }
}

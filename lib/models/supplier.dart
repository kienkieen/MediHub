class Supplier {
  String id;
  String name;

  Supplier({required this.id, required this.name});
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(id: map['id'] ?? '', name: map['name'] ?? '');
  }
}

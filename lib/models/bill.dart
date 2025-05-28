class Bill {
  final String id;
  final String paymentMethod;
  final double totalAmount;
  final DateTime dueDate;
  final bool isPaid;

  Bill({
    required this.id,
    required this.paymentMethod,
    required this.totalAmount,
    required this.dueDate,
    required this.isPaid,
  });

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'] as String,
      paymentMethod: map['paymentMethod'] as String,
      totalAmount: (map['totalAmount'] as num).toDouble(),
      dueDate: DateTime.parse(map['dueDate'] as String),
      isPaid: map['isPaid'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'dueDate': dueDate.toIso8601String(),
      'isPaid': isPaid,
    };
  }
}

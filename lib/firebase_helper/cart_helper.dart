import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/models/cart.dart';

Future<Cart> getCartbyUserID(String userId) async {
  final cartRef = FirebaseFirestore.instance.collection('GIOHANG').doc(userId);

  final docSnapshot = await cartRef.get();
  if (!docSnapshot.exists) {
    Cart c =
        Cart(userId: userId)
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();

    await insertData("GIOHANG", c.userId!, c.toMap());
    return c;
  }

  final data = docSnapshot.data()!;
  final cart =
      Cart(userId: userId)
        ..createdAt = (data['createdAt'] as Timestamp).toDate()
        ..updatedAt = (data['updatedAt'] as Timestamp).toDate();

  if (data['vaccineItems'] != null) {
    var vaccines = List<CartVaccineItem>.from(
      (data['vaccineItems'] as List).map(
        (item) => CartVaccineItem.fromMap(item),
      ),
    );

    cart.setVaccineItems(vaccines);
  }

  if (data['vaccinePackages'] != null) {
    var vaccninePackages = List<CartVaccinePackage>.from(
      (data['vaccinePackages'] as List).map(
        (item) => CartVaccinePackage.fromMap(item),
      ),
    );
    cart.setVaccinePackages(vaccninePackages);
  }

  return cart;
}

Future<bool> saveCart(Cart cart) async {
  final cartRef = FirebaseFirestore.instance
      .collection('GIOHANG')
      .doc(cart.userId);

  final data = {
    'createdAt': cart.createdAt,
    'updatedAt': cart.updatedAt,
    'vaccineItems': cart.vaccineItems.map((item) => item.toMap()).toList(),
    'vaccinePackages':
        cart.vaccinePackages.map((item) => item.toMap()).toList(),
  };

  try {
    await cartRef.set(data, SetOptions(merge: true));
    return true;
  } catch (e) {
    print('Error saving cart: $e');
    return false;
  }
}

Future<void> clearCart(String userId) async {
  final cartRef = FirebaseFirestore.instance.collection('GIOHANG').doc(userId);
  await cartRef.update({
    'vaccineItems': [],
    'vaccinePackages': [],
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

Future<void> deleteCart(String userId) async {
  final cartRef = FirebaseFirestore.instance.collection('GIOHANG').doc(userId);
  await cartRef.delete();
}

Future<void> removeVaccineFromCart(String userId, String vaccineId) async {
  final cartRef = FirebaseFirestore.instance.collection('GIOHANG').doc(userId);
  await cartRef.update({
    'vaccineItems': FieldValue.arrayRemove([
      {
        'vaccine': {'id': vaccineId},
      },
    ]),
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

Future<void> removePackageFromCart(String userId, String packageId) async {
  final cartRef = FirebaseFirestore.instance.collection('GIOHANG').doc(userId);
  await cartRef.update({
    'vaccinePackages': FieldValue.arrayRemove([
      {
        'package': {'id': packageId},
      },
    ]),
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

Future<void> addVaccineToCart(String userId, CartVaccineItem item) async {
  final cartRef = FirebaseFirestore.instance.collection('GIOHANG').doc(userId);
  await cartRef.update({
    'vaccineItems': FieldValue.arrayUnion([item.toMap()]),
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

Future<void> addPackageToCart(String userId, CartVaccinePackage package) async {
  final cartRef = FirebaseFirestore.instance.collection('GIOHANG').doc(userId);
  await cartRef.update({
    'vaccinePackages': FieldValue.arrayUnion([package.toMap()]),
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

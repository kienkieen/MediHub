import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/models/booking.dart';

Future<List<Booking>> getAllBookingByIDUser(String idUser) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance
          .collection('DATLICHTIEM')
          .where('idUser', isEqualTo: idUser)
          .get();

  List<Map<String, dynamic>> dataList =
      snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

  List<Booking> bookings =
      dataList.map((data) => Booking.fromMap(data)).toList();

  return bookings;
}

Future<void> deleteBooking(String idBooking) async {
  try {
    await FirebaseFirestore.instance
        .collection('DATLICHTIEM')
        .doc(idBooking)
        .delete();
  } catch (e) {
    print('Error deleting booking: $e');
  }
}

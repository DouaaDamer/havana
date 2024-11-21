// lib/controller/attendees_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:havana/models/attendee_model.dart';

class AttendeesController extends GetxController {
  var attendees = <DateTime, List<AttendeeModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendees();
  }

  Future<void> fetchAttendees() async {
    FirebaseFirestore.instance
        .collection('customer_registration')
        .snapshots()
        .listen((snapshot) {
      attendees.clear(); // مسح البيانات القديمة

      for (var doc in snapshot.docs) {
        var attendee =
            AttendeeModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        DateTime date = DateTime(attendee.calendar.year,
            attendee.calendar.month, attendee.calendar.day);

        // إضافة الحضور إلى القاموس
        attendees.putIfAbsent(date, () => []).add(attendee);
      }

      // ترتيب الحضور حسب التاريخ (الأحدث أولاً) لكل يوم
      attendees.forEach((date, attendeeList) {
        attendeeList.sort((a, b) =>
            b.calendar.compareTo(a.calendar)); // ترتيب تنازلي حسب الوقت
      });
    });
  }

  List<MapEntry<DateTime, List<AttendeeModel>>> getSortedAttendees() {
    // تحويل المفاتيح إلى قائمة وترتيبها
    List<MapEntry<DateTime, List<AttendeeModel>>> sortedEntries =
        attendees.entries.toList();
    sortedEntries.sort((a, b) => b.key.compareTo(a.key)); // ترتيب تنازلي
    return sortedEntries;
  }

  void showSignatureDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Signature'),
          content: Container(
            width: double.maxFinite,
            child: Image.network(imageUrl),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                imageUrl = '';
                Navigator.of(context).pop(); // إغلاق الحوار
              },
            ),
          ],
        );
      },
    );
  }
}

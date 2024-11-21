// lib/model/attendee_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendeeModel {
  final String id;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String company;
  final String jop;
  final String imageURL;
  final String signature;
  final bool isAgree;
  final DateTime calendar;

  AttendeeModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.company,
    required this.jop,
    required this.imageURL,
    required this.signature,
    required this.calendar,
    required this.isAgree,
  });

  factory AttendeeModel.fromJson(Map<String, dynamic> json, String id) {
    return AttendeeModel(
      id: id,
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      phone: json['phone'],
      company: json['company'].toString(),
      jop: json['jop'].toString(),
      imageURL: json['imageURL'],
      signature: json['signature'],
      isAgree: json['isAgree'] ?? false,
      calendar: (json['calendar'] as Timestamp).toDate(),
    );
  }
}

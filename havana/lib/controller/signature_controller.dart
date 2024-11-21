import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signature/signature.dart';

class UserModel {
  String fname;
  String lname;
  String email;
  String phone;
  String company;
  String jop;
  String imageURL;
  bool isAgree;

  // تأكد من وجود هذه الخاصية في النموذج

  UserModel({
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.company,
    required this.jop,
    this.imageURL = '',
    this.isAgree = false,

    // تعيين قيمة افتراضية
  });
}

class SignatureController_ extends GetxController {
  var isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: "havana-e1afa.appspot.com");
  var isAgree = false.obs;
  var userModel = UserModel(
    fname: '',
    lname: '',
    email: '',
    phone: '',
    company: '',
    jop: "",
    imageURL: '', // تأكد من تعيين قيمة افتراضية
    isAgree: false,
  ).obs;

  late SignatureController _signatureController;

  List<List<Offset>> _strokeHistory = []; // تأكد من أن هذا من نوع Offset
  int _currentStrokeIndex = -1;

  SignatureController_() {
    _signatureController = SignatureController(
      penColor: Colors.black,
      penStrokeWidth: 5,
      onDrawStart: () => update(),
      onDrawEnd: () {
        _currentStrokeIndex++;
        _strokeHistory = _strokeHistory.sublist(0, _currentStrokeIndex);
        // قم بإضافة النقاط إلى التاريخ
        _strokeHistory
            .add(List.from(_signatureController.points)); // فقط نسخ النقاط
      },
    );
  }

  SignatureController get controller => _signatureController;

  bool get canUndo => _currentStrokeIndex > -1;
  bool get canRedo => _currentStrokeIndex < _strokeHistory.length - 1;

  void undo() {
    if (canUndo) {
      _currentStrokeIndex--;
      _signatureController.clear();
      for (int i = 0; i <= _currentStrokeIndex; i++) {
        _signatureController.points.addAll(List.from(_strokeHistory[i]));
      }
      _signatureController;
    }
  }

  void redo() {
    if (canRedo) {
      _currentStrokeIndex++;
      _signatureController.points
          .addAll(List.from(_strokeHistory[_currentStrokeIndex]));
      _signatureController;
    }
  }

  Future<void> addUser(String downloadUrl) async {
    // الحصول على التاريخ الحالي
    DateTime now = DateTime.now();

    // توليد 6 أرقام عشوائية
    String randomId = Random()
        .nextInt(1000000)
        .toString()
        .padLeft(6, '0'); // يولد أرقام عشوائية مكونة من 6 أرقام
    String userId = randomId; // تكوين المعرف الكامل

    await _firestore.collection('customer_registration').doc(userId).set({
      // استخدم set() لإنشاء مستند باسم id
      "id": userId,
      "fname": userModel.value.fname,
      "lname": userModel.value.lname,
      "email": userModel.value.email,
      "phone": userModel.value.phone,
      "company": userModel.value.company,
      "jop": userModel.value.jop,
      "imageURL": userModel.value.imageURL,
      "signature": downloadUrl,
      "isAgree": isAgree.value,
      "calendar": Timestamp.now(),
    }).then((value) {
      Get.offAllNamed('/pagehome');

      AwesomeDialog(
        context: Get.context!,
        animType: AnimType.rightSlide,
        dialogType: DialogType.success,
        title: 'نجاح',
        desc: 'تم تسجيل بيانات العميل',
      ).show();
      print("User Added");
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<String> uploadImage(Uint8List imageBytes) async {
    final ref = _storage
        .ref()
        .child('signatures/${DateTime.now().toIso8601String()}.png');

    await ref.putData(imageBytes);
    String downloadUrl = await ref.getDownloadURL();
    print('Download URL: $downloadUrl');
    return downloadUrl;
  }
}

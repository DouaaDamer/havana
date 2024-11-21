import 'package:flutter/material.dart';

class PersonalInfoController {
  TextEditingController fname = TextEditingController(text: 'test');
  TextEditingController lname = TextEditingController(text: 'test');
  TextEditingController email = TextEditingController(text: 'test@t');
  TextEditingController phone = TextEditingController(text: '123');
  TextEditingController company = TextEditingController(text: 'test');
  TextEditingController jop = TextEditingController(text: 'test');

  GlobalKey<FormState> formState0 = GlobalKey<FormState>();

  String? validateInput(String? val, String fieldName) {
    if (val == null || val.isEmpty) {
      return "$fieldName can't be empty";
    }

    // يمكن إضافة تحقق إضافي حسب نوع المدخل
    if (fieldName == 'email') {
      // تحقق من صيغة البريد الإلكتروني
      final RegExp emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(val)) {
        return "Invalid email format";
      }
    }

    // تحقق إضافي لرقم الهاتف (يمكنك تخصيص ذلك حسب الحاجة)
    if (fieldName == 'mobile phone' && (val.length < 10 || val.length > 15)) {
      return "Phone number must be between 10 and 15 digits";
    }

    return null;
  }
}

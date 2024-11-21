import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:havana/models/auth_model.dart';

class AuthController extends GetxController {
  final AuthModel _authModel = AuthModel();

  // تعريف متغير لتخزين المستخدم الحالي
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  // تسجيل الدخول بالبريد الإلكتروني
  Future<void> loginWithEmail(
      String email, String password, BuildContext context) async {
    try {
      User? user = await _authModel.signInWithEmail(email, password);
      if (user != null && user.emailVerified) {
        _authModel.sendEmailVerification(user);
        _showDialog(context, "Error",
            "الرجاء التوجه لبريدك الالكتروني والضغط على رابط تفعيل حسابك");
      } else {
        Get.offNamed("pagehome");
      }
    } catch (e) {
      _handleError(context, e);
    }
  }

  // التسجيل بالبريد الإلكتروني
  Future<void> registerWithEmail(
      String email, String password, BuildContext context) async {
    try {
      User? user = await _authModel.signUpWithEmail(email, password);
      if (user != null) {
        _authModel.sendEmailVerification(user);
        Navigator.of(context).pushReplacementNamed("pagehome");
      }
    } catch (e) {
      _handleError(context, e);
    }
  }

  // تسجيل الدخول عبر جوجل
  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      User? user = await _authModel.signInWithGoogle();
      if (user != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("pagehome", (route) => false);
      }
    } catch (e) {
      _handleError(context, e);
    }
  }

  // استعادة كلمة المرور
  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _authModel.resetPassword(email);
      _showDialog(
          context, "reset password", "الرجاء التوجه لبريدك الالكتروني ");
    } catch (e) {
      _showDialog(context, "Error",
          "الرجاء التأكد بان البريد الالكتروني صحيح ثم قم باعادة المحاولة ");
    }
  }

  // عرض رسالة الخطأ
  void _handleError(BuildContext context, e) {
    if (e.code == 'user-not-found') {
      _showDialog(context, 'Error', 'No user found for that email');
    } else if (e.code == 'wrong-password') {
      _showDialog(context, 'Error', 'Wrong password provided for that user.');
    }
  }

  // عرض حوار
  void _showDialog(BuildContext context, String title, String message) {
    AwesomeDialog(
      context: context,
      animType: AnimType.rightSlide,
      dialogType: DialogType.error,
      title: title,
      desc: message,
    ).show();
  }
}

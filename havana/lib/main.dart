import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:havana/view/screens/auth/login.dart';
import 'package:havana/view/screens/auth/signup.dart';
import 'package:havana/view/screens/pagehome.dart';
import 'package:havana/view/screens/camer_capture.dart';
import 'controller/auth_controller.dart';
import 'core/bindings/auth_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBd1nbsRaT-65VnmAxBB50VYOR6qIQk26k",
      appId: "1:1012144702759:android:1da8e5af88d6f06e33d502",
      messagingSenderId: "1012144702759",
      projectId: "havana-e1afa",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: AuthBinding(),
          home: auth.firebaseUser.value != null ? PageHome() : Login(),
          getPages: [
            GetPage(name: '/signup', page: () => SignUp()),
            GetPage(name: '/login', page: () => Login()),
            GetPage(name: '/pagehome', page: () => PageHome()),
            GetPage(name: '/camerascapture', page: () => CamersCapture()),
          ],
        );
      },
    );
  }
}

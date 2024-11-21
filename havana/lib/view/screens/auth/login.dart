import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:havana/controller/auth_controller.dart';
import 'package:havana/component/custombuttonauth.dart';
import 'package:havana/component/customlogoauth.dart';
import 'package:havana/component/textformfiled.dart';

class Login extends StatelessWidget {
  // الحصول على الـ AuthController
  final AuthController authController = Get.put(AuthController());

  // مفاتيح للتحقق من صحة النموذج
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  // عناصر التحكم في النصوص
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  const CustomLogoAuth(),
                  SizedBox(height: 20),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Login To Continue Using The App",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  CustomTextForm(
                    hinttext: "Enter Your Email",
                    mycontroller: emailController,
                    validator: (val) {
                      if (val == "") {
                        return "can't be Empty";
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  CustomTextForm(
                    hinttext: "Enter Your Password",
                    mycontroller: passwordController,
                    validator: (val) {
                      if (val == "") {
                        return "can't be Empty";
                      }
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      if (emailController.text == "") {
                        authController.resetPassword(
                            emailController.text, context);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButtonAuth(
              title: "login",
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  await authController.loginWithEmail(
                    emailController.text,
                    passwordController.text,
                    context,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.deepOrange,
              textColor: Colors.white,
              onPressed: () {
                authController.loginWithGoogle(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login With Google  "),
                  Image.asset(
                    "assest/image/4.png",
                    width: 20,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.offNamed("signup");
              },
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't Have An Account? ",
                      ),
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

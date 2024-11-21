import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:havana/component/builttextformperinfo.dart';
import 'package:havana/component/custombuttonauth.dart';
import 'package:havana/controller/personal_info_controller.dart';
import 'package:havana/view/screens/camer_capture.dart';

class Personalinfo extends StatelessWidget {
  const Personalinfo({super.key});

  @override
  Widget build(BuildContext context) {
    final PersonalInfoController controller =
        PersonalInfoController(); // إنشاء الكنترولر

    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Registration'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: controller.formState0, // تأكد من تعيين مفتاح الحالة هنا
            child: Column(children: [
              //firstname
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: AddTextForm(
                    hinttext: "first name",
                    mycontroller: controller.fname,
                    validator: (value) =>
                        controller.validateInput(value, 'first name')),
              ),

              //last name
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: AddTextForm(
                    hinttext: "last name",
                    mycontroller: controller.lname,
                    validator: (value) =>
                        controller.validateInput(value, 'last name')),
              ),

              //Email
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: AddTextForm(
                    keyboardType: TextInputType.emailAddress,
                    hinttext: "Email",
                    mycontroller: controller.email,
                    validator: (value) =>
                        controller.validateInput(value, 'email')),
              ),

              //phone
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: AddTextForm(
                    keyboardType: TextInputType.phone,
                    hinttext: "mobile phone",
                    mycontroller: controller.phone,
                    validator: (value) =>
                        controller.validateInput(value, 'mobile phone')),
              ),
              //company
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: AddTextForm(
                    hinttext: "company",
                    mycontroller: controller.company,
                    validator: (value) =>
                        controller.validateInput(value, 'company')),
              ),
              //jop
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: AddTextForm(
                    hinttext: "jop",
                    mycontroller: controller.jop,
                    validator: (value) =>
                        controller.validateInput(value, 'jop')),
              ),

              CustomButtonAuth(
                title: "Next",
                onPressed: () {
                  // التحقق من جميع الحقول
                  if (controller.fname.text.isNotEmpty &&
                      controller.lname.text.isNotEmpty &&
                      controller.email.text.isNotEmpty &&
                      controller.phone.text.isNotEmpty &&
                      controller.company.text.isNotEmpty &&
                      controller.jop.text.isNotEmpty) {
                    Get.to(
                      () => CamersCapture(
                        fname: controller.fname.text,
                        lname: controller.lname.text,
                        email: controller.email.text,
                        phone: controller.phone.text,
                        company: controller.company.text,
                        jop: controller.company.text,
                      ),
                    );

                    // قم بتعليق هذه الأسطر إذا كنت تريد مسح الحقول بعد الإرسال
                    // controller.fname.clear();
                    // controller.lname.clear();
                    // controller.email.clear();
                    // controller.phone.clear();
                  } else {
                    // عرض رسالة خطأ إذا كانت هناك حقول فارغة
                    Get.snackbar(
                      "خطأ",
                      "يرجى ملء جميع الحقول",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

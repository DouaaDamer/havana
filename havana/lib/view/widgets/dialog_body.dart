import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:havana/controller/signature_controller.dart';

class CheckBoxBody extends StatelessWidget {
  final SignatureController_ controller = Get.find<SignatureController_>();

  CheckBoxBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'لا مانع لدي من تصويري واستخدام المادة المصورة من فيديو او صورة لاستخدامات اعلانيه لصالح شركة هافانا للاستثمار وعلامتها التجاريه'),
            Checkbox(
              value: controller.isAgree.value,
              onChanged: (value) {
                controller.isAgree.value = value!;
              },
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

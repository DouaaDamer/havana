import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:havana/component/custombuttonauth.dart';
import 'package:havana/controller/camers_capture_controller.dart';
import 'package:havana/view/screens/sighnature.dart';

class CamersCapture extends StatefulWidget {
  final String? fname;
  final String? lname;
  final String? email;
  final String? phone;
  final String? company;
  final String? jop;
  const CamersCapture({
    super.key,
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.company,
    this.jop,
  });

  @override
  State<CamersCapture> createState() => _CamersCaptureState();
}

class _CamersCaptureState extends State<CamersCapture> {
  final CamersCaptureController controller = CamersCaptureController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    if (controller.url != null) ...[
                      Stack(
                        children: [
                          Image.network(
                            controller.url!,
                            width: 300,
                            height: 300,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            bottom: 0,
                            top: 0,
                            left: 0,
                            right: 0,
                            child: MaterialButton(
                              color: Colors.black26,
                              onPressed: () async {
                                await controller.getImage();
                                setState(
                                    () {}); // تحديث الواجهة بعد التقاط الصورة
                              },
                              child: const Text(
                                "Retake the picture",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ] else
                      MaterialButton(
                        onPressed: () async {
                          await controller.getImage();
                          setState(() {}); // تحديث الواجهة بعد التقاط الصورة
                        },
                        child: const Text("Take a picture"),
                      ),
                    if (controller.isLoading.value)
                      Center(child: CircularProgressIndicator()),
                    CustomButtonAuth(
                      title: "Next",
                      onPressed: () {
                        if (controller.url != null) {
                          Get.off(() => SignaturePad(
                                fname: widget.fname,
                                lname: widget.lname,
                                email: widget.email,
                                phone: widget.phone,
                                company: widget.company,
                                jop: widget.jop,
                                cameraURL: controller.url,
                              ));
                        } else {
                          Get.snackbar('Alert', 'يرجى التقاط صورة');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

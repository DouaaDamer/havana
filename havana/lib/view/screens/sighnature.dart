import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:havana/view/widgets/dialog_body.dart';
import 'package:signature/signature.dart';
import '../../controller/signature_controller.dart';

import 'package:get/get.dart';

class SignaturePad extends StatelessWidget {
  final String? fname;
  final String? lname;
  final String? email;
  final String? phone;
  final String? company;
  final String? jop;
  final String? cameraURL;

  SignaturePad({
    super.key,
    this.fname,
    this.lname,
    this.email,
    this.phone,
    this.company,
    this.jop,
    this.cameraURL,
  });

  final SignatureController_ _controller = Get.put(SignatureController_());
  final GlobalKey _signatureKey = GlobalKey(); // مفتاح RepaintBoundary

  @override
  Widget build(BuildContext context) {
    _controller.userModel.update((val) {
      val?.fname = fname ?? '';
      val?.lname = lname ?? '';
      val?.email = email ?? '';
      val?.phone = phone ?? '';
      val?.company = company ?? '';
      val?.jop = jop ?? '';
      val?.imageURL = cameraURL!;
    });

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Signature Pad'),
          actions: [
            if (!_controller.isLoading.value)
              IconButton(
                onPressed: () async {
                  AwesomeDialog(
                    context: Get.context!,
                    animType: AnimType.rightSlide,
                    dialogType: DialogType.info,
                    title: 'تنبيه',
                    btnOkText: 'نعم',
                    body: CheckBoxBody(),
                    btnOkOnPress: () async {
                      _controller.isLoading.value = true;
                      Uint8List? imageBytes = await _capturePng();
                      if (imageBytes != null) {
                        String downloadUrl =
                            await _controller.uploadImage(imageBytes);
                        await _controller.addUser(downloadUrl);
                        _controller.isLoading.value = false;
                      }
                    },
                  ).show();
                },
                icon: const Icon(Icons.save),
              )
            else
              const CircularProgressIndicator(),
            IconButton(
              onPressed: _controller.canUndo ? _controller.undo : null,
              icon: const Icon(Icons.undo),
            ),
            IconButton(
              onPressed: _controller.canRedo ? _controller.redo : null,
              icon: const Icon(Icons.redo),
            ),
          ],
        ),
        body: RepaintBoundary(
          key: _signatureKey, // تحديد المفتاح
          child: Signature(
            controller: _controller.controller,
            backgroundColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _signatureKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary; // استخدام المفتاح
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      print(e);
      return null;
    }
  }
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class CamersCaptureController extends GetxController {
  var file = Rxn<File>();
  var isLoading = false.obs;
  String? url;

  Future<void> getImage() async {
    isLoading.value = true;
    final ImagePicker picker = ImagePicker();
    final XFile? imageCamera =
        await picker.pickImage(source: ImageSource.camera);

    if (imageCamera != null) {
      final storage =
          FirebaseStorage.instanceFor(bucket: "havana-e1afa.appspot.com");
      final extension = p.extension(imageCamera.path);
      final ref = storage
          .ref()
          .child('Camera/${DateTime.now().toIso8601String()}$extension');

      await ref.putFile(
        File(imageCamera.path),
        SettableMetadata(contentType: 'image/jpg'),
      );
      isLoading.value = false;
      url = await ref.getDownloadURL();
    }
  }
}

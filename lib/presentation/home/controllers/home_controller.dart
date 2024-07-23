import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Player? player;
  // VideoController? controller;

  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
  }
}

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MediaService {
  static MediaService instance = MediaService();

  Future<File> getImageFromLibrary() async {
    PickedFile? file = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 60);
    return File(file!.path);
  }
}

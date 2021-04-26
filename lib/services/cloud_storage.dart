import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  Reference _baseRef  = FirebaseStorage.instance.ref();
  

  String _noticeImages = "notice_images";
  String _teamsImages = "team_images";

  static CloudStorageService instance = CloudStorageService();

  Future<TaskSnapshot?> uploadNoticeImage(File image) async {
    try {
      return await _baseRef.child(_noticeImages).putFile(image).then((snapshot) => snapshot);
    } catch (e) {
      return null;
    }
  }

  Future<TaskSnapshot?> uploadTeamImage(File image) async {
    try {
      return await _baseRef.child(_teamsImages).putFile(image).then((snapshot) => snapshot);
    } catch (e) {
      return null;
    }
  }
}

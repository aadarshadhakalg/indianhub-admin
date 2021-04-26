import 'dart:io';
import 'package:admin/models/team_model.dart';
import 'package:admin/services/firestore_helper.dart';
import 'package:admin/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TeamsState { Loading, Normal }

class TeamsController extends GetxController {
  MediaService _mediaService = MediaService();
  FirestoreHelper _firestoreHelper = FirestoreHelper();

  Rx<TeamsState> currentState = Rx<TeamsState>(TeamsState.Normal);
  TextEditingController teamNameController = TextEditingController();
  Rx<File?> teamImage = Rx<File?>(null);

  Future<List<TeamModel>> getAllTeams() async {
    return await _firestoreHelper.getAllTeams();
  }

  Future<void> pickImage() async{
    try{
    teamImage.value = await _mediaService.getImageFromLibrary();
    }catch(e){
      Get.rawSnackbar(
        message: e.toString(),
        title: "Error",
      );
    }
  }

 Future<void> addTeam() async{
   currentState.value = TeamsState.Loading;
   try{
    await _firestoreHelper.addTeam(
      teamImage: teamImage.value!,
      teamName: teamNameController.text,
    );
    teamNameController.text = '';
    teamImage.value = null;
     Get.rawSnackbar(title: 'Success',message: 'Successfully Created Team');
   }catch(e){
     Get.rawSnackbar(title: 'Error',message: e.toString());
   }
   currentState.value = TeamsState.Normal;
  }
}

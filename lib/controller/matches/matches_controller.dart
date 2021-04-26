import 'dart:io';

import 'package:admin/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MatchesControllerStates { Loading, Normal }

class MatchesController extends GetxController {
  Rx<MatchesControllerStates> currentState =
      Rx<MatchesControllerStates>(MatchesControllerStates.Normal);
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  Rx<TimeOfDay> selectedTime = Rx<TimeOfDay>(TimeOfDay.now());
  TextEditingController teamAnameController = TextEditingController();
  Rx<File> teamAimage = Rx<File>(File(''));
  TextEditingController teamBnameController = TextEditingController();
  Rx<File> teamBimage = Rx<File>(File(''));



  Future<void> pickImage(String team)async{
    if(team == 'A'){
      teamAimage.value =await MediaService.instance.getImageFromLibrary();
    }else{
      teamBimage.value =await MediaService.instance.getImageFromLibrary();
    }
  }


  Future<void> addMatch() async{
    
  }
}

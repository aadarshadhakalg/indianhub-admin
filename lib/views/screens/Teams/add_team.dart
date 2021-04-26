import 'package:admin/controller/teams/teams_controller.dart';
import 'package:admin/services/validator.dart';
import 'package:admin/views/components/form_input_field.dart';
import 'package:admin/views/components/form_verticle_spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTeam extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teams'),
      ),
      body: GetX(builder: (TeamsController controller) {
        if (controller.currentState.value == TeamsState.Normal) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
                child: Column(
              children: [
                FormVerticalSpace(),
                FormInputField(
                  controller: controller.teamNameController,
                  labelText: 'Team Name',
                  validator: Validator().name,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      controller.teamNameController.text = value!,
                ),
                FormVerticalSpace(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: controller.teamImage.value != null
                        ? FileImage(controller.teamImage.value!)
                        : null,
                  ),
                  isThreeLine: true,
                  title: Text('Pick Image'),
                  subtitle: Text(
                      '${controller.teamImage.value != null ? controller.teamImage.value!.path.split('/').last : 'No File Choosen'}'),
                  onTap: () async {
                    await controller.pickImage();
                  },
                ),
                FormVerticalSpace(),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if(controller.teamImage.value != null){
                      await controller.addTeam();
                      }else{
                        Get.rawSnackbar(
                          title: 'Image is required',
                          message: 'Please select a Image',
                        );
                      }
                    }
                  },
                  child: Text('Add Team'),
                )
              ],
            )),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

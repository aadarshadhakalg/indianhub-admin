import 'package:admin/controller/matches/matches_controller.dart';
import 'package:admin/services/validator.dart';
import 'package:admin/views/components/form_input_field.dart';
import 'package:admin/views/components/form_verticle_spacer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddMatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Match'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetX(builder: (MatchesController controller) {
          if (controller.currentState.value == MatchesControllerStates.Normal) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormVerticalSpace(),
                    FormInputField(
                      controller: controller.teamAnameController,
                      labelText: 'Team A',
                      validator: Validator().notEmpty,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          controller.teamAnameController.text = value!,
                    ),
                    FormVerticalSpace(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(controller.teamAimage.value),
                      ),
                      isThreeLine: true,
                      title: Text('Pick Image'),
                      subtitle: Text(
                          '${controller.teamAimage.value.path.split('/').last}'),
                      onTap: () {
                        controller.pickImage('A');
                      },
                    ),
                    FormVerticalSpace(),
                    FormInputField(
                      controller: controller.teamAnameController,
                      labelText: 'Team B',
                      validator: Validator().notEmpty,
                      onChanged: (value) => null,
                      onSaved: (value) =>
                          controller.teamAnameController.text = value!,
                    ),
                    FormVerticalSpace(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(controller.teamBimage.value),
                      ),
                      isThreeLine: true,
                      title: Text('Pick Image'),
                      subtitle: Text(
                          '${controller.teamAimage.value.path.split('/').last}'),
                      onTap: () {
                        controller.pickImage('B');
                      },
                    ),
                    FormVerticalSpace(),
                    Text(
                      'Match Day',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate.value,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 1026)),
                        );

                        if (picked != null &&
                            picked != controller.selectedDate.value) {
                          controller.selectedDate.value = picked;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: DateFormat.yMd()
                            .format(controller.selectedDate.value),
                      ),
                    ),
                    FormVerticalSpace(),
                    Text(
                      'Bet Expire Time',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: controller.selectedTime.value,
                        );

                        if (picked != null &&
                            picked != controller.selectedTime.value) {
                          controller.selectedTime.value = picked;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            '${controller.selectedTime.value.hour}:${controller.selectedTime.value.minute}',
                      ),
                    ),
                    FormVerticalSpace(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Add Match'),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}

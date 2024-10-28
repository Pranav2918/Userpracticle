import 'package:exubixpractical/src/constants/styles.dart';
import 'package:exubixpractical/src/data/user_model.dart';
import 'package:flutter/material.dart';

class UpdateButton extends StatelessWidget {
  final User user; 
  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController specialityController;
  final TextEditingController cityController;
  final TextEditingController mobileController;
  final TextEditingController remarksController;

  const UpdateButton({
    super.key,
    required this.user,
    required this.nameController,
    required this.categoryController,
    required this.specialityController,
    required this.cityController,
    required this.mobileController,
    required this.remarksController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Update user logic
        User updatedUser = User(
          varDrName: nameController.text,
          varCategory: categoryController.text,
          varSpeciality: specialityController.text,
          varCity: cityController.text,
          varMobileNo: mobileController.text,
          varAppRemarks: remarksController.text,
          varDrReqCode: user.varDrReqCode
        );

        // Return the updated user
        Navigator.of(context).pop(updatedUser);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        minimumSize: const Size(80.0, 40.0),
        backgroundColor: Colors.green,
      ),
      child: Text(
        "Update",
        style: detailStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
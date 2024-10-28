import 'package:exubixpractical/src/data/user_model.dart';
import 'package:exubixpractical/src/presentation/widgets/delete_button.dart';
import 'package:exubixpractical/src/presentation/widgets/update_button.dart';
import 'package:exubixpractical/src/presentation/widgets/user_field.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final User user;
  UserDetails({super.key, required this.user});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _nameController.text = user.varDrName;
    _categoryController.text = user.varCategory;
    _specialityController.text = user.varSpeciality;
    _cityController.text = user.varCity;
    _mobileController.text = user.varMobileNo ?? 'N/A';
    _remarksController.text = user.varAppRemarks;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 154, 196, 230),
        title: const Text("Employee Details"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            UserField(
              hintText: "Name",
              textEditingController: _nameController,
            ),
            UserField(
              hintText: "Category",
              textEditingController: _categoryController,
            ),
            UserField(
              hintText: "Speciality",
              textEditingController: _specialityController,
            ),
            UserField(
              hintText: "City",
              textEditingController: _cityController,
            ),
            UserField(
              hintText: "Mobile",
              textEditingController: _mobileController,
            ),
            UserField(
              hintText: "Remarks",
              textEditingController: _remarksController,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UpdateButton(
                      user: user,
                      nameController: _nameController,
                      categoryController: _categoryController,
                      specialityController: _specialityController,
                      cityController: _cityController,
                      mobileController: _mobileController,
                      remarksController: _remarksController),
                  const SizedBox(
                    width: 10.0,
                  ),
                  DeleteButton(
                    user: user,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:exubixpractical/src/constants/styles.dart';
import 'package:flutter/material.dart';

class UserField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  const UserField(
      {super.key, required this.hintText, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      height: 50.0,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10.0),
            hintText: hintText,
            hintStyle: hintStyle.copyWith(fontSize: 14.0)),
      ),
    );
  }
}

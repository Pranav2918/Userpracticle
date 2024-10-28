import 'package:exubixpractical/src/data/user_model.dart';
import 'package:flutter/material.dart';

import '../../constants/styles.dart';

class DeleteButton extends StatelessWidget {
  final User user;
  const DeleteButton({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Delete User"),
            content: const Text("Are you sure you want to delete this user?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(user);
                },
                child: const Text("Delete"),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          minimumSize: const Size(80.0, 40.0),
          backgroundColor: Colors.red),
      child: Text(
        "Delete",
        style: detailStyle.copyWith(color: Colors.white),
      ),
    );
  }
}

import 'package:exubixpractical/src/data/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> storeUsers(List<User> users) async {
    var box = Hive.box<User>('users');
    await box.clear(); // Clear existing data to avoid duplicates
    await box.addAll(users);
  }

  Future<List<User>> getUsersFromHive() async {
    var box = Hive.box<User>('users');
    return box.values.toList();
  }
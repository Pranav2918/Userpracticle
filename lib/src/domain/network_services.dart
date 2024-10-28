import 'dart:convert';

import 'package:exubixpractical/src/data/user_model.dart';
import 'package:exubixpractical/src/domain/db_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String _baseUrl =
      "https://services85.ecubix.com/ECPMobileWebService_Ver850/ecpMobileToWebSync.asmx/Get_DrAdditionRequestDetails";
  Future<List<User>> fetchUsers() async {
    debugPrint("Fetching Users");
    try {
      final response = await http.get(Uri.parse(_baseUrl).replace(
          queryParameters: {
            "fk_EmpGLCode": "729",
            "varClientName": "VCS_CQA"
          }));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<dynamic> dataList = data['Details'];
        List<User> users = dataList.map((json) => User.fromJson(json)).toList();
        storeUsers(users);
        return users;
      } else {
        throw Exception(
            'Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data. Status Code: $e');
    }
  }

  
}

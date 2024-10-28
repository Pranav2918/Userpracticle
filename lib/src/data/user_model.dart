import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String varDrName;

  @HiveField(1)
  String varCategory;

  @HiveField(2)
  String varSpeciality;

  @HiveField(3)
  String varCity;

  @HiveField(4)
  String varAppRemarks;

  @HiveField(5)
  String? varMobileNo;

  @HiveField(6)
  String? varDrReqCode;

  User(
      {required this.varDrName,
      required this.varCategory,
      required this.varSpeciality,
      required this.varCity,
      required this.varAppRemarks,
      required this.varMobileNo,
      required this.varDrReqCode});

  factory User.fromJson(Map<String, dynamic> json) => User(
      varDrName: json['varDrName'],
      varCategory: json['varCategory'],
      varSpeciality: json['varSpeciality'],
      varCity: json['varCity'],
      varAppRemarks: json['varAppRemarks'],
      varMobileNo: json['varMobileNo'],
      varDrReqCode: json['varDrReqCode']);
}

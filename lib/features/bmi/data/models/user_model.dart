import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserModel {
  final String weight;
  final String height;
  final String age;
  final String status;
  final num bmiResult;

  UserModel(
      {required this.status,
      required this.weight,
      required this.height,
      required this.age,
      required this.bmiResult});

  Map<String, dynamic> toJson() {
    Timestamp now = Timestamp.now();
    DateTime dateTime = now.toDate();
    return {
      'weight': weight,
      'height': height,
      'age': age,
      'bmi_status': status,
      'created_at': DateFormat('hh:mm a').format(DateTime.now()),
      'date': dateTime,
      'bmi_result': bmiResult
    };
  }
}

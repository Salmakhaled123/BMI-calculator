import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:bmicalculator/core/utils/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../data/models/user_model.dart';

part 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  BmiCubit(this.firebaseService) : super(BmiInitial());
  var bmiResult = 0;
  String bmiStatus = '';
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController newAgeController = TextEditingController();
  TextEditingController newWeightController = TextEditingController();
  TextEditingController newHeightController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final editEntryFormKey = GlobalKey<FormState>();

  FirebaseService firebaseService = FirebaseService();
  Future signInAnonymously() async {
    emit(SignInAnonymouslyLoading());
    try {
      await FirebaseService.signInAnonymously();
      emit(SignInAnonymouslySucceeded());
    } catch (e) {
      emit(SignInAnonymouslyFailed(
          errorMessage: 'Something Wrong please try again'));
    }
  }

  double calculateBmi({required String weight, required String height}) {
    int userWeight = int.parse(weight);
    num userHeight = num.parse(height);
    userHeight /= 100;
    var bmiResult = userWeight / pow(userHeight, 2);
    if (bmiResult < 18.5) {
      bmiStatus = 'UnderWeight';
    } else if (bmiResult >= 18.5 && bmiResult < 25) {
      bmiStatus = 'Normal';
    } else if (bmiResult >= 25 && bmiResult < 30) {
      bmiStatus = 'OverWeight';
    } else {
      bmiStatus = 'Obesity';
    }
    emit(CalculatedSuccessfully());
    return bmiResult;
  }

  addNewUser() async {
    try {
      await firebaseService.addUser(UserModel(
          status: bmiStatus,
          weight: weightController.text,
          height: heightController.text,
          age: ageController.text,
          bmiResult: calculateBmi(
              weight: weightController.text, height: heightController.text)));
      emit(AddNewUserSuccessfully());
      weightController.clear();
      heightController.clear();
      ageController.clear();
    } on Exception catch (e) {
      emit(AddNewUserFailed());
    }
  }

  List<QueryDocumentSnapshot> entries = [];
  getAllEntries() async {
    emit(GetAllEntriesLoading());
    entries = await firebaseService.getAllEntries();
    emit(GetAllEntriesSuccessfully());
  }

  void editEntry({required String uId}) async {
    var result = calculateBmi(
        weight: newWeightController.text, height: newHeightController.text);
    print(result);
    await firebaseService.editEntry(newWeightController.text,
        newHeightController.text, uId, bmiStatus, result);
    emit(EditEntrySuccessfully());
  }

  void deleteEntries() async {
    await firebaseService.deleteAllEntries();

    emit(DeleteEntriesSuccessfully());
  }

  Future<void> signOut() async {
    await firebaseService.signOut();
    emit(SignedOutSuccessfully());
  }
}

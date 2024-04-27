import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bmicalculator/core/utils/spacing.dart';
import 'package:bmicalculator/core/utils/widgets/custom_text_form_field.dart';
import 'package:bmicalculator/features/bmi/view_model/bmi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'entries_view.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent[100],
      appBar: AppBar(
          title: const Text(
        'Bmi Calculator',
      )),
      body: Form(
        key: BlocProvider.of<BmiCubit>(context).formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: BlocBuilder<BmiCubit, BmiState>(
            builder: (context, state) {
              var cubit = BlocProvider.of<BmiCubit>(context);
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                    verticalSpace(20),
                    CustomTextFormField(
                        hintText: 'enter your age',
                        controller: cubit.ageController,
                        type: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your age';
                          }
                          return null;
                        }),
                    verticalSpace(20),
                    CustomTextFormField(
                        suffixIcon: Container(
                            width: 40.w,
                            alignment: Alignment.center,
                            child: const Text(
                              'Kg',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        hintText: 'enter your weight',
                        controller: cubit.weightController,
                        type: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your weight';
                          }
                          return null;
                        }),
                    verticalSpace(20),
                    CustomTextFormField(
                        suffixIcon: Container(
                            width: 40.w,
                            alignment: Alignment.center,
                            child: const Text(
                              'cm',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        hintText: 'enter your height',
                        controller: cubit.heightController,
                        type: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your height';
                          }
                          return null;
                        }),
                    verticalSpace(20),
                    ElevatedButton(
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            var result = cubit.calculateBmi(
                              weight: cubit.weightController.text,
                              height: cubit.heightController.text,
                            );
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              btnOkColor: Colors.green,
                              title: 'Bmi Status :${cubit.bmiStatus}',
                              desc: 'Bmi = ${result.toStringAsPrecision(3)}',
                            ).show();
                            cubit.addNewUser();
                          }
                        },
                        child: const Text('calculate ')),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AllEntriesView()));
                        },
                        child: Text(
                          'See All Entries',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21.sp),
                        ))
                  ]);
            },
          ),
        ),
      ),
    );
  }
}

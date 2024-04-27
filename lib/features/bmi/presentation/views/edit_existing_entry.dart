import 'package:bmicalculator/core/utils/widgets/custom_text_form_field.dart';
import 'package:bmicalculator/features/bmi/view_model/bmi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/spacing.dart';

class EditEntryView extends StatelessWidget {
  final String uId;
  const EditEntryView({Key? key, required this.uId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent[100],
      appBar: AppBar(
          title: const Text(
        'Edit Entry',
      )),
      body: Form(
        key: BlocProvider.of<BmiCubit>(context).editEntryFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: BlocBuilder<BmiCubit, BmiState>(
            builder: (context, state) {
              var cubit = BlocProvider.of<BmiCubit>(context);
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        hintText: 'enter your new weight',
                        controller: cubit.newWeightController,
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
                        hintText: 'enter your new height',
                        controller: cubit.newHeightController,
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
                          if (cubit.editEntryFormKey.currentState!.validate()) {
                            cubit.editEntry(uId: uId);
                            cubit.newWeightController.clear();
                            cubit.newHeightController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('edit entry ')),
                  ]);
            },
          ),
        ),
      ),
    );
  }
}

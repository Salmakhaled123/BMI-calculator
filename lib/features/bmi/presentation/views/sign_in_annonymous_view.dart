import 'package:bmicalculator/features/bmi/view_model/bmi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calculator_view.dart';

class SignInAnonymousView extends StatelessWidget {
  const SignInAnonymousView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: BlocConsumer<BmiCubit, BmiState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<BmiCubit>(context);
            return ElevatedButton(
                onPressed: () async {
                  await cubit.signInAnonymously();
                },
                child: state is SignInAnonymouslyLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Go To Bmi Calculator',
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
          },
          listener: (context, state) {
            if (state is SignInAnonymouslyFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            } else if (state is SignInAnonymouslySucceeded) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CalculatorView();
              }));
            }
          },
        ),
      ),
    );
  }
}

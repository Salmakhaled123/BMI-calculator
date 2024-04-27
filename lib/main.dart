import 'package:bmicalculator/core/utils/firebase_service.dart';
import 'package:bmicalculator/core/utils/myBlocObserver.dart';
import 'package:bmicalculator/features/bmi/view_model/bmi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/bmi/presentation/views/sign_in_annonymous_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = const SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocProvider(
            create: (context) => BmiCubit(FirebaseService()),
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Bmi Calculator',
              home: SignInAnonymousView(),
            ),
          );
        });
  }
}

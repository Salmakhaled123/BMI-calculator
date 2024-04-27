import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bmicalculator/features/bmi/presentation/views/edit_existing_entry.dart';
import 'package:bmicalculator/features/bmi/view_model/bmi_cubit.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllEntriesView extends StatelessWidget {
  const AllEntriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    btnCancelColor: Colors.red,
                    btnOkColor: Colors.green,
                    btnCancelText: 'No',
                    btnOkText: 'yes',
                    btnCancelOnPress: () {},
                    title: 'Delete entries',
                    desc: 'Are you sure you want to delete?',
                    btnOkOnPress: () {
                      BlocProvider.of<BmiCubit>(context).deleteEntries();
                    },
                  ).show();
                },
                icon: const Icon(Icons.delete)),
            IconButton(
              onPressed: () {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        btnCancelColor: Colors.red,
                        btnOkColor: Colors.green,
                        btnCancelText: 'No',
                        btnOkText: 'yes',
                        title: 'logout ',
                        desc: 'Are you sure you want to logout?',
                        btnOkOnPress: () {
                          BlocProvider.of<BmiCubit>(context).signOut();
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        btnCancelOnPress: () {})
                    .show();
              },
              icon: const Icon(Icons.logout),
            )
          ],
          title: const Text('All Entries'),
        ),
        body: FirestorePagination(
            isLive: true,
            onEmpty: const Center(
                child: Text(
              'No entries found',
            )),
            physics: const BouncingScrollPhysics(),
            query: FirebaseFirestore.instance
                .collection('users')
                .orderBy('date', descending: true),
            itemBuilder: (context, documentSnapshot, index) {
              final data = documentSnapshot.data() as Map<String, dynamic>;
              final uId = documentSnapshot.id;
              return Card(
                color: Colors.purple[200],
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                elevation: 8,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditEntryView(
                                  uId: uId,
                                )));
                  },
                  leading: const Icon(Icons.person),
                  title: Text(
                    'weight:${data['weight']}kg',
                  ),
                  trailing: Text(
                    '${data['bmi_status']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 21.sp),
                  ),
                  subtitle:
                      Text('height:${data['height']}cm Age:${data['age']}'),
                ),
              );
            }));
  }
}

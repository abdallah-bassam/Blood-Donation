import 'package:alert_dialog/alert_dialog.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/lists_of_patients.dart';
import '../../shared/reusable_components.dart';

class Donate extends StatelessWidget {
  Donate({Key? key}) : super(key: key);
  List<String> bloodTypes = [
    'All',
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit, BloodDonationStates>(
      listener: (context, states) {},
      builder: (context, states) {
        BloodDonationCubit cubit = BlocProvider.of(context);
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          sharedText(
              text: "Save a life", fontSize: 20, color: Color(0xFFB6B6B6)),
          SizedBox(
            height: 3,
          ),
          sharedText(
              text: 'Here contains all the patients',
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          SizedBox(
            height: 20,
          ),
          sharedSearchBox(context: context),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 40,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => bloodTypesBoxForDonate(
                  bloodType: bloodTypes[index], context: context, index: index),
              separatorBuilder: (context, index) => SizedBox(
                width: 8,
              ),
              itemCount: bloodTypes.length,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: cubit.bloodTypeListForPatients==0?listOfAllPatients():cubit.bloodTypeListForPatients==1?listOfAPlusPatients():cubit.bloodTypeListForPatients==3?listOfBPlusPatients():Container(),
          ),
        ]);
      },
    );
  }
}

import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/lists_of_patients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/reusable_components.dart';

class HistoryOfDonations extends StatelessWidget {
  const HistoryOfDonations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit, BloodDonationStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sharedText(
                              text: 'History of donations',
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          sharedText(
                              text:
                                  'Contains all the patients are you need to donate for them',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFB6B6B6)),
                          SizedBox(height: 10,),
                          Expanded(
                              child: listOfHistoryOfDonations(context)
                          ),
                        ]))));
      },
    );
  }
}

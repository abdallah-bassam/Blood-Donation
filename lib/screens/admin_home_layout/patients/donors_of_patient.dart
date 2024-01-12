import 'package:flutter/material.dart';

import '../../../models/donor_model.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/reusable_components.dart';

class DonorsOfPatient extends StatelessWidget {
  const DonorsOfPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: sharedText(text: 'Donors of nameOfPatient', fontSize: 22,color: Colors.black),
        ),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: buildDonorsOfPatient(
                  context: context, donorModel: BloodDonationCubit.get(context).donorModels![0]),
            )));
  }
}

import 'package:blood_donation/models/donor_model.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/list_of_donors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/reusable_components.dart';

class Donors extends StatelessWidget {
  Donors({Key? key}) : super(key: key);

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
              text: 'Here contains all the donors',
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => bloodTypesBoxForDonors(
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
            child: cubit.bloodTypeListForDonors == 0
                ? listOfAllDonors(context)
                : cubit.bloodTypeListForDonors == 1
                    ? listOfAPlusDonors(context)
                    : cubit.bloodTypeListForDonors == 2
                        ? listOfAMinusDonors(context)
                        : cubit.bloodTypeListForDonors == 3
                            ? listOfBPlusDonors(context)
                            : cubit.bloodTypeListForDonors == 4
                                ? listOfBMinusDonors(context)
                                : cubit.bloodTypeListForDonors == 5
                                    ? listOfABPlusDonors(context)
                                    : cubit.bloodTypeListForDonors == 6
                                        ? listOfABMinusDonors(context)
                                        : cubit.bloodTypeListForDonors == 7
                                            ? listOfOPlusDonors(context)
                                            : cubit.bloodTypeListForDonors == 8
                                                ? listOfOMinusDonors(context)
                                                : Container(),
          ),
        ]);
      },
    );
  }
}

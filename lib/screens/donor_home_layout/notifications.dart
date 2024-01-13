import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/lists_of_patients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/reusable_components.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit,BloodDonationStates>(
      listener: (context,states){},
      builder: (context,states){
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sharedText(
                  text: 'Notifications',
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              sharedText(
                  text: "Emergency blood donation requests matching your blood type", fontSize: 20, color: Color(0xFFB6B6B6)),
              SizedBox(
                height: 15,
              ),
              Expanded(child: listOfPatientsForNotifications(context))
            ],
          ),
        );
      },
    );
  }
}

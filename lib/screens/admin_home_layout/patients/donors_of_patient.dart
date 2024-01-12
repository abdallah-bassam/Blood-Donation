import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/cubit/cubit.dart';
import '../../../shared/reusable_components.dart';

class DonorsOfPatient extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit,BloodDonationStates>(
      listener: (context,states){},
      builder: (context,states){
        BloodDonationCubit cubit = BlocProvider.of(context);
        return Scaffold(
            appBar: AppBar(
              title: sharedText(text: 'Donors of nameOfPatient', fontSize: 22,color: Colors.black),
            ),
            body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildDonorsOfPatient(context: context, donorModel: cubit.donorsForPatient![index]),
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemCount: cubit.donorsForPatient!.length,

                  ),

                )));
      },
    );
  }
}


// buildDonorsOfPatient(
// context: context, donorModel: BloodDonationCubit.get(context).donorModels![0]),
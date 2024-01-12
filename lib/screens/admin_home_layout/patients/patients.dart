import 'package:blood_donation/models/patient_model.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/lists_of_patients.dart';
import 'package:blood_donation/shared/reusable_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Patients extends StatelessWidget {
  Patients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit, BloodDonationStates>(
      listener: (context, states) {},
      builder: (context, states) {
        BloodDonationCubit cubit = BlocProvider.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sharedText(text: "All Patients with their donors", fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),
            sharedText(text: "Increase the donor's achievements from show donors", fontSize: 20,color: Color(0xFFB6B6B6)),
            SizedBox(height: 10,),
            sharedSearchBox(context: context),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildPatientItemForAdmin(
                    patientModel: cubit.patientModels![index], context: context),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: cubit.patientModels!.length,

              ),
            ),
          ],
        );
      },
    );
  }
}

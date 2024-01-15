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
            SizedBox(height: 20,),
            sharedSearchBox(context: context),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    cubit.deleteOldPatients();
                    AlertDialog(
                      title: null,
                      content: sharedText(
                          text: 'Deleted Successfully',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: Colors.red),
                    child: sharedText(text: 'Delete old patients', fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: cubit.searchedPatientNotFound?Center(child: sharedText(text: 'Not Found', fontSize: 30,fontWeight: FontWeight.bold)):
              ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildPatientItemForAdmin(
                    patientModel: cubit.searchedPatientModels!.isEmpty?cubit.patientModels![index]:cubit.searchedPatientModels![index], context: context),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: cubit.searchedPatientModels!.isEmpty?cubit.patientModels!.length:cubit.searchedPatientModels!.length,

              ),
            ),
          ],
        );
      },
    );
  }
}

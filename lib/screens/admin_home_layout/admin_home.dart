import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/reusable_components.dart';
import '../starting_app/login.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit,BloodDonationStates>(
      listener: (context,states){},
      builder: (context,states){
        BloodDonationCubit cubit = BlocProvider.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sharedText(text: "Hello, Blood Bank", fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),
            SizedBox(height: 3,),
            SizedBox(height: 25,),
            Expanded(
              child: Column(
                children: [
                  sharedMaterialButtonApp(onPressed: (){
                    cubit.changeAdminHomeScreens(1);
                    cubit.changeIndexOfBottomNavBarAdmin(1);
                  }, text: 'Add Patients', context: context,icon: Icons.add),
                  SizedBox(height: 25,),
                  sharedMaterialButtonApp(onPressed: (){
                    cubit.changeAdminHomeScreens(2);
                    cubit.changeIndexOfBottomNavBarAdmin(2);
                    cubit.getAllPatients();
                    //cubit.deleteOldPatients();
                  }, text: 'Patients and their donors', context: context,icon: Icons.list),
                  SizedBox(height: 25,),
                  sharedMaterialButtonApp(onPressed: (){
                    cubit.changeAdminHomeScreens(3);
                    cubit.changeIndexOfBottomNavBarAdmin(3);
                    cubit.getAllDonors();
                  }, text: 'Donors', context: context,icon: Icons.bloodtype_rounded),
                  SizedBox(height: 25,),
                  sharedMaterialButtonApp(onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login()),
                    );
                    cubit.firstNameController.text = '';
                    cubit.lastNameController.text = '';
                    cubit.ageController.text = '';
                    cubit.phoneNumberController.text = '';
                    cubit.genderController.text = '';
                    cubit.emailController.text = '';
                    cubit.passwordController.text = '';
                    cubit.confirmPasswordController.text = '';
                  }, text: 'Logout', context: context,icon: Icons.logout),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:blood_donation/screens/admin_home_layout/add_patients.dart';
import 'package:blood_donation/screens/admin_home_layout/admin_home.dart';
import 'package:blood_donation/screens/admin_home_layout/donors.dart';
import 'package:blood_donation/screens/admin_home_layout/patients/patients.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeLayout extends StatelessWidget {
  AdminHomeLayout({Key? key}) : super(key: key);

  List <Widget> screens = [
    AdminHome(),
    AddPatients(),
    Patients(),
    Donors()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit,BloodDonationStates>(
      listener: (context,states){},
      builder: (context,states){
        BloodDonationCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: screens[cubit.adminScreen],
            ),
          ),
          bottomNavigationBar: Container(
            height: 85,
            child: BottomNavigationBar(
              iconSize: 35,
              currentIndex: cubit.currentIndexAdmin,
              onTap: (index){
                cubit.changeIndexOfBottomNavBarAdmin(index);
              },
              items: [
                BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.home),onPressed: (){
                  cubit.changeAdminHomeScreens(0);
                  cubit.changeIndexOfBottomNavBarAdmin(0);
                },),label: 'Home'),
                BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.add),onPressed: (){
                  cubit.changeAdminHomeScreens(1);
                  cubit.changeIndexOfBottomNavBarAdmin(1);
                },),label: 'Add patients'),
                BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.list),onPressed: (){
                  cubit.changeAdminHomeScreens(2);
                  cubit.changeIndexOfBottomNavBarAdmin(2);
                  cubit.getAllPatients();
                  cubit.deleteOldPatients();
                },),label: 'Patients'),
                BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.bloodtype_rounded),onPressed: (){
                  cubit.changeAdminHomeScreens(3);
                  cubit.changeIndexOfBottomNavBarAdmin(3);
                  cubit.getAllDonors();
                },),label: 'Donors'),
              ],
            ),
          ),
        );
      },
    );
  }
}

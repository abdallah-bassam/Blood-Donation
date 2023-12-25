import 'package:blood_donation/screens/donor_home_layout/donor_home.dart';
import 'package:blood_donation/screens/donor_home_layout/hospitals.dart';
import 'package:blood_donation/screens/donor_home_layout/notifications.dart';
import 'package:blood_donation/screens/donor_home_layout/profile/profile.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'donate.dart';



class DonorHomeLayout extends StatelessWidget {
  DonorHomeLayout({Key? key}) : super(key: key);

  List <Widget> screens = [
    DonorHome(),
    Donate(),
    Hospitals(),
    Notifications(),
    Profile(),
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
              child: screens[cubit.screen],
            ),
          ),
          bottomNavigationBar: Container(
            height: 85,
            child: BottomNavigationBar(
              iconSize: 35,
              currentIndex: cubit.currentIndexDonor,
              onTap: (index){
                print(index);
                cubit.changeIndexOfBottomNavBarDonor(index);
              },
              items: [
                BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.home),onPressed: (){
                  cubit.changeDonorHomeScreens(0);
                  cubit.changeIndexOfBottomNavBarDonor(0);
                },),label: 'Home'),
                // BottomNavigationBarItem(icon: Icon(Icons.bloodtype),label: 'Donate'),
                // BottomNavigationBarItem(icon: Icon(Icons.local_hospital),label: 'Hospital'),
                BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.notifications),onPressed: (){
                  cubit.changeDonorHomeScreens(3);
                  cubit.changeIndexOfBottomNavBarDonor(1);
                },),label: 'Notifications'),
                BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.person_rounded),onPressed: (){
                  cubit.changeDonorHomeScreens(4);
                  cubit.changeIndexOfBottomNavBarDonor(2);
                },),label: 'Profile'),
              ],
            ),
          ),
        );
      },

    );
  }

}

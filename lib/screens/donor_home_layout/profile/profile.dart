import 'package:blood_donation/screens/donor_home_layout/profile/edit_profile.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/reusable_components.dart';
import 'history_of_donations.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit,BloodDonationStates>(
      listener: (context,states){},
      builder: (context,states){
        BloodDonationCubit cubit = BlocProvider.of(context);
        return Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 45,
                    ),
                    sharedText(text: 'A', fontSize: 60,color: Colors.white)
                  ],
                ),
                SizedBox(height: 8,),
                sharedText(text: 'Ahmad Mohammad', fontSize: 20,fontWeight: FontWeight.bold),
                sharedText(text: 'ahmad_mohammad@gmail.com', fontSize: 18,color: Colors.grey),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.17,
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sharedText(text: 'O+', fontSize: 20),
                          SizedBox(height: 5,),
                          sharedText(text: 'Blood Type', fontSize: 20),
                        ],
                      ),
                    ),
                    SizedBox(width: 40,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.17,
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          sharedText(text: '3', fontSize: 20),
                          SizedBox(height: 5,),
                          sharedText(text: 'Donations', fontSize: 20),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                sharedMaterialButtonApp(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile()),
                  );
                }, text: 'Edit Profile', context: context,icon: Icons.edit_outlined,width: 300),
                SizedBox(height: 30,),
                sharedMaterialButtonApp(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HistoryOfDonations()),
                  );
                }, text: 'History of donations', context: context,icon: Icons.history,width: 300),
                SizedBox(height: 30,),
                sharedMaterialButtonApp(onPressed: (){}, text: 'Logout', context: context,icon: Icons.logout,width: 300),
              ],
            ),
          ),
        );
      },
    );
  }
}

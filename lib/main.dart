import 'package:blood_donation/screens/admin_home_layout/admin_home_layout.dart';
import 'package:blood_donation/screens/donor_home_layout/donor_home_layout.dart';
import 'package:blood_donation/screens/donor_home_layout/profile/edit_profile.dart';
import 'package:blood_donation/screens/login.dart';
import 'package:blood_donation/screens/on_boarding.dart';
import 'package:blood_donation/screens/sign_up.dart';
import 'package:blood_donation/shared/cubit/bloc_observer.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_core/firebase_core.dart';

void main(){
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  // await Firebase.initializeApp();
  runApp(const BloodDonation());
}

class BloodDonation extends StatelessWidget {
  const BloodDonation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>BloodDonationCubit(),
      child: BlocConsumer<BloodDonationCubit,BloodDonationStates>(
        listener: (context,states){},
        builder: (context,states){
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.red,
              appBarTheme:  const AppBarTheme(
                  backgroundColor: Colors.white,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Manrope',
                      color: Colors.red,
                  ),
                  iconTheme: IconThemeData(color: Colors.black, size: 35),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.red,
                backgroundColor: Colors.white,
                elevation: 20,
              ),
            ),
            home: SignUp(),
            debugShowCheckedModeBanner: false,
            //title: 'Flutter Demo',
          );
        },
      ),
    );
  }
}


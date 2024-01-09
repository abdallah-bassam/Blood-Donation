import 'package:blood_donation/screens/admin_home_layout/admin_home_layout.dart';
import 'package:blood_donation/screens/donor_home_layout/donor_home_layout.dart';
import 'package:blood_donation/screens/donor_home_layout/profile/edit_profile.dart';
import 'package:blood_donation/screens/donor_home_layout/profile/history_of_donations.dart';
import 'package:blood_donation/screens/starting_app/forget_password.dart';
import 'package:blood_donation/screens/starting_app/login.dart';
import 'package:blood_donation/screens/starting_app/on_boarding.dart';
import 'package:blood_donation/screens/starting_app/splash_screen.dart';
import 'package:blood_donation/shared/cubit/bloc_observer.dart';
import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:blood_donation/shared/network/remote/dio_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
}

Future main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();


  try {
    await Firebase.initializeApp();
    var token = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Handle the error gracefully, such as displaying an error message or taking necessary actions.
  }
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
                selectedItemColor: Colors.redAccent,
                backgroundColor: Colors.white,
                elevation: 20,
              ),
            ),
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
            //title: 'Flutter Demo',
          );
        },
      ),
    );
  }
}


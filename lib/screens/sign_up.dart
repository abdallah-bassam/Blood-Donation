import 'package:blood_donation/screens/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/reusable_components.dart';
import 'donor_home_layout/profile/edit_profile.dart';


class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp phoneRegex = RegExp(r'^\d{10}$');
  RegExp ageRegex = RegExp(r'^\d{1,3}$');

  List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit, BloodDonationStates>(
      listener: (context, states) {},
      builder: (context, states) {
        BloodDonationCubit cubit = BloodDonationCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(right: 30, left: 30, bottom: 30),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sharedText(
                                text: 'Create an account',
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            sharedText(
                                text:
                                    'Welcome enter your details lets get started',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB6B6B6)),
                            SizedBox(
                              height: 60,
                            ),
                            sharedTextFormField(
                                controller: cubit.firstNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid name';
                                  }
                                  if (!nameRegex.hasMatch(value)) {
                                    return 'Please enter a valid name';
                                  }
                                  return null;
                                },
                                label: 'First name',
                                suffix: Icons.text_fields_sharp,
                                isPassword: false),
                            SizedBox(
                              height: 15,
                            ),
                            sharedTextFormField(
                                controller: cubit.lastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid name';
                                  }
                                  if (!nameRegex.hasMatch(value)) {
                                    return 'Please enter a valid name';
                                  }
                                  return null;
                                },
                                label: 'Last name',
                                suffix: Icons.text_fields_sharp,
                                isPassword: false),
                            SizedBox(
                              height: 15,
                            ),
                            sharedTextFormField(
                                controller: cubit.emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email address';
                                  }
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                label: 'Email Address',
                                suffix: Icons.person,
                                isPassword: false),
                            SizedBox(
                              height: 15,
                            ),
                            sharedTextFormField(
                                controller: cubit.passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an password';
                                  }
                                  if (!passwordRegex.hasMatch(value)) {
                                    return 'Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character';
                                  }
                                  return null;
                                },
                                label: 'Password',
                                suffix: cubit.suffixPassword,
                                isPassword: cubit.isPassword,
                                onPressedSuffix: () {
                                  cubit.changePasswordIcon();
                                  cubit.changeIsPassword();
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            sharedTextFormField(
                                controller: cubit.confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an password';
                                  }
                                  if (cubit.confirmPasswordController.text!=cubit.passwordController.text) {
                                    return 'Confirm Password must be same Password';
                                  }
                                  return null;
                                },
                                label: 'Confirm Password',
                                suffix: cubit.suffixConfirmPassword,
                                isPassword: cubit.isConfirmPassword,
                                onPressedSuffix: () {
                                  cubit.changeConfirmPasswordIcon();
                                  cubit.changeIsConfirmPassword();
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            sharedTextFormField(
                                controller: cubit.phoneNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an phone number';
                                  }
                                  if (!phoneRegex.hasMatch(value)) {
                                    return 'Invalid phone number format';
                                  }
                                  return null;
                                },
                                label: 'Phone number',
                                suffix: null,
                                isPassword: false,
                                width: 150,
                                textInputType: TextInputType.phone),
                            SizedBox(
                              height: 15,
                            ),
                            sharedTextFormField(
                                controller: cubit.ageController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  if (!ageRegex.hasMatch(value)) {
                                    return 'Invalid age format';
                                  }
                                  return null;
                                },
                                label: 'Age',
                                suffix: null,
                                isPassword: false,
                                width: 70,
                                textInputType: TextInputType.number),
                            SizedBox(
                              height: 15,
                            ),
                            sharedText(text: 'Gender', fontSize: 20,fontWeight: FontWeight.bold),
                            RadioListTile<Gender>(
                              title: sharedText(text: 'Male',fontSize: 18),
                              value: Gender.male,
                              groupValue: cubit.selectedGender,
                              onChanged: (value) {
                                cubit.changeSelectedGender(value);
                              },
                            ),
                            RadioListTile<Gender>(
                              title: sharedText(text: 'Female',fontSize: 18),
                              value: Gender.female,
                              groupValue: cubit.selectedGender,
                              onChanged: (value) {
                                cubit.changeSelectedGender(value);
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            sharedText(text: 'Blood type', fontSize: 20,fontWeight: FontWeight.bold),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => bloodTypesBoxForSignUp(
                                    bloodType: bloodTypes[index], context: context, index: index),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 8,
                                ),
                                itemCount: bloodTypes.length,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        sharedMaterialButtonAccount(
                            onPressed: () async {
                              if (formKey.currentState!.validate()&&cubit.selectedGender!=null&&cubit.selectedIndexSignUp!=-1) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: null,
                                      content: sharedText(text: 'Sign Up Successfully',fontSize: 22,fontWeight: FontWeight.bold),
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
                                );
                                switch(bloodTypes[cubit.selectedIndexSignUp])
                                {
                                  case 'A+':
                                    {
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('AMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OMinus');

                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('APlus');
                                    }break;
                                  case 'A-':
                                    {
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('APlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OMinus');

                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('AMinus');
                                    }break;
                                  case 'B+':
                                    {
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('APlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('AMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OMinus');

                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('BPlus');
                                    }
                                    break;
                                  case 'B-':
                                    {
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('APlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('AMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OMinus');

                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('BMinus');
                                    }
                                    break;
                                  case 'O+':
                                    {
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('APlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('AMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OMinus');

                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('OPlus');
                                    }
                                    break;
                                  case 'O-':
                                    {
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('APlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('AMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BPlus');

                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('OMinus');
                                    }
                                    break;
                                  case 'AB+':
                                    {
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('APlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('AMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OMinus');

                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('ABPlus');
                                    }
                                    break;
                                  case 'AB-':
                                    {
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('APlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('AMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BMinus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('ABPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('BPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OPlus');
                                      await FirebaseMessaging.instance
                                          .unsubscribeFromTopic('OMinus');

                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('ABMinus');
                                    }
                                    break;
                                }
                                formKey.currentState!.save();
                              }
                            },
                            text: "Si..gn Up"),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sharedText(
                                text: "Already have an account?", fontSize: 18),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                child: sharedText(text: 'Login', fontSize: 18))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

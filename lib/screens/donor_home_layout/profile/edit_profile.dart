import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/reusable_components.dart';
import '../../starting_app/login.dart';
import '../donor_home.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp passwordRegex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp phoneRegex = RegExp(r'^\d{10}$');
  RegExp ageRegex = RegExp(r'^\d{1,3}$');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BloodDonationCubit, BloodDonationStates>(
      listener: (context, states) {},
      builder: (context, states) {
        BloodDonationCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(30.0),
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
                                text: 'Edit Profile',
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            sharedText(
                                text:
                                    'If you need to edit any information of profile',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB6B6B6)),
                            SizedBox(
                              height: 60,
                            ),
                            sharedText(text: 'First name', fontSize: 18),
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
                                suffix: Icons.text_fields_sharp,
                                isPassword: false),
                            SizedBox(
                              height: 15,
                            ),
                            sharedText(text: 'Last name', fontSize: 18),
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
                                suffix: Icons.text_fields_sharp,
                                isPassword: false),
                            SizedBox(
                              height: 15,
                            ),
                            sharedText(text: 'Email Address', fontSize: 18),
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
                                suffix: Icons.person,
                                isPassword: false),
                            SizedBox(
                              height: 15,
                            ),
                            sharedText(text: 'Password', fontSize: 18),
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
                                suffix: cubit.suffixPassword,
                                isPassword: cubit.isPassword,
                                onPressedSuffix: () {
                                  cubit.changePasswordIcon();
                                  cubit.changeIsPassword();
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            sharedText(text: 'Confirm Password', fontSize: 18),
                            sharedTextFormField(
                                controller: cubit.confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an password';
                                  }
                                  if (cubit.confirmPasswordController.text !=
                                      cubit.passwordController.text) {
                                    return 'Confirm Password must be same Password';
                                  }
                                  return null;
                                },
                                suffix: cubit.suffixConfirmPassword,
                                isPassword: cubit.isConfirmPassword,
                                onPressedSuffix: () {
                                  cubit.changeConfirmPasswordIcon();
                                  cubit.changeIsConfirmPassword();
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            sharedText(text: 'Phone number', fontSize: 18),
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
                                suffix: null,
                                isPassword: false,
                                width: 150,
                                textInputType: TextInputType.phone),
                            SizedBox(
                              height: 15,
                            ),
                            sharedText(text: 'Age', fontSize: 18),
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
                                suffix: null,
                                isPassword: false,
                                width: 70,
                                textInputType: TextInputType.number),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        sharedMaterialButtonAccount(
                            onPressed: () {
                              if (formKey.currentState!.validate()){
                                cubit.donorEditProfile(
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text,
                                    firstName: cubit.firstNameController.text,
                                    lastName: cubit.lastNameController.text,
                                    phoneNumber: int.tryParse(
                                        cubit.phoneNumberController.text) ??
                                        0,
                                    age:
                                    int.tryParse(cubit.ageController.text) ?? 0,
                                    gender: cubit.selectedGender == Gender.female
                                        ? 'female'
                                        : 'male',
                                    bloodType: userDonor['blood_Type'],
                                    donor_id: userDonor['donor_id']
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: null,
                                      content: sharedText(
                                          text: 'Profile updated',
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
                                );
                              }
                            },
                            text: "Update"),
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

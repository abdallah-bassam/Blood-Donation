import 'package:blood_donation/shared/cubit/cubit.dart';
import 'package:blood_donation/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/reusable_components.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

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
                              validator: (value) {},
                              label: 'First name',
                              suffix: Icons.text_fields_sharp,
                              isPassword: false),
                          SizedBox(
                            height: 15,
                          ),
                          sharedText(text: 'Last name', fontSize: 18),
                          sharedTextFormField(
                              controller: cubit.lastNameController,
                              validator: (value) {},
                              label: 'Last name',
                              suffix: Icons.text_fields_sharp,
                              isPassword: false),
                          SizedBox(
                            height: 15,
                          ),
                          sharedText(text: 'Email Address', fontSize: 18),
                          sharedTextFormField(
                              controller: cubit.emailController,
                              validator: (value) {},
                              label: 'Email Address',
                              suffix: Icons.person,
                              isPassword: false),
                          SizedBox(
                            height: 15,
                          ),
                          sharedText(text: 'Password', fontSize: 18),
                          sharedTextFormField(
                              controller: cubit.passwordController,
                              validator: (value) {},
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
                          sharedText(text: 'Confirm Password', fontSize: 18),
                          sharedTextFormField(
                              controller: cubit.confirmPasswordController,
                              validator: (value) {},
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
                          sharedText(text: 'Age', fontSize: 18),
                          sharedTextFormField(
                              controller: cubit.ageController,
                              validator: (value) {},
                              label: 'Age',
                              suffix: null,
                              isPassword: false,
                              width: 70,
                              textInputType: TextInputType.number),
                          SizedBox(
                            height: 15,
                          ),
                          sharedText(text: 'Gender', fontSize: 18),
                          RadioListTile<Gender>(
                            title: const Text('Male'),
                            value: Gender.male,
                            groupValue: cubit.selectedGender,
                            onChanged: (value) {
                              cubit.changeSelectedGender(value);
                            },
                          ),
                          RadioListTile<Gender>(
                            title: const Text('Female'),
                            value: Gender.female,
                            groupValue: cubit.selectedGender,
                            onChanged: (value) {
                              cubit.changeSelectedGender(value);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      sharedMaterialButtonAccount(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: null,
                                  content: sharedText(text: 'Profile updated',fontSize: 22,fontWeight: FontWeight.bold),
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
                          }, text: "Update"),
                    ],
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

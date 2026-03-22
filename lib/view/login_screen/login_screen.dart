import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/signup_screen/signup_screen.dart';
import 'package:gofriendsgo/view_model/user_details.dart';
import 'package:gofriendsgo/widgets/login_widget/login_text.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/internet_broadcaster.dart';

TextEditingController emailController = TextEditingController();

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return InternetBroadcaster(child: Scaffold(
      body: Consumer<UserViewModel>(
        builder: (context, userViewModel, child) {
          return Stack(
            children: [
              Padding(
                padding: commonScreenPadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSizedBoxHeight(0.1),
                          const AppdecorText(
                            text: 'Login',
                            size: 0.08,
                            color: Colors.black,
                            weight: FontWeight.bold,
                          ),
                          const CustomSizedBoxHeight(0.05),
                          const CustomText(
                            fontFamily: CustomFonts.poppins,
                            text: TextStrings.loginMainText,
                            size: 0.04,
                            color: Colors.black,
                          ),
                          const CustomSizedBoxHeight(0.04),
                          const CustomText(
                            fontFamily: CustomFonts.poppins,
                            text: 'Email Address',
                            size: 0.04,
                            color: Colors.black,
                          ),
                          const CustomSizedBoxHeight(0.010),
                          // Updated TextField with icon and divider
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 24,
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      hintText: 'abc@gmail.com',
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email is required';
                                      }
                                      final emailRegExp = RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                      );
                                      if (!emailRegExp.hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    onFieldSubmitted: (value) {
                                      if (loginFormKey.currentState!
                                          .validate()) {
                                        userViewModel
                                            .loginUser(emailController.text);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        LoginText(
                          onTapSignUp: () {
                            PageNavigations().push(const SignUpScreen());
                          },
                        ),
                        const CustomSizedBoxHeight(0.02),
                        CustomButton(
                          fontFamily: CustomFonts.poppins,
                          function: () {
                            if (loginFormKey.currentState!.validate()) {
                              userViewModel.loginUser(emailController.text);
                            }
                          },
                          text: 'Get OTP',
                          fontSize: 0.04,
                          buttonTextColor: Colors.white,
                          borderColor: Colors.transparent,
                        ),
                        const CustomSizedBoxHeight(0.04),
                      ],
                    ),
                  ],
                ),
              ),
              if (userViewModel.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    ));
  }
}

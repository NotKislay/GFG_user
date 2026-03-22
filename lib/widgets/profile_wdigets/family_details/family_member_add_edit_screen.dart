import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofriendsgo/model/family_model/family_member.dart';
import 'package:gofriendsgo/view_model/family_viewmodel.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/family_details/family_widgets/relation_drop_down.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/family_details/form_type.dart';
import 'package:provider/provider.dart';

import '../../../model/user_model/user_details_model.dart';
import '../../../utils/color_theme/colors.dart';
import '../../../utils/constants/app_button.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_textfields.dart';
import '../../../utils/constants/custom_text.dart';
import '../../../utils/constants/paths.dart';
import '../../../utils/constants/screen_padding.dart';
import '../../../utils/constants/sizedbox.dart';
import '../../../utils/navigations/navigations.dart';
import '../../../view/login_screen/login_screen.dart';
import '../../../view/otp_verify_screen/otp_screen.dart';
import '../../../view_model/user_details.dart';
import '../../signup_widget/drop_down.dart';
import '../../signup_widget/sign_text.dart';
import '../date_of_birth.dart';
import 'family_widgets/family_dob.dart';

class FamilyMemberAddEditScreen extends StatefulWidget {
  final FormType formType;
  final FamilyMember? memberData;

  const FamilyMemberAddEditScreen(
      {super.key, required this.formType, this.memberData});

  @override
  State<FamilyMemberAddEditScreen> createState() =>
      _FamilyMemberAddEditScreenState();
}

class _FamilyMemberAddEditScreenState extends State<FamilyMemberAddEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final GlobalKey<FormState> _familyMemberFormKey = GlobalKey<FormState>();
  late FamilyViewModel _familyViewModel;
  Function(String)? onSuccessReceived;
  Function(String)? onErrorReceived;
  bool isSubmit = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _familyViewModel = Provider.of<FamilyViewModel>(context, listen: false);
      if (widget.memberData != null) {
        setValues(widget.memberData!);
      }
      if(widget.memberData== null){
        _familyViewModel.relationController = '';
      }
      _familyViewModel.onErrorCallback = _showErrorSnackBar;
      _familyViewModel.onSuccessCallback = _showSuccessSnackBar;
    });
    super.initState();
  }

  void _showSuccessSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 10,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7))),
        backgroundColor: AppColors.gradientColors[0].withOpacity(0.4),
        content: Text(
          message,
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        duration: Duration(milliseconds: 1500),
      ));
      Navigator.pop(context);
    } else {
      return;
    }
  }

  void _showErrorSnackBar(String error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 10,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7))),
        backgroundColor: AppColors.gradientColors[0].withOpacity(0.5),
        content: Text(error, style: TextStyle(fontSize: 17, color: Colors.red)),
        duration: Duration(milliseconds: 1500),
      ));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded)),
        title: CustomText(
            weight: FontWeight.bold,
            text: TextStrings.familyMembersDetails,
            fontFamily: CustomFonts.roboto,
            size: 0.055,
            color: AppColors.blackColor),
      ),
      body: Padding(
        padding: commonScreenPadding(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Form(
                key: _familyMemberFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomSizedBoxHeight(0.05),
                    _buildCustomTextField(
                      label: 'Name',
                      controller: _nameController,
                      hintText: 'Enter Name',
                      icon: Icons.account_circle_outlined,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBoxHeight(0.02),
                    const Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomText(
                        fontFamily: CustomFonts.poppins,
                        text: 'Date of Birth',
                        size: 0.04,
                        color: AppColors.blackColor,
                      ),
                    ),
                    Column(
                      children: [
                        FamilyDobContainer(
                          date: widget.memberData?.dob,
                          onDateChanged: (newDate) {
                            if (newDate != null) {
                              _dobController.text = newDate;
                            }
                          },
                        ),
                        if (isSubmit && _dobController.text.isEmpty)
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "This field is required",
                                style: TextStyle(color: Colors.red[800]),
                              )),
                      ],
                    ),
                    const CustomSizedBoxHeight(0.02),
                    _buildCustomTextField(
                      label: 'Mobile Number',
                      controller: _mobileController,
                      hintText: 'Enter your Mobile Number',
                      icon: Icons.call,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Phone Number is required';
                        }
                        final mobileRegex = RegExp(
                          r'^[6-9]\d{9}$',
                        );
                        if (!mobileRegex.hasMatch(value!)) {
                          return 'Please enter a valid mobile number';
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBoxHeight(0.02),
                    // Referral Code Field with Icon and Divider
                    _buildCustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: 'Enter the Email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Email is required';
                        }
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegex.hasMatch(value!)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBoxHeight(0.02),
                    Column(
                      children: [
                        StaticRelationDropDown(
                          selectedOption: widget.memberData?.relation,
                        ),
                        if (isSubmit &&
                            _familyViewModel.relationController.isEmpty)
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "This field is required",
                                style: TextStyle(color: Colors.red[800]),
                              )),
                      ],
                    ),
                    const CustomSizedBoxHeight(0.02),
                  ],
                ),
              ),
              //const CustomSizedBoxHeight(0.09),
              Column(
                children: [
                  const CustomSizedBoxHeight(0.10),
                  CustomButton(
                    function: () async {
                      log("CHECK this : ${isSubmit} and ${_familyViewModel.relationController}");

                      setState(() {
                        isSubmit = true;
                      });
                      if (_familyMemberFormKey.currentState!.validate()) {
                        bool isSuccess = true;
                        widget.formType == FormType.createForm
                            ? await _familyViewModel.addFamilyMember(
                                name: _nameController.text,
                                dob: _dobController.text,
                                mobile: _mobileController.text,
                                email: _emailController.text,
                              )
                            : await _familyViewModel.updateFamilyMember(
                                name: _nameController.text,
                                dob: _dobController.text,
                                mobile: _mobileController.text,
                                email: _emailController.text,
                                id: widget.memberData!.id!);
                      }
                    },
                    text:
                        widget.formType == FormType.createForm ? 'Add' : 'Save',
                    fontSize: 0.04,
                    buttonTextColor: AppColors.whiteColor,
                    borderColor: Colors.transparent,
                    fontFamily: CustomFonts.poppins,
                  ),
                  const CustomSizedBoxHeight(0.05),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  setValues(FamilyMember memberData) {
    _dobController.text = memberData.dob ?? '';
    _familyViewModel.relationController = memberData.relation!;

    _nameController.text = memberData.name!;
    log("DDATE SET: ${_dobController.text}");
    _mobileController.text = memberData.mobile!;
    _emailController.text = memberData.email!;
    _relationController.text = memberData.relation!;
    log("RELATION SET: ${_relationController.text}");
  }

  Widget _buildCustomTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatter,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          fontFamily: CustomFonts.poppins,
          text: label,
          size: 0.04,
          color: Colors.black,
        ),
        const CustomSizedBoxHeight(0.01),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 24,
                width: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatter,
                  validator: validator,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

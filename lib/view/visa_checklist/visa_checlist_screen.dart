import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/view_model/visa_viewmodel.dart';
import 'package:gofriendsgo/widgets/visa_checklist_widgets/list_items.dart';
import 'package:provider/provider.dart';

class VisaChecklistScreen extends StatefulWidget {
  const VisaChecklistScreen({super.key});

  @override
  State<VisaChecklistScreen> createState() => _VisaChecklistScreenState();
}

class _VisaChecklistScreenState extends State<VisaChecklistScreen> {
  @override
  void initState() {
    context.read<VisaViewModel>().fetchVisas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CommonGradientAppBar(
        heading: TextStrings.visaChecklist,
        fromBottomNav: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(mediaquerywidth(0.065, context)),
        child: const PackagesListView(),
      ),
    );
  }
}

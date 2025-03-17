import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gofriendsgo/utils/constants/message_search_bar.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view_model/chats/create_chat_viewmodel.dart';

import '../../services/api/app_apis.dart';
import '../color_theme/colors.dart';
import '../navigations/navigations.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Icon leading;
  final String image;
  final CreateChatViewModel chatVM;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const CustomAppBar(
      {super.key,
      required this.title,
      required this.leading,
      required this.image,
      required this.onMoveUp,
      required this.onMoveDown,
      required this.chatVM});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final double barHeight = 50.0;
  ValueNotifier<bool> isSearchClicked = ValueNotifier(false);
  ValueNotifier<bool> showMessageField = ValueNotifier(true);

  static GlobalKey<FormState> searchKey = GlobalKey<FormState>();
  late FocusNode searchFocusNode;

  @override
  void initState() {
    searchFocusNode = FocusNode();
    isSearchClicked.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leadingWidth: 30,
        leading: ValueListenableBuilder(
            valueListenable: isSearchClicked,
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  if (value) {
                    isSearchClicked.value = !isSearchClicked.value;
                    widget.chatVM.searchController.clear();
                    widget.chatVM.updateSearch(false);
                    showMessageField.value = true;
                  } else {
                    PageNavigations().pop();
                  }
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              );
            }),
        title: ValueListenableBuilder(
            valueListenable: isSearchClicked,
            builder: (context, value, child) {
              return value
                  ? MessageSearchBar(
                      isSearchClicked: isSearchClicked,
                      focusNode: searchFocusNode,
                      chatVM: widget.chatVM,
                      title: widget.title,
                      onMoveUp: widget.onMoveUp,
                      onMoveDown: widget.onMoveDown,
                    )
                  : Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                          ),
                          child: ClipOval(
                            child: widget.image == null
                                ? Image.asset(AppImages.goFriendsGoLogoMini)
                                : widget.image.toLowerCase().endsWith('.svg')
                                    ? SvgPicture.network(
                                        height: 40,
                                        width: 40,
                                        APIConstants.baseImageUrl +
                                            widget.image,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        height: 40,
                                        width: 40,
                                        APIConstants.baseImageUrl +
                                            widget.image,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.error,
                                            size: 30,
                                          );
                                        },
                                      ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
            }),
        flexibleSpace: Container(
            decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: AppColors.gradientColors,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft),
        )),
        actions: [
          ValueListenableBuilder(
              valueListenable: isSearchClicked,
              builder: (context, value, child) {
                return !value
                    ? IconButton(
                        onPressed: () {
                          widget.chatVM.updateSearch(true);
                          isSearchClicked.value = !isSearchClicked.value;
                        },
                        icon: Icon(
                          Icons.search,
                          size: 28,
                          color: Colors.white,
                        ))
                    : SizedBox();
              })
        ]);
  }
}

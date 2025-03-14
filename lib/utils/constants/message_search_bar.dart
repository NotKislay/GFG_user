import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

import '../../view_model/chats/create_chat_viewmodel.dart';
import '../color_theme/colors.dart';

class MessageSearchBar extends StatefulWidget {
  //final ValueNotifier<bool> isSearchClicked;
  //final FocusNode focusNode;
  final CreateChatViewModel chatVM;
  //final String title;

  const MessageSearchBar({
    super.key,
    //required this.isSearchClicked,
    //required this.focusNode,
    required this.chatVM,
    //required this.title,
  });

  @override
  State<MessageSearchBar> createState() => _MessageSearchBarState();
}

class _MessageSearchBarState extends State<MessageSearchBar> {
  late FocusNode focusNode;
  List<int>? searchedIndexes = [];
  int? highlightedIndex = -1;

  @override
  void initState() {
    focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!focusNode.hasFocus) {
        focusNode.requestFocus();
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
          return Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: focusNode,
                  onSubmitted: (searchedString) {
                    log("Searched string was : $searchedString");
                    widget.chatVM.searchAndScroll(searchedString);
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  cursorColor: Colors.white,
                  controller: widget.chatVM.searchController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (searchedIndexes!.contains(highlightedIndex! - 1)) {
                      highlightedIndex = highlightedIndex! - 1;
                      log("Scrolling Up to.......... $highlightedIndex");
                      widget.chatVM.scrollController.scrollTo(
                        index: highlightedIndex!,
                        alignment: 0.3,
                        duration: Duration(milliseconds: 1),
                      );
                    } else {
                      //_showErrorSnackBar("No messages found");
                    }
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_up_outlined,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    if (searchedIndexes!.contains(highlightedIndex! + 1)) {
                      highlightedIndex = highlightedIndex! + 1;
                      log("Scrolling down to.......... $highlightedIndex");
                      widget.chatVM.scrollController.scrollTo(
                        index: highlightedIndex!,
                        alignment: 0.3,
                        duration: Duration(
                            milliseconds:
                                1), /*duration: Duration(milliseconds: 1), curve: Curves.linear*/
                      );
                    } else {
                      //_showErrorSnackBar("No messages found");
                    }
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.white,
                  )),
            ],
          );

          /*return Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor,
                ),
                child: Container(
                  width: 40, // Adjusted for simplicity
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AppImages.busIcon),
                    ),
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
          );*/
  }
}

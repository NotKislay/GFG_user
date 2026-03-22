import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gofriendsgo/model/chat_models/chat_list_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/chat_screen/create_chat_screen.dart';
import 'package:gofriendsgo/view_model/service_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../view/chat_screen/chat_screen.dart';
import '../../view_model/chats/chat_list_viewmodel.dart';

class GridForHomeScreen extends StatefulWidget {
  const GridForHomeScreen({super.key});

  @override
  _GridForHomeScreenState createState() => _GridForHomeScreenState();
}

class _GridForHomeScreenState extends State<GridForHomeScreen> {
  bool _isExpanded = false;
  late ChatListViewmodel chatVM;
  late List<ChatData>? chatList;

  @override
  void initState() {
    super.initState();
    chatVM = Provider.of<ChatListViewmodel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatVM.fetchChatList();
    });
    chatList = chatVM.chatsModel?.data;
  }

  Widget _buildImage(String imageUrl) {
    bool isSvg = imageUrl.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return SvgPicture.network(
        APIConstants.baseImageUrl + imageUrl,
        placeholderBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        fit: BoxFit.contain,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: APIConstants.baseImageUrl + imageUrl,
        fit: BoxFit.contain,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress),
        ),
        errorWidget: (context, url, error) =>
            Image.asset(AppImages.goFriendsGoLogoMini),
      );
    }
  }

  ChatData? checkIfExists(List<ChatData>? chatHistory, String serviceReq) {
    log("CHECK FUNC: ${chatHistory?.asMap()} , service: $serviceReq");
    if (chatHistory == null) {
      return null;
    }
    for (var chat in chatHistory) {
      if (chat.name == serviceReq && chat.status != 2) {
        return chat;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(236, 228, 255, 1),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: mediaqueryheight(0.02, context),
            bottom: mediaqueryheight(0.03, context),
          ),
          child: Consumer<ServiceViewModel>(
            builder: (context, serviceViewModel, child) {
              if (serviceViewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                int totalItems = serviceViewModel.services.length;
                int maxVisibleItems = 8;

                // Determine the item count based on whether it's expanded or not
                int itemCount = totalItems > maxVisibleItems && !_isExpanded
                    ? maxVisibleItems + 1 // 8 items + View More button
                    : totalItems;

                if (_isExpanded) {
                  itemCount++; // Add one more item for the "View Less" button when expanded
                }

                int numRows = (itemCount / 4).ceil();
                double containerHeight =
                    numRows * mediaqueryheight(0.104, context);

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: containerHeight,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemCount,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      /*log("TOTAL 2 ARE ${chatVM.chatsModel!.data[0].toJson()}");
                      final chatListModel = chatVM.chatsModel!.data[0];*/
                      // If we are not yet at the max visible items or in expanded mode
                      if (index < maxVisibleItems ||
                          _isExpanded && index < totalItems) {
                        final gridItems = serviceViewModel.services[index];
                        return GestureDetector(
                          onTap: () {
                            final chatIfExisted =
                                checkIfExists(chatList, gridItems.name);
                            log("QWERTY grid item name-->${gridItems.name} and what is got is: $chatIfExisted");
                            chatIfExisted == null
                                ? PageNavigations().push(CreateChatScreen(
                                    id: gridItems.id.toString(),
                                    serviceName: gridItems.name,
                                    image: gridItems.image,
                                  ))
                                : PageNavigations().push(ChatScreen(
                              image: gridItems.image,
                                    chatData: chatIfExisted,
                                  ));
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: mediaquerywidth(0.14, context),
                                height: mediaqueryheight(0.06, context),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: _buildImage(gridItems.image),
                                ),
                              ),
                              SizedBox(
                                width: mediaquerywidth(0.16, context),
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  text: gridItems.name,
                                  fontFamily: CustomFonts.poppins,
                                  size: 0.03,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (_isExpanded && index == totalItems) {
                        // Display the "View Less" button at the end when expanded
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = false;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey),
                                ),
                                width: mediaquerywidth(0.14, context),
                                height: mediaquerywidth(0.14, context),
                                child: Center(
                                  child: Image.asset(AppImages.iconViewLess, width: 35, height: 35,),
                                ),
                              ),
                              SizedBox(
                                width: mediaquerywidth(0.16, context),
                                child: const CustomText(
                                  textAlign: TextAlign.center,
                                  text: 'View Less',
                                  fontFamily: CustomFonts.poppins,
                                  size: 0.03,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Display the "View More" button if not expanded
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = true;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey),
                                ),
                                width: mediaquerywidth(0.14, context),
                                height: mediaquerywidth(0.14, context),
                                child: Center(
                                  child: Image.asset(AppImages.iconViewMore, width: 33, height: 33,),
                                ),
                              ),
                              SizedBox(
                                width: mediaquerywidth(0.16, context),
                                child: const CustomText(
                                  textAlign: TextAlign.center,
                                  text: 'View More',
                                  fontFamily: CustomFonts.poppins,
                                  size: 0.03,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

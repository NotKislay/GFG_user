import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/chats/chat_list_viewmodel.dart';
import 'package:gofriendsgo/view_model/service_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/api/app_apis.dart';
import '../../utils/constants/custom_text.dart';
import '../../utils/constants/paths.dart';
import '../chat_screen/chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  final bool fromBottomNav;

  const ChatListScreen({super.key, required this.fromBottomNav});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late ServiceViewModel serviceVM;

  @override
  void initState() {
    super.initState();
    serviceVM = Provider.of<ServiceViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      serviceVM.fetchServices();
      context.read<ChatListViewmodel>().fetchChatList();
    });
  }

  String fetchImageFromServices(int? serviceId) {
    var image = "";
    if (serviceId == null) image = "";
    serviceVM.services.asMap().forEach((index, service) {
      if (service.id == serviceId) {
        image = service.image;
      }
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CommonGradientAppBar(
        heading: 'Chats',
        fromBottomNav: widget.fromBottomNav,
      ),
      body: Column(
        children: [
          const ChatDetailsSearch(), // Moved above Consumer
          const CustomSizedBoxHeight(0.03),
          Expanded(
            child: Consumer<ChatListViewmodel>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (value.chatsModel == null ||
                    value.chatsModel!.data.isEmpty) {
                  return const Center(
                    child: Text("No chats available."),
                  );
                }
                final filteredChatList = value.chatsModel!.data.toList()
                  ..sort((a, b) {
                    int unseenCountA = int.tryParse(a.unseenCount ?? '0') ?? 0;
                    int unseenCountB = int.tryParse(b.unseenCount ?? '0') ?? 0;
                    return unseenCountB.compareTo(unseenCountA);
                  });
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: filteredChatList.length,
                  itemBuilder: (context, index) {
                    final chatListModel = filteredChatList[index];
                    final image =
                        fetchImageFromServices(chatListModel.serviceId);
                    final weight = (chatListModel.unseenCount != null &&
                            chatListModel.unseenCount != "0")
                        ? FontWeight.w900
                        : FontWeight.w400;

                    final date =
                        DateTime.parse(chatListModel.createdAt.toString())
                            .toUtc();
                    DateTime dateTimeIst =
                        date.add(Duration(hours: 5, minutes: 30));
                    final formattedTimestamp =
                        DateFormat('hh:mm a').format(dateTimeIst);
                    return ListTile(
                      onTap: () {
                        final chatListViewmodel =
                            context.read<ChatListViewmodel>();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    image: fetchImageFromServices(
                                        chatListModel.serviceId),
                                    chatData: chatListModel,
                                  )),
                        ).then((value) {
                          if (mounted) {
                            chatListViewmodel.fetchChatList();
                          }
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          chatListViewmodel.sendSeenAllEvent(chatListModel.id);
                        });

                        ;
                      },
                      title: CustomText(
                        weight: weight,
                        text: chatListModel.name,
                        color: AppColors.blackColor,
                        fontFamily: CustomFonts.inter,
                        size: 0.04,
                      ),
                      subtitle: CustomText(
                        weight: FontWeight.w300,
                        text: chatListModel.tag ?? "",
                        color: AppColors.blackColor,
                        fontFamily: CustomFonts.inter,
                        size: 0.03,
                      ),
                      leading: ClipOval(
                        child: image.toLowerCase().endsWith('.svg')
                            ? SvgPicture.network(
                                height: 40,
                                width: 40,
                                APIConstants.baseImageUrl + image,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                height: 40,
                                width: 40,
                                APIConstants.baseImageUrl + image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.error,
                                    size: 40,
                                  );
                                },
                              ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            weight: weight,
                            text: formattedTimestamp,
                            color: AppColors.blackColor,
                            fontFamily: CustomFonts.inter,
                            size: 0.03,
                          ),
                          chatListModel.unseenCount != null &&
                                  chatListModel.unseenCount != "0"
                              ? Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        colors: AppColors.gradientColors),
                                  ),
                                  child: Center(
                                      child: Text(
                                    chatListModel.unseenCount!,
                                    style: TextStyle(color: Colors.white),
                                  )),
                                )
                              : SizedBox(),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatDetailsSearch extends StatelessWidget {
  const ChatDetailsSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mediaquerywidth(0.06, context),
        vertical: mediaqueryheight(0.04, context),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(25),
          /* Uncomment this if you want a shadow effect
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          */
        ),
        child: TextField(
          onChanged: (value) {
            // Assuming you want to filter chats based on the search query
            context.read<ChatListViewmodel>().fetchChatList();
          },
          decoration: InputDecoration(
            hintText: 'Search Message or Users',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: mediaqueryheight(0.015, context),
            ),
          ),
        ),
      ),
    );
  }
}

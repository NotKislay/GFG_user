import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/chat_list_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/cab_rates_screen/cab_rates_screen.dart';
import 'package:gofriendsgo/view_model/banner_viewmodel.dart';
import 'package:gofriendsgo/view_model/bookings_viewmodel.dart';
import 'package:gofriendsgo/view_model/carosual_viewmodel.dart';
import 'package:gofriendsgo/view_model/chats/chat_list_viewmodel.dart';
import 'package:gofriendsgo/view_model/departure_viewmodel.dart';
import 'package:gofriendsgo/view_model/gallery_viewmodel.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';
import 'package:gofriendsgo/view_model/sales_exe_viewmodel.dart';
import 'package:gofriendsgo/view_model/service_viewmodel.dart';
import 'package:gofriendsgo/view_model/stories_viewmodel.dart';
import 'package:gofriendsgo/view_model/team_viewmodel.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/carosual_widget.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/category_widgets.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/drawer_widget.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/grid_for_home.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/home_appbar.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/story_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    func(context);
    super.initState();
    adController = PageController(
      viewportFraction: 0.8, // Allows visibility of adjacent cards
      initialPage: 0,
    );
    adController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    adController.dispose();
    super.dispose();
  }

  PageController adController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 232, 243, 248),
      appBar: const HomeAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: commonScreenPadding(context)),
            const StoryViewWidget(),
            HomeCarosualWidget(adController: adController),
            const CustomSizedBoxHeight(0.01),
            Consumer<CarousalViewModel>(
              builder: (context, carousalViewModel, child) {
                if (carousalViewModel.isLoading) {
                  return const CircularProgressIndicator();
                }
                // Get the total count of carousel items
                final carouselCount =
                    carousalViewModel.carouselsModel?.data.length ?? 0;
                return Transform.scale(
                  scale: 0.5,
                  child: SmoothPageIndicator(
                    controller: adController,
                    count: carouselCount, // Set the count dynamically
                  ),
                );
              },
            ),
            const GridForHomeScreen(),
            const CategoriesWidget(),
            SizedBox(
              height: mediaqueryheight(0.18, context),
              width: mediaquerywidth(1, context),
              child: GestureDetector(
                onTap: () => PageNavigations().push(const CabRatesScreen()),
                child: Consumer<BannerViewModel>(
                    builder: (context, bannerViewModel, child) {
                  if (bannerViewModel.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  final banner =
                      bannerViewModel.bannersResponse!.data.banners.isNotEmpty
                          ? bannerViewModel.bannersResponse?.data.banners.first
                          : null;

                  if (banner != null) {
                    return GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        child: SizedBox(
                          height: mediaqueryheight(0.15, context),
                          width: double.infinity,
                          child: Image.network(
                            APIConstants.baseImageUrl + banner!.image,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(AppImages.goFriendsGoLogoMini);
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
              ),
            ),
            const CustomSizedBoxHeight(0.013),
          ],
        ),
      ),
    );
  }
}

func(BuildContext context) {
  SharedPreferencesServices().getToken();
  context.read<ProfileViewModel>().fetchProfile();
  context.read<StoriesViewModel>().fetchStories();
  context.read<ServiceViewModel>().fetchServices();
  context.read<CarousalViewModel>().fetchCarousals();
  context.read<BannerViewModel>().fetchBanners();
  context.read<BookingViewModel>().fetchBookingsfromservice();
  context.read<ChatListViewmodel>().fetchChatList();
  context.read<TeamsViewModel>().fetchTeams();
  context.read<FixedDeparturesViewModel>().fetchFixedDepartures();
  context.read<SalesPersonViewModel>().fetchSalesPerson();
  context.read<GalleryViewModel>().fetchGallery();
}

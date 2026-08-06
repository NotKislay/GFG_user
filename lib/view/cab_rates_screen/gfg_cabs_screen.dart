import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view_model/gfg_cabs_viewmodel.dart';
import 'package:provider/provider.dart';

class GfgCabsScreen extends StatefulWidget {
  const GfgCabsScreen({super.key});

  @override
  State<GfgCabsScreen> createState() => _GfgCabsScreenState();
}

class _GfgCabsScreenState extends State<GfgCabsScreen> {
  late Map<String, List<List<String>>> vehicleMap;
  final TextEditingController _cityController = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<QuickRidesViewmodel>();
      vm.loadInitial();
    });

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        final vm = context.read<QuickRidesViewmodel>();
        vm.loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _cityController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildRideContent(BuildContext context, QuickRidesViewmodel vm) {
    if (vm.isLoadingRides && vm.rides.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CircularProgressIndicator(
            color: AppColors.dateIconColor,
          ),
        ),
      );
    }

    if (!vm.isLoadingRides && vm.rides.isEmpty) {
      if (vm.selectedCity != null) {
        return Center(
          child: Text(
            "No rides available for the selected city.",
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        );
      }

      return Center(
        child: Text(
          "Start searching for your city to see available rides.",
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      );
    }

    return ListView.builder(
      controller: _controller,
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: vm.rides.length + (vm.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == vm.rides.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final ride = vm.rides[index];

        return createRideListTile(
          driverName: ride.driverName,
          driverPhone: ride.phone,
          carRegistrationNumber: ride.vehicleNumber,
          carModel: ride.vehicle,
          cityName: ride.location.name,
          rating: ride.rating.toString(),
          cardImage: ride.cardImage,
          driverImage: ride.driverImage,
          redirectToPhone: () {
            vm.redirectToPhone(ride.phone);
          },
          redirectToWhatsApp: () {
            vm.redirectToWhatsApp(ride.whatsapp);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonGradientAppBar(
        heading: "Quick Rides",
        fromBottomNav: false,
      ),
      body: Consumer<QuickRidesViewmodel>(
        builder: (context, vm, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const CustomText(
                  text: "Let's find your city",
                  fontFamily: CustomFonts.roboto,
                  size: 0.065,
                  color: AppColors.blackColor,
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _cityController,
                        onChanged: (value) {
                          vm.searchCity(value);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.location_on_rounded,
                            color: Color(0xFF3120D8),
                          ),
                          suffixIcon: _cityController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _cityController.clear();
                                    vm.clearCitySearch();
                                  },
                                )
                              : null,
                          hintText: "Search",
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color(0xFF3120D8),
                              width: 2,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (vm.showCityDropdown)
                        Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxHeight: 260),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            border: Border(
                              left: BorderSide(color: Colors.grey.shade200),
                              right: BorderSide(color: Colors.grey.shade200),
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: vm.isLoadingCities
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : vm.cities.isEmpty
                                  ? const Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_off_outlined,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            "No cities found",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      itemCount: vm.cities.length,
                                      separatorBuilder: (_, __) => Divider(
                                        height: 1,
                                        color: Colors.grey.shade100,
                                      ),
                                      itemBuilder: (context, index) {
                                        final city = vm.cities[index];

                                        return ListTile(
                                          leading: const Icon(
                                            Icons.location_city,
                                            color: Color(0xFF3120D8),
                                          ),
                                          title: Text(city.name),
                                          onTap: () async {
                                            _cityController.text =
                                                city.name.trim();
                                            await vm.setSelectedCity(
                                              city.id,
                                              city.name,
                                            );
                                          },
                                        );
                                      },
                                    ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(child: _buildRideContent(context, vm)),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget createRideListTile({
  required final String driverName,
  required final String driverPhone,
  required final String carRegistrationNumber,
  required final String carModel,
  required final String cityName,
  required final String rating,
  required final String? cardImage,
  required final String? driverImage,
  required final VoidCallback redirectToPhone,
  required final VoidCallback redirectToWhatsApp,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F5FF),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFF3120D8).withOpacity(0.08),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFF3120D8).withOpacity(.12),
          child: CachedNetworkImage(
            imageUrl: APIConstants.baseImageUrl + (driverImage ?? ""),
            imageBuilder: (context, imageProvider) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (_, __) =>
                const CircularProgressIndicator(strokeWidth: 2),
            errorWidget: (_, __, ___) => const Icon(
              Icons.person_rounded,
              size: 30,
              color: Color(0xFF3120D8),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      driverName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.orange,
                          size: 16,
                        ),
                        SizedBox(width: 2),
                        Text(
                          rating,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.phone_rounded,
                    size: 18,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    driverPhone,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(
                    Icons.directions_car_outlined,
                    size: 18,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    carModel,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(
                    Icons.location_city,
                    size: 18,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cityName,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.badge_outlined,
                    size: 18,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    carRegistrationNumber,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: APIConstants.baseImageUrl + (cardImage ?? ""),
                    fit: BoxFit.cover,
                    height: 140,
                    width: double.infinity,
                    errorWidget: (context, url, error) => CachedNetworkImage(
                      imageUrl:
                          "https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=800",
                      fit: BoxFit.fitWidth,
                    ),
                  )),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        redirectToPhone();
                      },
                      icon: const Icon(Icons.call_rounded, size: 18),
                      label: const Text("Call Driver"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3120D8),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ClipOval(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        redirectToWhatsApp();
                      },
                      icon: Image.asset(
                        AppImages.whatsapp,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ],
    ),
  );
}

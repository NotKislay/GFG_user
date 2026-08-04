import 'package:flutter/material.dart';
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

  @override
  void initState() {
    context.read<GfgCabsViewmodel>().fetchCabs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonGradientAppBar(
        heading: "Quick Rides",
        fromBottomNav: false,
      ),
      body: Consumer<GfgCabsViewmodel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!vm.isLoading) {
            final datas = vm.cabResponse!.data.cabs;
            Map<String, List<List<String>>> tempMap = {};

            for (var element in datas) {
              if (tempMap.containsKey(element.type)) {
                tempMap[element.type]!
                    .add([element.vechile, element.price, element.perKm]);
              } else {
                tempMap[element.type] = [
                  [element.vechile, element.price, element.perKm]
                ];
              }
            }

            vehicleMap = tempMap;

            vehicleMap.entries.toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                        text: "Let's find your city",
                        fontFamily: CustomFonts.roboto,
                        size: 0.065,
                        color: AppColors.blackColor),
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
                            //focusNode: _cityFocusNode,
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
                              constraints: const BoxConstraints(
                                maxHeight: 260,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                  right: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              child: vm.filteredCities.isEmpty
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
                                      itemCount: vm.filteredCities.length,
                                      separatorBuilder: (_, __) => Divider(
                                        height: 1,
                                        color: Colors.grey.shade100,
                                      ),
                                      itemBuilder: (context, index) {
                                        final city = vm.filteredCities[index];

                                        return ListTile(
                                          leading: const Icon(
                                            Icons.location_city,
                                            color: Color(0xFF3120D8),
                                          ),
                                          title: Text(city),
                                          onTap: () {
                                            _cityController.text = city;

                                            vm.setSelectedCity(city);
                                          },
                                        );
                                      },
                                    ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
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
                            backgroundColor:
                                const Color(0xFF3120D8).withOpacity(.12),
                            child: const Icon(
                              Icons.person_rounded,
                              size: 30,
                              color: Color(0xFF3120D8),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "Rahul Sharma",
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
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: Colors.orange,
                                            size: 16,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "4.9",
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
                                      "+91 98765 43210",
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
                                      Icons.car_rental_outlined,
                                      size: 18,
                                      color: Colors.grey.shade700,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Maruti Benz",
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
                                      "Bhopal",
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
                                  child: Image.network(
                                    "https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=800",
                                    height: 140,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Row(children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          vm.redirectToPhone("+919992226660");
                                        },
                                        icon: const Icon(Icons.call_rounded,
                                            size: 18),
                                        label: const Text("Call Driver"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF3120D8),
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
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
                                          vm.redirectToWhatsApp(
                                              "+919992223330");
                                        },
                                        icon: Image.asset(
                                          AppImages.whatsapp,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
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
                    )
                    // ListView.builder(
                    //   itemCount: vehicleMap.length,
                    //   itemBuilder: (context, index) {
                    //     MapEntry<String, List<List<String>>> element =
                    //         entries[index];
                    //     return Padding(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: mediaquerywidth(0.04, context),
                    //           vertical: mediaqueryheight(0.02, context)),
                    //       child: Material(
                    //         elevation: 10,
                    //         child: Container(
                    //           width: double.infinity,
                    //           decoration: BoxDecoration(
                    //             color: AppColors.whiteColor,
                    //             borderRadius: BorderRadius.circular(12),
                    //           ),
                    //           child: Padding(
                    //             padding:
                    //                 EdgeInsets.all(mediaqueryheight(0.02, context)),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 const CustomSizedBoxHeight(0.02),
                    //                 CabRatesTitle(
                    //                     title: element.key == 'outofTown'
                    //                         ? 'Out Of Town'
                    //                         : 'Local Patna'),
                    //                 const CustomSizedBoxHeight(0.015),
                    //                 const Divider(),
                    //                 const CustomSizedBoxHeight(0.015),
                    //                 Container(
                    //                   width: double.infinity,
                    //                   decoration: BoxDecoration(
                    //                       borderRadius: BorderRadius.circular(8),
                    //                       border: Border.all(
                    //                           color: Colors.grey.shade300),
                    //                       color: AppColors.whiteColor),
                    //                   child: Column(
                    //                     children: [
                    //                       const VehicleAndKmHeading(),
                    //                       VehicleServiceDetails(
                    //                         serviceDetails: element.value,
                    //                       ),
                    //                       ExtraNoteInCabRates(
                    //                         isLocalPatna:
                    //                             element.key == 'LocalPatna',
                    //                       ),
                    //                       const GetDetailsButtonInCabRates()
                    //                     ],
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // )
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

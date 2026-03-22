//adjustable GridView
// import 'dart:async';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:gofriendsgo/services/api/app_apis.dart';
// import 'package:gofriendsgo/utils/constants/app_bar.dart';
// import 'package:gofriendsgo/utils/constants/mediaquery.dart';
// import 'package:gofriendsgo/view_model/gallery_viewmodel.dart';
// import 'package:provider/provider.dart';
// import 'package:gofriendsgo/utils/constants/paths.dart';
//
// class GalleryScreen extends StatefulWidget {
//   const GalleryScreen({super.key});
//
//   @override
//   State<GalleryScreen> createState() => _GalleryScreenState();
// }
//
// class _GalleryScreenState extends State<GalleryScreen> {
//   @override
//   void initState() {
//     context.read<GalleryViewModel>().fetchGallery();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size(double.infinity, mediaqueryheight(0.07, context)),
//         child: const CommonGradientAppBar(
//           fromBottomNav: false,
//           heading: 'Gallery',
//         ),
//       ),
//       body: Consumer<GalleryViewModel>(
//         builder: (context, value, child) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             child: MasonryGridView.count(
//               crossAxisCount: 2,
//               mainAxisSpacing: 16,
//               crossAxisSpacing: 16,
//               itemCount: value.galleryResponse?.data.galleries.length ?? 0,
//               itemBuilder: (context, index) {
//                 final galleryItem = value.galleryResponse?.data.galleries[index];
//
//                 // Set span count based on image aspect ratio (use async image loading to get aspect ratio)
//                 return FutureBuilder(
//                   future: _getImageAspectRatio(API.baseImageUrl + galleryItem!.image),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     }
//
//                     // Determine whether to span one or two columns
//                     final bool isWideImage = (snapshot.data ?? 1.0) > 1.0;
//
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             spreadRadius: 1,
//                             blurRadius: 6,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(16),
//                         child: StaggeredGridTile.count(
//                           crossAxisCellCount: isWideImage ? 2 : 1,
//                           mainAxisCellCount: isWideImage ? 1 : 1,
//                           child: CachedNetworkImage(
//                             imageUrl: API.baseImageUrl + galleryItem.image,
//                             fit: BoxFit.cover,
//                             progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//                               child: CircularProgressIndicator(
//                                 value: downloadProgress.progress,
//                               ),
//                             ),
//                             errorWidget: (context, url, error) => Image.asset(
//                               AppImages.goFriendsGoLogo,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Future<double> _getImageAspectRatio(String url) async {
//     final completer = Completer<double>();
//
//     final image = CachedNetworkImageProvider(url);
//     final stream = image.resolve(ImageConfiguration.empty);
//     stream.addListener(
//       ImageStreamListener((ImageInfo info, bool _) {
//         final imageWidth = info.image.width.toDouble();
//         final imageHeight = info.image.height.toDouble();
//         completer.complete(imageWidth / imageHeight);
//       }),
//     );
//
//     return completer.future;
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view_model/gallery_viewmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../chat_screen/utils/display_image_attachment.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late final String downloadDirPath;

  @override
  void initState() {
    context.read<GalleryViewModel>().fetchGallery();
    setPath();
    super.initState();
  }

  void setPath() async {
    final directory = await getDownloadsDirectory();
    downloadDirPath = directory?.path ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, mediaqueryheight(0.07, context)),
        child: const CommonGradientAppBar(
          fromBottomNav: false,
          heading: 'Gallery',
        ),
      ),
      body: Consumer<GalleryViewModel>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: MasonryGridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 13,
              crossAxisSpacing: 13,
              itemCount: value.galleryResponse?.data.galleries.length ?? 0,
              itemBuilder: (context, index) {
                final galleryItem =
                    value.galleryResponse?.data.galleries[index];
                return GestureDetector(
                  onTap: () {
                    MessageAttachment attachment = MessageAttachment(
                        newName: galleryItem.image, oldName: galleryItem.image);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DisplayImageAttachment(
                                file: attachment,
                                directoryPath: downloadDirPath,
                                dateTime: null,
                                senderName: null,
                                message: null,
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 0.9,
                        // Ensures square images for consistency
                        child: CachedNetworkImage(
                          imageUrl:
                              APIConstants.baseImageUrl + galleryItem!.image,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppImages.goFriendsGoLogoMini,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

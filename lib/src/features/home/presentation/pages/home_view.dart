import 'package:tiwee/core/consts.dart';
import 'package:tiwee/src/features/home/presentation/widgets/footer.dart';
import 'package:tiwee/src/features/home/presentation/widgets/header.dart';
import 'package:tiwee/src/features/home/presentation/widgets/sample_player.dart';
// import 'package:tiwee/src/features/home/presentation/widgets/chewie_player.dart';
import 'package:tiwee/src/features/home/presentation/widgets/search_delegate.dart';
import 'package:app_logger/app_logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_logic.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSearch(
                context: context,
                delegate: ChannelSearchDelegate(
                    tvChannelsList: controller.tvChannelsList));
          },
          child: Icon(Icons.search),
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kBlackBg, kWhiteBg],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: controller.obx(
              (state) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top App Header
                  HeaderApp(),

                  // Main Grid Area
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 15.0),
                      child: controller.tvChannelsList.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : GridView.count(
                              scrollDirection: Get.context?.orientation ==
                                      Orientation.landscape
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              crossAxisCount: Get.context?.orientation ==
                                      Orientation.landscape
                                  ? 1
                                  : 2, // vertical count (rows)
                              mainAxisSpacing: 25,
                              crossAxisSpacing: 40,
                              childAspectRatio: 1.2, // Less stretched width
                              children: List.generate(
                                controller.tvChannelsList.length,
                                (index) {
                                  var channel =
                                      controller.tvChannelsList[index];
                                  return CachedNetworkImage(
                                    imageUrl: channel.logo,
                                    imageBuilder: (context, imageProvider) =>
                                        InkWell(
                                      onTap: () {
                                        AppLogger.it.logInfo(
                                            "channel ${channel.title}");
                                        AppLogger.it
                                            .logInfo("channel ${channel.url}");
                                        if (channel.url != null) {
                                          Get.to(() =>
                                              SamplePlayer(url: channel.url!));
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            child: CachedNetworkImage(
                                              imageUrl: channel.logo,
                                              width: 100, // Bigger image
                                              height: 100,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(
                                                      strokeWidth: 2),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.network(
                                                      'https://placehold.co/100x100.png'),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            channel.title ?? '',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Image.network(
                                            'https://placehold.co/400x600.png'),
                                  );
                                },
                              ),
                            ),
                    ),
                  ),

                  // Footer Info Row
                  FooterApp(),
                ],
              ),
            )),
      ),
    );
  }
}

import 'package:tiwee/core/consts.dart';
import 'package:tiwee/src/features/home/presentation/widgets/sample_player.dart';
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "HFM STREAM",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.settings, color: Colors.white),
                          onPressed: () {
                            // Handle settings navigation
                          },
                        ),
                      ],
                    ),
                  ),

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
                                      child: Container(
                                          width: Get.width / 4.3,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 6,
                                                offset: Offset(2, 4),
                                              )
                                            ],
                                          )),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Expiration: Unlimited",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Username: Admin",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

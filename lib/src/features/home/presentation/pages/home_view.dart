import 'package:Tiwee/core/consts.dart';
import 'package:Tiwee/src/features/home/presentation/widgets/sample_player.dart';
import 'package:Tiwee/src/features/home/presentation/widgets/search_delegate.dart';
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
              (state) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: GridView.builder(
                  itemCount: controller.tvChannelsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.6),
                  itemBuilder: (context, index) {
                    var channel = controller.tvChannelsList[index];

                    return CachedNetworkImage(
                      imageUrl: channel.logo,
                      imageBuilder: (context, imageProvider) => InkWell(
                        onTap: () {
                          AppLogger.it.logInfo("channel ${channel.title}");
                          AppLogger.it.logInfo("channel ${channel.url}");
                          if (channel.url != null) {
                            Get.to(() => SamplePlayer(url: channel.url!));
                          }
                        },
                        child: Container(
                          height: Get.height * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.network('https://placehold.co/400x600.png'),
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}

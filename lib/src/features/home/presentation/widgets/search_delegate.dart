import 'package:tiwee/src/features/home/domain/entities/tv_channel_entity.dart';
import 'package:tiwee/src/features/home/presentation/widgets/sample_player.dart';
import 'package:app_logger/app_logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelSearchDelegate extends SearchDelegate{

  final List<TvChannelEntity> tvChannelsList;
  ChannelSearchDelegate({required this.tvChannelsList});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {

    List<TvChannelEntity> searchResults=tvChannelsList.where((element) => element.title?.toLowerCase().contains(query.toLowerCase())==true,).toList();

    return  GridView.builder(
      itemCount: searchResults.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Get.context?.orientation==Orientation.portrait? 3:6,
          mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 0.6), itemBuilder: (context, index) {

      var channel=searchResults[index];

      return  CachedNetworkImage(
        imageUrl: channel.logo,
        imageBuilder: (context, imageProvider) => InkWell(onTap: () {
          AppLogger.it.logInfo("channel ${channel.title}");
          AppLogger.it.logInfo("channel ${channel.url}");
          if(channel.url!=null){
            Get.to(()=>SamplePlayer(url: channel.url!));
          }
        },child: Container(
          height: Get.height*0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),),
        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
        errorWidget: (context, url, error) => Image.network('https://placehold.co/400x600.png'),
      );
    },);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<TvChannelEntity> searchResults=tvChannelsList.where((element) => element.title?.toLowerCase().contains(query.toLowerCase())==true,).toList();

    return  GridView.builder(
      itemCount: searchResults.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  crossAxisCount: Get.context?.orientation==Orientation.portrait? 3:6,mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 0.6), itemBuilder: (context, index) {

      var channel=searchResults[index];

      return  CachedNetworkImage(
        imageUrl: channel.logo,
        imageBuilder: (context, imageProvider) => InkWell(onTap: () {
          AppLogger.it.logInfo("channel ${channel.title}");
          AppLogger.it.logInfo("channel ${channel.url}");
          if(channel.url!=null){
            Get.to(()=>SamplePlayer(url: channel.url!));
          }
        },child: Container(
          height: Get.height*0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),),
        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
        errorWidget: (context, url, error) => Image.network('https://placehold.co/400x600.png'),
      );
    },);
  }
}
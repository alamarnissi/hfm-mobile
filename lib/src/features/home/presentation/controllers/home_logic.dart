import 'package:tiwee/src/core/injectable/injection.dart';
import 'package:tiwee/src/features/home/domain/entities/tv_channel_entity.dart';
import 'package:app_logger/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'home_state.dart';

class HomeLogic extends GetxController with StateMixin<HomeState> {
  List<TvChannelEntity> tvChannelsList = [];
  final url = "https://iptv-org.github.io/iptv/index.m3u";
  @override
  void onInit() {
    change(null, status: RxStatus.success());
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  initData() async {

    tvChannelsList = await fetchAndConvertM3U(url);
    AppLogger.it.logInfo("jsonResult ${tvChannelsList}");
    update();
  }

  Future<List<TvChannelEntity>> fetchAndConvertM3U(String url) async {
    final response = await tiweeGetIt<Dio>().get(url);
    // final response = await getIt<Dio>().get(url);

    if (response.statusCode == 200) {
      var apiParseResult = parseM3U(response.data);
      return apiParseResult.where((element) => (element['url']!=null&& element['url']!="")&&  (element['logo']!=null&& element['logo']!="" ),)
          .map<TvChannelEntity>(
            (e) => TvChannelEntity.fromJson(e),
          )
          .toList();
    } else {
      throw Exception("Failed to load M3U file");
    }
  }

  List<Map<String, String>> parseM3U(String m3uContent) {
    final List<Map<String, String>> channels = [];
    final lines = m3uContent.split("\n");

    String? currentTitle;
    String? currentGroup;
    String? currentLogo;

    for (var line in lines) {
      line = line.trim();

      if (line.startsWith("#EXTINF:")) {
        final matches = RegExp(r'tvg-logo="(.*?)"').firstMatch(line);
        currentLogo = matches?.group(1) ?? '';

        final titleMatch = RegExp(r',(.+)$').firstMatch(line);
        currentTitle = titleMatch?.group(1)?.trim() ?? '';

        final groupMatch = RegExp(r'group-title="(.*?)"').firstMatch(line);
        currentGroup = groupMatch?.group(1) ?? '';
      } else if (line.isNotEmpty && !line.startsWith("#")) {
        channels.add({
          "title": currentTitle ?? "Unknown",
          "group": currentGroup ?? "General",
          "logo": currentLogo ?? "",
          "url": line,
        });
      }
    }

    return channels;
  }
}

import 'package:flutter/foundation.dart';
import 'package:tiwee/src/core/injectable/injection.dart';
import 'package:tiwee/src/features/mainCategories/domain/entities/tv_channel_entity.dart';
import 'package:app_logger/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'maincategories_state.dart';

class MaincategoriesLogic extends GetxController with StateMixin<MainCategoriesState> {
  final Dio dio = Dio();
  final GetStorage storage = GetStorage();

  List<TvChannelEntity> tvChannelsList = [];

  @override
  void onInit() {
    dio.interceptors.add(
      kDebugMode
          ? LogInterceptor(
              responseBody: false,
              requestBody: true,
              request: true,
              requestHeader: true,
              error: true,
              responseHeader: true,
              logPrint: (obj) {
                debugPrint(obj.toString());
              },
            )
          : LogInterceptor(logPrint: (_) {}),
    );

    change(null, status: RxStatus.success());
    initData();
    super.onInit();
  }

  Future<void> initData() async {
    try {
      final channels = await fetchFromCachedApiResponse();
      tvChannelsList = channels;
      AppLogger.it.logInfo("Loaded ${tvChannelsList.length} channels");
      update();
    } catch (e) {
      AppLogger.it.logError("Failed to load channels: $e");
      change(null, status: RxStatus.error("Failed to load channels"));
    }
  }

  /// Load from GetStorage: 'channel_groups'
  Future<List<TvChannelEntity>> fetchFromCachedApiResponse() async {
    final rawGroups = storage.read('channel_groups');

    if (rawGroups == null || rawGroups is! Map) {
      throw Exception("No cached channels found.");
    }

    List<TvChannelEntity> channels = [];

    final Map<String, dynamic> groups = Map<String, dynamic>.from(rawGroups);

    groups.forEach((groupName, channelList) {
      final List list = channelList as List;
      for (var channel in list) {
        final channelMap = Map<String, dynamic>.from(channel);
        channels.add(
          TvChannelEntity(
            title: channelMap['name'] ?? 'Unknown',
            group: groupName,
            logo: channelMap['logo'] ?? '',
            url: channelMap['url'] ?? '',
          ),
        );
      }
    });

    return channels
        .where((c) =>
            c.url != null &&
            c.url!.isNotEmpty &&
            c.logo != null &&
            c.logo!.isNotEmpty)
        .toList();
  }
}

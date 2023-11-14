// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedSetting _$FeedSettingFromJson(Map<String, dynamic> json) => FeedSetting(
      crawlType: $enumDecodeNullable(_$CrawlTypeEnumMap, json['crawlType']),
      listLayoutType: $enumDecodeNullable(
          _$ArticleListLayoutTypeEnumMap, json['listLayoutType']),
      detailLayoutType: $enumDecodeNullable(
          _$ArticleDetailLayoutTypeEnumMap, json['detailLayoutType']),
      headImageViewType: $enumDecodeNullable(
          _$ArticleDetailHeadImageViewTypeEnumMap, json['headImageViewType']),
      videoViewType: $enumDecodeNullable(
          _$ArticleDetailVideoViewTypeEnumMap, json['videoViewType']),
      mobilizerType:
          $enumDecodeNullable(_$MobilizerTypeEnumMap, json['mobilizerType']),
      cacheImageTypeOnPull:
          $enumDecodeNullable(_$CacheTypeEnumMap, json['cacheImageTypeOnPull']),
      cacheWebTypeOnPull:
          $enumDecodeNullable(_$CacheTypeEnumMap, json['cacheWebTypeOnPull']),
      cacheWebTypeOnRead:
          $enumDecodeNullable(_$CacheTypeEnumMap, json['cacheWebTypeOnRead']),
      pullOnStartUp:
          $enumDecodeNullable(_$BoolTypeEnumMap, json['pullOnStartUp']),
      showRelatedArticles:
          $enumDecodeNullable(_$BoolTypeEnumMap, json['showRelatedArticles']),
      showImageAlt:
          $enumDecodeNullable(_$BoolTypeEnumMap, json['showImageAlt']),
      removeDuplicateArticles: $enumDecodeNullable(
          _$BoolTypeEnumMap, json['removeDuplicateArticles']),
      autoReadOnScroll:
          $enumDecodeNullable(_$BoolTypeEnumMap, json['autoReadOnScroll']),
      autoPullFrequency: json['autoPullFrequency'] as int?,
    );

Map<String, dynamic> _$FeedSettingToJson(FeedSetting instance) =>
    <String, dynamic>{
      'crawlType': _$CrawlTypeEnumMap[instance.crawlType],
      'listLayoutType': _$ArticleListLayoutTypeEnumMap[instance.listLayoutType],
      'detailLayoutType':
          _$ArticleDetailLayoutTypeEnumMap[instance.detailLayoutType],
      'headImageViewType':
          _$ArticleDetailHeadImageViewTypeEnumMap[instance.headImageViewType],
      'videoViewType':
          _$ArticleDetailVideoViewTypeEnumMap[instance.videoViewType],
      'mobilizerType': _$MobilizerTypeEnumMap[instance.mobilizerType],
      'cacheImageTypeOnPull': _$CacheTypeEnumMap[instance.cacheImageTypeOnPull],
      'cacheWebTypeOnPull': _$CacheTypeEnumMap[instance.cacheWebTypeOnPull],
      'cacheWebTypeOnRead': _$CacheTypeEnumMap[instance.cacheWebTypeOnRead],
      'pullOnStartUp': _$BoolTypeEnumMap[instance.pullOnStartUp],
      'showRelatedArticles': _$BoolTypeEnumMap[instance.showRelatedArticles],
      'showImageAlt': _$BoolTypeEnumMap[instance.showImageAlt],
      'removeDuplicateArticles':
          _$BoolTypeEnumMap[instance.removeDuplicateArticles],
      'autoReadOnScroll': _$BoolTypeEnumMap[instance.autoReadOnScroll],
      'autoPullFrequency': instance.autoPullFrequency,
    };

const _$CrawlTypeEnumMap = {
  CrawlType.unspecified: 'unspecified',
  CrawlType.rss: 'rss',
  CrawlType.full: 'full',
  CrawlType.web: 'web',
  CrawlType.external: 'external',
};

const _$ArticleListLayoutTypeEnumMap = {
  ArticleListLayoutType.unspecified: 'unspecified',
  ArticleListLayoutType.card: 'card',
  ArticleListLayoutType.flow: 'flow',
  ArticleListLayoutType.magazine: 'magazine',
  ArticleListLayoutType.compact: 'compact',
  ArticleListLayoutType.gallery: 'gallery',
  ArticleListLayoutType.podcast: 'podcast',
};

const _$ArticleDetailLayoutTypeEnumMap = {
  ArticleDetailLayoutType.unspecified: 'unspecified',
  ArticleDetailLayoutType.single: 'single',
  ArticleDetailLayoutType.leftAndRight: 'leftAndRight',
  ArticleDetailLayoutType.upAndDown: 'upAndDown',
};

const _$ArticleDetailHeadImageViewTypeEnumMap = {
  ArticleDetailHeadImageViewType.unspecified: 'unspecified',
  ArticleDetailHeadImageViewType.hide: 'hide',
  ArticleDetailHeadImageViewType.first: 'first',
  ArticleDetailHeadImageViewType.random: 'random',
  ArticleDetailHeadImageViewType.gallery: 'gallery',
  ArticleDetailHeadImageViewType.slideshow: 'slideshow',
};

const _$ArticleDetailVideoViewTypeEnumMap = {
  ArticleDetailVideoViewType.unspecified: 'unspecified',
  ArticleDetailVideoViewType.hide: 'hide',
  ArticleDetailVideoViewType.screenshot: 'screenshot',
  ArticleDetailVideoViewType.video: 'video',
};

const _$MobilizerTypeEnumMap = {
  MobilizerType.unspecified: 'unspecified',
  MobilizerType.feedbinParser: 'feedbinParser',
  MobilizerType.feedMe: 'feedMe',
  MobilizerType.googleWebLight: 'googleWebLight',
};

const _$CacheTypeEnumMap = {
  CacheType.unspecified: 'unspecified',
  CacheType.enable: 'enable',
  CacheType.onlyNotUnderLowBattery: 'onlyNotUnderLowBattery',
  CacheType.onlyUnderWiFi: 'onlyUnderWiFi',
  CacheType.onlyNotUnderLowBatteryAndUnderWiFi:
      'onlyNotUnderLowBatteryAndUnderWiFi',
  CacheType.disable: 'disable',
};

const _$BoolTypeEnumMap = {
  BoolType.unspecified: 'unspecified',
  BoolType.enable: 'enable',
  BoolType.diable: 'diable',
};

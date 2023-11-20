/// 文章拉取方式：跟随全局设置、RSS、全文、Web页面、外部浏览器
enum CrawlType { unspecified, rss, full, web, external }

/// 文章列表布局：跟随全局设置、卡片、瀑布流、杂志、紧凑、画廊、播客
enum ArticleListLayoutType {
  unspecified,
  card,
  flow,
  magazine,
  compact,
  gallery,
  podcast
}

/// 文章详情布局：跟随全局设置、单个文章、左右滑动卡片、上下滑动文章
enum ArticleDetailLayoutType {
  unspecified,
  single,
  leftAndRight,
  upAndDown,
}

/// 文章详情头图显示选项：跟随全局设置、不显示头图、首张图片、随机图片、画廊、幻灯片
enum ArticleDetailHeadImageViewType {
  unspecified,
  hide,
  first,
  random,
  gallery,
  slideshow
}

/// 文章详情视频显示选项：跟随全局设置、不显示、截取图片、视频控件
enum ArticleDetailVideoViewType { unspecified, hide, screenshot, video }

/// 文章Mobilizer选项：跟随全局设置、Feedbin Parser、FeedMe、Google Web Light
enum MobilizerType { unspecified, feedbinParser, feedMe, googleWebLight }

/// 缓存选项：跟随全局设置、始终缓存、仅在充电时缓存、仅在WiFi下缓存、仅在充电且WiFi下缓存、不缓存
enum CacheType {
  unspecified,
  enable,
  onlyUnderCharge,
  onlyUnderWiFi,
  onlyUnderChargeAndWiFi,
  disable
}

/// 布尔表达式选项：跟随全局设置、启用、禁用
enum BoolType { unspecified, enable, diable }

/// 同步状态：尚未同步、成功、失败
enum SyncStatus { unspecified, success, fail }

/// （全局）订阅源设置，包含文章抓取方式、文章列表布局、文章详情布局、文章详情头图显示选项、文章详情视频显示选项、拉取时是否下载图片、拉取时是否下载Web页面、阅读时是否下载Web页面、
///  软件启动时是否拉取、是否显示相关文章、是否显示图片标题、是否移除重复文章、滚动时是否自动标为已读、自动拉取频率
class FeedSetting {
  CrawlType? crawlType;
  ArticleListLayoutType? listLayoutType;
  ArticleDetailLayoutType? detailLayoutType;
  ArticleDetailHeadImageViewType? headImageViewType;
  ArticleDetailVideoViewType? videoViewType;
  MobilizerType? mobilizerType;
  CacheType? cacheImageTypeOnPull;
  CacheType? cacheWebTypeOnPull;
  CacheType? cacheWebTypeOnRead;
  CacheType? pullType;
  BoolType? pullOnStartUp;
  BoolType? autoTranslate;
  BoolType? showAiAbstract;
  BoolType? showRelatedArticles;
  BoolType? showImageAlt;
  BoolType? removeDuplicateArticles;
  BoolType? autoReadOnScroll;
  int? autoPullFrequency;

  FeedSetting({
    this.crawlType,
    this.listLayoutType,
    this.detailLayoutType,
    this.headImageViewType,
    this.videoViewType,
    this.mobilizerType,
    this.cacheImageTypeOnPull,
    this.cacheWebTypeOnPull,
    this.cacheWebTypeOnRead,
    this.pullType,
    this.pullOnStartUp,
    this.autoTranslate,
    this.showAiAbstract,
    this.showRelatedArticles,
    this.showImageAlt,
    this.removeDuplicateArticles,
    this.autoReadOnScroll,
    this.autoPullFrequency,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'crawlType': crawlType?.index,
        'listLayoutType': listLayoutType?.index,
        'detailLayoutType': detailLayoutType?.index,
        'headImageViewType': headImageViewType?.index,
        'videoViewType': videoViewType?.index,
        'mobilizerType': mobilizerType?.index,
        'cacheImageTypeOnPull': cacheImageTypeOnPull?.index,
        'cacheWebTypeOnPull': cacheWebTypeOnPull?.index,
        'cacheWebTypeOnRead': cacheWebTypeOnRead?.index,
        'pullType': pullType?.index,
        'pullOnStartUp': pullOnStartUp?.index,
        'autoTranslate': autoTranslate?.index,
        'showAiAbstract': showAiAbstract?.index,
        'showRelatedArticles': showRelatedArticles?.index,
        'showImageAlt': showImageAlt?.index,
        'removeDuplicateArticles': removeDuplicateArticles?.index,
        'autoReadOnScroll': autoReadOnScroll?.index,
        'autoPullFrequency': autoPullFrequency,
      };

  factory FeedSetting.fromJson(Map<String, dynamic> json) => FeedSetting(
        crawlType: json['crawlType'] != null
            ? CrawlType.values[json['crawlType']]
            : null,
        listLayoutType: json['listLayoutType'] != null
            ? ArticleListLayoutType.values[json['listLayoutType']]
            : null,
        detailLayoutType: json['detailLayoutType'] != null
            ? ArticleDetailLayoutType.values[json['detailLayoutType']]
            : null,
        headImageViewType: json['headImageViewType'] != null
            ? ArticleDetailHeadImageViewType.values[json['headImageViewType']]
            : null,
        videoViewType: json['videoViewType'] != null
            ? ArticleDetailVideoViewType.values[json['videoViewType']]
            : null,
        mobilizerType: json['mobilizerType'] != null
            ? MobilizerType.values[json['mobilizerType']]
            : null,
        cacheImageTypeOnPull: json['cacheImageTypeOnPull'] != null
            ? CacheType.values[json['cacheImageTypeOnPull']]
            : null,
        cacheWebTypeOnPull: json['cacheWebTypeOnPull'] != null
            ? CacheType.values[json['cacheWebTypeOnPull']]
            : null,
        cacheWebTypeOnRead: json['cacheWebTypeOnRead'] != null
            ? CacheType.values[json['cacheWebTypeOnRead']]
            : null,
        pullType: json['pullType'] != null
            ? CacheType.values[json['pullType']]
            : null,
        pullOnStartUp: json['pullOnStartUp'] != null
            ? BoolType.values[json['pullOnStartUp']]
            : null,
        showRelatedArticles: json['showRelatedArticles'] != null
            ? BoolType.values[json['showRelatedArticles']]
            : null,
        showImageAlt: json['showImageAlt'] != null
            ? BoolType.values[json['showImageAlt']]
            : null,
        removeDuplicateArticles: json['removeDuplicateArticles'] != null
            ? BoolType.values[json['removeDuplicateArticles']]
            : null,
        autoReadOnScroll: json['autoReadOnScroll'] != null
            ? BoolType.values[json['autoReadOnScroll']]
            : null,
        autoPullFrequency: json['autoPullFrequency'] as int?,
      );
}

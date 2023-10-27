enum SourceOpenTarget { local, fullContent, webpage, external }

///
/// Feed class, including ID, link, icon, name and other elements
///
class Feed {
  String id;
  String url;
  String? iconUrl;
  String name;
  SourceOpenTarget? openTarget;
  int? unreadCount;
  DateTime? latest;
  String? lastTitle;

  Feed(
    this.id,
    this.url,
    this.name, {
    this.iconUrl,
    this.openTarget,
    this.unreadCount,
    this.latest,
    this.lastTitle,
  }) {
    openTarget = SourceOpenTarget.local;
    latest = DateTime.now();
    unreadCount = 0;
    lastTitle = "";
  }

  Feed._privateConstructor(
    this.id,
    this.url,
    this.iconUrl,
    this.name,
    this.openTarget,
    this.unreadCount,
    this.latest,
    this.lastTitle,
  );

  Feed clone() {
    return Feed._privateConstructor(
      id,
      url,
      iconUrl,
      name,
      openTarget,
      unreadCount,
      latest,
      lastTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "sid": id,
      "url": url,
      "iconUrl": iconUrl,
      "name": name,
      "openTarget": openTarget?.index,
      "latest": latest?.millisecondsSinceEpoch,
      "lastTitle": lastTitle,
    };
  }

  Feed.fromMap(Map<String, dynamic> map)
      : id = map["sid"],
        url = map["url"],
        iconUrl = map["iconUrl"],
        name = map["name"],
        openTarget = SourceOpenTarget.values[map["openTarget"]],
        latest = DateTime.fromMillisecondsSinceEpoch(map["latest"]),
        lastTitle = map["lastTitle"],
        unreadCount = 0;
}

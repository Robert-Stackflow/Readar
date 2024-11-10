enum ActiveThemeMode { system, light, dark }

enum InitPhase {
  haveNotConnected,
  connecting,
  successful,
  failed;
}

enum TrayKey {
  displayApp("displayApp"),
  lockApp("lockApp"),
  setting("setting"),
  officialWebsite("officialWebsite"),
  githubRepository("githubRepository"),
  about("about"),
  launchAtStartup("launchAtStartup"),
  checkUpdates("checkUpdates"),
  shortcutHelp("shortcutHelp"),
  exitApp("exitApp");

  final String key;

  const TrayKey(this.key);
}

enum SideBarChoice {
  Feed("feed"),
  Star("star"),
  ReadLater("readLater"),
  Highlights("Highlights"),
  Saved("saved"),
  History("history"),
  Explore("explore");

  final String key;

  const SideBarChoice(this.key);

  static fromString(String string) {
    for (var value in SideBarChoice.values) {
      if (value.key == string) {
        return value;
      }
    }
    return SideBarChoice.Feed;
  }

  static fromInt(int index) {
    if (index < 0 || index >= SideBarChoice.values.length) {
      return SideBarChoice.Feed;
    }
    return SideBarChoice.values[index];
  }
}

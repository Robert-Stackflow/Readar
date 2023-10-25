class AutoLock {
  AutoLock({required this.label, required this.minutes});

  String label;
  int minutes;

  static List<String> optionLabels = [
    "立即锁定",
    "处于后台1分钟后锁定",
    "处于后台5分钟后锁定",
    "处于后台10分钟后锁定"
  ];

  static List<AutoLock> autoLockOptions = <AutoLock>[
    AutoLock(label: "立即锁定", minutes: 0),
    AutoLock(label: "处于后台1分钟后锁定", minutes: 1),
    AutoLock(label: "处于后台5分钟后锁定", minutes: 5),
    AutoLock(label: "处于后台10分钟后锁定", minutes: 10)
  ];
}

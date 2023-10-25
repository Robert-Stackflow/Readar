class ProtectionDataItem {
  ProtectionDataItem({
    required this.title,
    required this.description,
  });

  String title;
  String description;

  static List<ProtectionDataItem> protectionDataItems = [
    ProtectionDataItem(
        title: "本地差分隐私",
        description:
            "我们采用本地差分隐私技术保护您的隐私：\n当您选择在服务器存储个人数据时，我们将首先在本地（即在您的手机）使用本地差分隐私技术对敏感的个人数据进行噪声干扰处理，从而使得传输到服务器的数据不涉及真实敏感的数据。"),
    ProtectionDataItem(
        title: "强匿名与弱匿名",
        description:
            "我们采用两种匿名方式保护您的隐私：\n（1）如果您使用弱匿名方式发布信息，那么其他用户将无法知晓内容的发布者身份，而服务器将会以加密的方式存储发布者身份，并使您可以编辑、删除已发布的信息，同时会向您推送其他用户关于您所发布信息的评论、回答、点赞通知。\n\n（2）如果您使用强匿名方式发布信息，那么其他用户和服务器均将无法知晓内容的发布者身份，同时您将失去对信息的编辑、删除功能，并无法接收到其他用户关于您所发布信息的评论、回答、点赞通知。为保障其他用户的权益，我们将审核信息内容，及时删除不良内容。\n\n（3）特别地，为了避免滥用强匿名方式发布不良内容，我们将适时调整用户在短时间内使用强匿名方式发布内容的限制。"),
  ];

  static List<ProtectionDataItem> aboutDataItems = [
    ProtectionDataItem(
        title: "吞噬你心头的乌云",
        description:
            "在生活之中，总有各种令人不如意的事情，它们就像是一朵朵的乌云，遮蔽着天空中的太阳。这时，一只或是很多只噬云兽出现了，它帮助人们吞噬掉头顶的乌云，将自己的可爱与活泼带给世界。"),
  ];
}

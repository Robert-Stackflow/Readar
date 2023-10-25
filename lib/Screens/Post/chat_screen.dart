import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloudreader/Models/message_data.dart';
import 'package:cloudreader/Themes/theme.dart';
import 'package:cloudreader/api/openai_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

late int _maxId;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String routeName = "/chat";

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  int count = 0;
  bool _isTyping = false;
  late List<MessageData> _messages = <MessageData>[];
  late final List<MessageData> _newMessages = <MessageData>[];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();
    MessageData.maxId().then((value) => _maxId = (value) + 1);
    _controller.addListener(() {
      if (!mounted) return;
      setState(() {
        count = _controller.text.length;
      });
    });
    WidgetsBinding.instance.addObserver(this);
    MessageData.messages().then((value) {
      if (!mounted) return;
      setState(() {
        _messages = value;
        if (_messages.isNotEmpty) {
          _messages.add(
              MessageData(time: DateTime.now(), content: "以上为历史消息", sender: 2));
        }
        _sayHello();
      });
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPersistentFrameCallback(
      (_) {
        if (mounted) {
          if (MediaQuery.of(context).viewInsets.bottom == 0) {
          } else {
            scrollToBottom();
          }
        }
      },
    );
  }

  void _sayHello() {
    if (mounted) {
      setState(() {
        _isTyping = true;
        OpenAIRequest.sendMessageProxy("你好", <MessageData>[]).then((value) {
          setState(() {
            _isTyping = false;
            if (mounted) {
              setState(() {
                MessageData data = MessageData(
                  content: value,
                  sender: 1,
                  time: DateTime.now(),
                );
                _maxId++;
                data.id = _maxId;
                _messages.add(data);
              });
            }
            Future.delayed(const Duration(milliseconds: 300), () {
              scrollToBottom();
            });
          });
        });
      });
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollToBottom();
    });
  }

  void _send(String text) {
    if (mounted) {
      setState(() {
        MessageData data = MessageData(
          content: text,
          sender: 0,
          time: DateTime.now(),
        );
        MessageData.insertMessage(data);
        _maxId++;
        _messages.add(data);
        _newMessages.add(data);
        _isTyping = true;
        OpenAIRequest.moderationProxy(text).then((moderation) {
          String prefix = "";
          switch (moderation) {
            case Moderation.none:
              break;
            case Moderation.sexual:
              text = "我想聊性有关的东西。$text";
              prefix = "【话题与性相关】";
              break;
            case Moderation.selfharm:
              text = "我想聊伤害自己有关的东西。$text";
              prefix = "【话题与自我伤害相关】";
              break;
            case Moderation.hate:
              text = "我想聊仇恨有关的东西。$text";
              prefix = "【话题与仇恨歧视相关】";
              break;
            case Moderation.violence:
              text = "我想聊暴力有关的东西。$text";
              prefix = "【话题与暴力相关】";
              break;
          }
          OpenAIRequest.sendMessageProxy(text, _newMessages).then((value) {
            String temp = value;
            if (temp.contains("】")) {
              temp = temp.substring(temp.indexOf("】") + 1);
            }
            setState(() {
              _isTyping = false;
              _reply(moderation, prefix + temp);
            });
          });
        });
      });
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollToBottom();
    });
  }

  void _reply(Moderation moderation, String text) {
    if (mounted) {
      setState(() {
        MessageData data = MessageData(
          content: text,
          sender: 1,
          moderation: moderation,
          time: DateTime.now(),
        );
        MessageData.insertMessage(data);
        _maxId++;
        data.id = _maxId;
        _messages.add(data);
        _newMessages.add(data);
      });
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollToBottom();
    });
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'circle',
        child: Stack(
          children: <Widget>[
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _Message(
                    data: _messages[index],
                    bottomMargin: index == _messages.length - 1);
              },
            ),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 4.0),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLines: 5,
                        minLines: 1,
                        autofocus: true,
                        cursorColor: AppTheme.themeColor,
                        cursorHeight: 22,
                        cursorRadius: const Radius.circular(3),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '输入消息',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () {
                        if (_isTyping) return;
                        String text = _controller.text.trim();
                        if (text.isNotEmpty) {
                          _send(text);
                          _controller.clear();
                        }
                      },
                      child: _isTyping
                          ? const SpinKitThreeBounce(
                              color: AppTheme.themeColor,
                              size: 18,
                            )
                          : Container(
                              alignment: Alignment.bottomCenter,
                              margin: const EdgeInsets.only(right: 5),
                              child: const Icon(
                                Icons.send_rounded,
                                color: AppTheme.themeColor,
                                size: 24,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final MessageData data;
  final bool bottomMargin;

  const _Message({
    required this.data,
    this.bottomMargin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: data.sender == 0
          ? _myMessage()
          : (data.sender == 1 ? _yourMessage() : _systemMessage()),
    );
  }

  Widget _systemMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 1,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            data.content,
            style: TextStyle(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 1,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _myMessage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                margin: const EdgeInsets.only(left: 70),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: const BoxDecoration(
                  color: AppTheme.themeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  ),
                ),
                child: SelectableText(
                  data.content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomMargin ? const SizedBox(height: 70) : const SizedBox(),
      ],
    );
  }

  Widget _yourMessage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                margin: const EdgeInsets.only(right: 70),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: _maxId == data.id
                    ? AnimatedTextKit(
                        isRepeatingAnimation: false,
                        repeatForever: false,
                        displayFullTextOnTap: true,
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            data.content,
                            textStyle: TextStyle(
                              color: data.moderation != Moderation.none
                                  ? Colors.red
                                  : AppTheme.darkerText,
                              fontSize: 16,
                            ),
                            speed: Duration(
                                milliseconds: (_maxId == data.id) ? 80 : 0),
                          ),
                        ],
                      )
                    : SelectableText(
                        data.content,
                        style: TextStyle(
                          color: data.moderation != Moderation.none
                              ? Colors.red
                              : AppTheme.darkerText,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
        bottomMargin ? const SizedBox(height: 70) : const SizedBox(),
      ],
    );
  }
}

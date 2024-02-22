// import 'package:dash_chat/dash_chat.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
// import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdchat/common/widgets/custom_app_Bar.dart';
import 'package:sendbirdchat/data/repos/messages.dart';
import 'package:sendbirdchat/utils/constants/colors.dart';
import 'package:sendbirdchat/common/widgets/custom_dialog.dart';

class ChatScreen extends StatefulWidget {
  final String appId;
  final String userId;
  final List<String> otherUserId;
  const ChatScreen({
    super.key,
    required this.appId,
    required this.userId,
    required this.otherUserId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with ChannelEventHandler {
  TextEditingController textEditingController = TextEditingController();
  List<BaseMessage> _messages = [];
  String? currentUserName;
  bool isloading = true;
  String state = 'loading';
  String? errorMessage;
  void load() async {
    //init + connect
    try {
      final sendbird = await SendbirdSdk(appId: widget.appId);
      print(sendbird);
      print('-------------------------');
      final user = await SendbirdSdk().connect(widget.userId);
      print(user);
      currentUserName = user?.nickname;
      print('${user?.nickname}----------------+++++');
      //  user.userId
      //get any existing channel
      /* final query = await OpenChannelListQuery()
        ..limit = 1;
      List<OpenChannel> channels = await query.next();
      //create a new channel
      OpenChannel openChannell;
      if (channels.length == 0) {
        openChannell =
            await OpenChannel.createChannel(OpenChannelCreateParams());
      }*/
      //already created
      final openChannel = await OpenChannel.getChannel(
          "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211");
      await openChannel.enter();
      // get a messages from channel
      List<BaseMessage> messages = await openChannel.getMessagesByTimestamp(
          DateTime.now().microsecondsSinceEpoch * 1000, MessageListParams());

      setState(() {
        _messages = messages;
        isloading = false;
        state = 'start';
        print(_messages);
      });
    } catch (e) {
      print('===================');
      state = 'error';
      errorMessage = e.toString();
      MsgDialog.showMsgDialog(
        context: this.context,
        title: 'Eception occured',
        msg: e.toString(),
      );
      print(e);
    }
  }

  postMessage(String baseMessage) async {
    try {
      final openChannel = await OpenChannel.getChannel(
          "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211");
      await openChannel.enter();
      openChannel.sendUserMessageWithText(baseMessage);
    } catch (e) {
      print(e);
    }
  }

  loadMoreMessages() async {
    final openChannel = await OpenChannel.getChannel(
        "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211");
    await openChannel.enter();
    // get a messages from channel
    List<BaseMessage> messages = await openChannel.getMessagesByTimestamp(
      DateTime.now().microsecondsSinceEpoch * 1000,
      MessageListParams(),
    );

    setState(() {
      _messages = messages;
      print(_messages);
    });
    return;
  }

  @override
  void initState() {
    SendbirdSdk().addChannelEventHandler('chat', this);
    load();
    super.initState();
  }

  @override
  void dispose() {
    SendbirdSdk().removeConnectionEventHandler('chat');
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    // You can customize how to display different types of messages with the result object in the message parameter.
    if (message is UserMessage) {
      setState(() {
        _messages.add(message);
      });
      // ...
    } else if (message is FileMessage) {
      // ...
    } else if (message is AdminMessage) {
      // ...
    }
  }

  ChatUser asDashChatUser(User? user) {
    if (user == null) {
      return ChatUser(
        id: '',
        firstName: '',
        lastName: '',
        profileImage: '',
      );
    }
    return ChatUser(
        id: user.userId,
        firstName: user.nickname,
        profileImage: user.profileUrl);
  }

  List<ChatMessage> asDashChatMessage(List<BaseMessage> messages) {
    return [
      for (BaseMessage sbm in messages)
        ChatMessage(
            user: asDashChatUser(sbm.sender),
            createdAt:
                DateTime.fromMillisecondsSinceEpoch(sbm.createdAt * 1000),
            text: sbm.message)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(
            iconData: Icons.arrow_back_ios_new,
            title: currentUserName ?? '',
            onLeadingBtnPressed: () {},
            onRearBtnPressed: () {}),
      ),
      body: state == 'start'
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: DashChat(
                scrollToBottomOptions: ScrollToBottomOptions(
                  onScrollToBottomPress: () async {
                    await loadMoreMessages();
                  },
                ),

                // messageListOptions: ,

                messageListOptions: const MessageListOptions(
                  showDateSeparator: true,

                  // onLoadEarlier: loadMoreMessages(),
                ),
                messageOptions: MessageOptions(
                  // messageTextBuilder:(ChatMessage chatmessage) =>Text(''),
                  // containerColor: Theme.of(context).dividerColor.withOpacity(0.4),

                  /*   messageDecorationBuilder: (message, previousMessage, nextMessage) =>
                const BoxDecoration(
              // color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(20),
                left: Radius.circular(5),
              ),

              // borderRadius: BorderRadius.horizontal(left: 10, right: 20),
            ),*/
                  showTime: true,
                  // messageTimeBuilder: (ChatMessage chatMessage, bool k) => Text('2d'),
                  timeFormat: DateFormat.MEd(),
                  textColor: AppColor.lightTxtColor,
                  containerColor: Colors.grey.withOpacity(0.5),
                  currentUserContainerColor: AppColor.primaryBtnColor,
                  currentUserTextColor: AppColor.lightTxtColor,
                ),

                inputOptions: InputOptions(
                  textController: textEditingController,
                  sendButtonBuilder: (void fnction) => const Icon(
                    Icons.arrow_upward,
                    size: 0,
                    color: Colors.transparent,
                  ),
                  alwaysShowSend: false,
                  leading: [
                    Icon(
                      Icons.add,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    )
                  ],
                  // trailing: [Icon(Icons.arrow_upward)],
                  onTextChange: (val) {
                    setState(() {
                      textEditingController.text = val;
                    });
                  },

                  inputDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffixIconConstraints:
                          const BoxConstraints(maxHeight: 35, maxWidth: 35),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CircleAvatar(
                          backgroundColor: textEditingController.text.isNotEmpty
                              ? AppColor.primaryBtnColor
                              : Theme.of(context).dividerColor,
                          child: FittedBox(
                            child: IconButton(
                              onPressed: () async {
                                if (textEditingController.text.isNotEmpty) {
                                  postMessage(textEditingController.text);
                                  textEditingController.clear();
                                  load();
                                }
                              },
                              icon: Icon(
                                Icons.arrow_upward,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.color,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
                messages: asDashChatMessage(_messages),
                currentUser: asDashChatUser(SendbirdSdk().currentUser),
                onSend: (newMessage) async {
                  // _messages.add(
                  //   BaseMessage(
                  //       isPinnedMessage: false,
                  //       message: newMessage.text,
                  //       sendingStatus: MessageSendingStatus.succeeded,
                  //       channelUrl:
                  //           'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211',
                  //       channelType: ChannelType.open),
                  // );
                },
              ),
            )
          : state == 'loading'
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryBtnColor,
                  ),
                )
              : Center(
                  child: Text(
                    errorMessage ?? '',
                  ),
                ),
    );
  }
}

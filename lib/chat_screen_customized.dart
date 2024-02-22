import 'package:flutter/material.dart';
import 'package:sendbird_sdk/managers/event_manager.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import 'common/widgets/custom_app_Bar.dart';
import 'common/widgets/flixible_textfield.dart';
import 'utils/constants/colors.dart';

class ChatPageUp extends StatefulWidget {
  final String appId;
  final String userId;
  final List<String> otherUserId;
  const ChatPageUp({
    super.key,
    required this.appId,
    required this.userId,
    required this.otherUserId,
  });

  @override
  State<ChatPageUp> createState() => _ChatPageUpState();
}

class _ChatPageUpState extends State<ChatPageUp> with ChannelEventHandler {
  TextEditingController textEditingController = TextEditingController();
  List<BaseMessage> _messages = [];
  GroupChannel? _channel;

  void load() async {
    //init + connect
    try {
      final sendbird = await SendbirdSdk(appId: widget.appId);
      print(sendbird);
      print('-------------------------');
      final user = await SendbirdSdk().connect(widget.userId);
      print(user);
      print('${user.userId}----------------+++++');
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
          DateTime.now().millisecondsSinceEpoch * 1000, MessageListParams());

      setState(() {
        _messages = messages;
        print(messages);
      });
    } catch (e) {
      print('===================');
      print(e);
    }
  }

  @override
  void initState() {
    SendbirdSdk().addChannelEventHandler('chat', this);
    load();
    super.initState();
  }

  @override
  void dispose() {
    SendbirdSdk().removeChannelEventHandler('chat');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(
          onLeadingBtnPressed: () {},
          onRearBtnPressed: () {},
          title: widget.appId,
          iconData: Icons.arrow_back,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(
              // keyboard height
              bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.transparent,
                    ),
                    itemCount: _messages.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Align(
                        alignment:
                            _messages[index].sender?.userId != widget.userId ||
                                    _messages[index].sender?.userId == null
                                ? Alignment.bottomLeft
                                : Alignment.centerRight,
                        child: _messages[index].sender?.userId !=
                                    widget.userId ||
                                _messages[index].sender?.userId == null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child:
                                        _messages[index].sender?.profileUrl !=
                                                null
                                            ? Image.network(
                                                _messages[index]
                                                        .sender
                                                        ?.profileUrl ??
                                                    '',
                                                fit: BoxFit.scaleDown,
                                              )
                                            : Image.asset(
                                                'assets/profile_placeholder.png',
                                                fit: BoxFit.scaleDown,
                                              ),
                                  )),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: _messages[index].sender?.userId !=
                                                  widget.userId ||
                                              _messages[index].sender?.userId ==
                                                  null
                                          ? AppColor.primaryBtnColor
                                          : Theme.of(context)
                                              .dividerColor
                                              .withOpacity(0.5),
                                      borderRadius: BorderRadius.horizontal(
                                        left: _messages[index].sender?.userId !=
                                                    widget.userId ||
                                                _messages[index]
                                                        .sender
                                                        ?.userId ==
                                                    null
                                            ? const Radius.circular(30)
                                            : const Radius.circular(10),
                                        right:
                                            _messages[index].sender?.userId !=
                                                        widget.userId ||
                                                    _messages[index]
                                                            .sender
                                                            ?.userId ==
                                                        null
                                                ? const Radius.circular(10)
                                                : const Radius.circular(30),
                                      ),
                                    ),
                                    // width: MediaQuery.of(context).size.width * 0.7,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        // RichText(
                                        //   text: InlineSpan([

                                        //   ]),
                                        // ),
                                        Text(
                                          _messages[index].sender?.nickname ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        Text(
                                          // DateFormat.jm().format(_rootMessages[index].createdAt) ??
                                          _messages[index].message ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container()),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.94,
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Container(
                        // color: Colors.green,
                        // height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        padding: const EdgeInsets.all(3),
                        child: Center(
                          child: FlexibleTextField(
                            textEditingController: textEditingController,
                            textInputAction: TextInputAction.none,
                            keyboardType: TextInputType.text,
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_upward,
                                // color: textEditingController.text.isNotEmpty
                                //     ? AppColor.primaryBtnColor
                                //     : const Color(0xfff1f1f1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyOpenChannelHandler extends ChannelEventHandler {
  // Add this object through SendbirdChat.addChannelHandler('UNIQUE_HANDLER_ID', this).
  // Or remove it through SendbirdChat.removeChannelHandler('UNIQUE_HANDLER_ID') when it's no longer needed.

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    // You can customize how to display different types of messages with the result object in the message parameter.
    if (message is UserMessage) {
      // ...
    } else if (message is FileMessage) {
      // ...
    } else if (message is AdminMessage) {
      // ...
    }
  }
}

// class MyGroupChannelHandler extends GroupChannelHandler {
//   // ...
// }
import 'package:flutter/material.dart';
// import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:sendbirdchat/chat_screen.dart';
import 'package:sendbirdchat/utils/constants/colors.dart';
import 'chat_screen_customized.dart';
import 'common/widgets/custom_app_Bar.dart';
import 'common/widgets/flixible_textfield.dart';
import 'data/repos/messages.dart';
import 'utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThem,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      // home: const ChatScreen(),
      // home: HomePage(),
      home: const ChatScreen(
        appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF',
        userId: 'f93b05ff359245af400aa805bafd2a091a173064',
        otherUserId: [],
      ),
      // const ChatPageUp(
      //   appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF',
      //   userId: 'f93b05ff359245af400aa805bafd2a091a173064',
      //   otherUserId: [],
      // ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   HomePage({super.key});
//   TextEditingController textEditingController = TextEditingController();

//   Future<bool> initSendBird() async {
//     return await SendbirdChat.init(
//         appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF');
//   }

//   Future<User> connectToSendbird() async {
//     final user =
//         await SendbirdChat.connect('f93b05ff359245af400aa805bafd2a091a173064');
//     //  user.userId
//     //get any existing channel

//     //create a new channel

//     // get a messages from channel
//     return user;
//   }

//   retrieveMessage() async {
//     try {
//       // Create a MessageRetrievalParams object.
//       final params = MessageRetrievalParams(
//         channelType: ChannelType.open,
//         channelUrl: 'CHANNEL_URL',
//         messageId: 5,
//       );

//       // Pass the params to the parameter of the getMessage() method.
//       final message = await BaseMessage.getMessage(params);
//       print(message);
//       // The specified message is successfully retrieved.
//     } catch (e) {
//       print(e);
//       // Handle error.
//     }
//   }

//   getMessageSent() {
//     SendbirdChat.addChannelHandler('UNIQUE_HANDLER_ID', MyOpenChannelHandler());
//   }

//   void createChannel() async {
//     //Create a new open channel - any user can send message withou invitation
//     final openChannel =
//         await OpenChannel.createChannel(OpenChannelCreateParams());
//     // Enter the channel
//     print(openChannel);
//     String channelUrl =
//         'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211';
//     final getOpenChannel = await OpenChannel.getChannel(channelUrl);
//     await getOpenChannel.enter();
//     // Send a message to the channel- 'message'
//     getOpenChannel.sendUserMessage(UserMessageCreateParams(message: 'MESSAGE'));
//   }

//   void sendMessageToChannel() {}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(56),
//         child: CustomAppBar(
//           onLeadingBtnPressed: () {},
//           onRearBtnPressed: () {},
//           title: 'name',
//           iconData: Icons.arrow_back,
//         ),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Padding(
//           padding: const EdgeInsets.only(
//               // keyboard height
//               bottom: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ListView.separated(
//                     separatorBuilder: (BuildContext context, int index) =>
//                         const Divider(
//                       color: Colors.transparent,
//                     ),
//                     itemCount: messages.length,
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: (BuildContext context, int index) => Align(
//                       alignment: !messages[index].isSentByMe
//                           ? Alignment.bottomLeft
//                           : Alignment.centerRight,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: messages[index].isSentByMe
//                               ? AppColor.primaryBtnColor
//                               : Theme.of(context).dividerColor,
//                           borderRadius: BorderRadius.horizontal(
//                             left: messages[index].isSentByMe
//                                 ? const Radius.circular(30)
//                                 : const Radius.circular(10),
//                             right: messages[index].isSentByMe
//                                 ? const Radius.circular(10)
//                                 : const Radius.circular(30),
//                           ),
//                         ),
//                         // width: MediaQuery.of(context).size.width * 0.7,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 4),
//                         child: FittedBox(
//                           child: Column(
//                             children: [
//                               Text(
//                                 messages[index].name,
//                                 style: Theme.of(context).textTheme.titleLarge,
//                               ),
//                               Text(
//                                 messages[index].message,
//                                 style:
//                                     Theme.of(context).textTheme.headlineMedium,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.08,
//                 width: MediaQuery.of(context).size.width * 0.94,
//                 color:
//                     Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.14,
//                       child: FittedBox(
//                         fit: BoxFit.scaleDown,
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.add,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Flexible(
//                       child: Container(
//                         // color: Colors.green,
//                         // height: MediaQuery.of(context).size.height * 0.08,
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(18),
//                           border: Border.all(
//                             color: Theme.of(context).dividerColor,
//                           ),
//                         ),
//                         padding: const EdgeInsets.all(3),
//                         child: Center(
//                           child: FlexibleTextField(
//                             textEditingController: textEditingController,
//                             textInputAction: TextInputAction.none,
//                             keyboardType: TextInputType.text,
//                             suffixIcon: IconButton(
//                               onPressed: () {},
//                               icon: const Icon(
//                                 Icons.arrow_upward,
//                                 // color: textEditingController.text.isNotEmpty
//                                 //     ? AppColor.primaryBtnColor
//                                 //     : const Color(0xfff1f1f1),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 3,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyOpenChannelHandler extends OpenChannelHandler {
//   @override
//   void onMessageReceived(BaseChannel channel, BaseMessage message) {
//     // Received a new message.
//   }
// }

class ChatMessages {
  final String message;
  final String name;
  final String avatar;
  final bool isSentByMe;
  final bool isOnline;
  final DateTime date;

  ChatMessages(
      {required this.message,
      required this.isSentByMe,
      required this.date,
      required this.avatar,
      required this.name,
      required this.isOnline});
}

List<ChatMessages> messages = [
  ChatMessages(
      date: DateTime.now(),
      isSentByMe: false,
      isOnline: true,
      name: 'name',
      avatar: 'avater',
      message: 'Hi There'),
  ChatMessages(
      date: DateTime.now(),
      isSentByMe: true,
      isOnline: false,
      name: 'name',
      avatar: 'avater',
      message: 'I am fine'),
  ChatMessages(
      date: DateTime.now(),
      isSentByMe: false,
      isOnline: false,
      name: 'name',
      avatar: 'avater',
      message: 'Where are you'),
  ChatMessages(
      date: DateTime.now(),
      isSentByMe: false,
      isOnline: true,
      name: 'name',
      avatar: 'avater',
      message: 'Office'),
  ChatMessages(
      date: DateTime.now(),
      isSentByMe: true,
      isOnline: false,
      name: 'name',
      avatar: 'avater',
      message: 'nop'),
];

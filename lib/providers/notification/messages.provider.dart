import 'package:flutter_riverpod/flutter_riverpod.dart';

class Message {
  final String createdAt;
  final String author;
  final String content;
  final bool isInterview;
  final String titleInterview;
  final String startTimeInterview;
  final String endTimeInterview;
  final String idInterview;
  final int disableFlag;
  final String meetingRoomCode;

  Message({
    required this.createdAt,
    required this.author,
    required this.content,
    required this.isInterview,
    required this.titleInterview,
    required this.startTimeInterview,
    required this.endTimeInterview,
    required this.idInterview,
    required this.disableFlag,
    required this.meetingRoomCode,
  });

  Message.fromJson(Map<dynamic, dynamic> json)
      : createdAt = json['createdAt'],
        author = json['author'],
        content = json['content'],
        isInterview = json['isInterview'],
        titleInterview = json['titleInterview'],
        startTimeInterview = json['startTimeInterview'],
        endTimeInterview = json['endTimeInterview'],
        idInterview = json['idInterview'],
        disableFlag = json['disableFlag'],
        meetingRoomCode = json['meetingRoomCode'];

  Map<dynamic, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'author': author,
      'content': content,
      'isInterview': isInterview,
      'titleInterview': titleInterview,
      'startTimeInterview': startTimeInterview,
      'endTimeInterview': endTimeInterview,
      'idInterview': idInterview,
      'disableFlag': disableFlag,
      'meetingRoomCode': meetingRoomCode,
    };
  }
}

class MessageNotifier extends StateNotifier<List<Message>> {
  MessageNotifier() : super([]);

  void pushMessageData(
    String createdAt,
    String author,
    String content,
    bool isInterview,
    String titleInterview,
    String startTimeInterview,
    String endTimeInterview,
    String idInterview,
    int disableFlag,
    String meetingRoomCode,
  ) {
    state = [
      ...state,
      Message(
        createdAt: createdAt,
        author: author,
        content: content,
        isInterview: isInterview,
        titleInterview: titleInterview,
        startTimeInterview: startTimeInterview,
        endTimeInterview: endTimeInterview,
        idInterview: idInterview,
        disableFlag: disableFlag,
        meetingRoomCode: meetingRoomCode,
      )
    ];
  }

  void clearMessageData() {
    state = [];
  }
}

final messageProvider = StateNotifierProvider<MessageNotifier, List<Message>>((ref) => MessageNotifier());

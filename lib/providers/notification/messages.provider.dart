import 'package:flutter_riverpod/flutter_riverpod.dart';

class Message {
  final String createdAt;
  final String author;
  final String content;
  final bool isInterview;

  Message({
    required this.createdAt,
    required this.author,
    required this.content,
    required this.isInterview,
  });

  Message.fromJson(Map<dynamic, dynamic> json)
      : createdAt = json['createdAt'],
        author = json['author'],
        content = json['content'],
        isInterview = json['isInterview'];

  Map<dynamic, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'author': author,
      'content': content,
      'isInterview': isInterview,
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
  ) {
    state = [
      ...state,
      Message(
        createdAt: createdAt,
        author: author,
        content: content,
        isInterview: isInterview,
      )
    ];
  }

  void clearMessageData() {
    state = [];
  }
}

final messageProvider = StateNotifierProvider<MessageNotifier, List<Message>>((ref) => MessageNotifier());

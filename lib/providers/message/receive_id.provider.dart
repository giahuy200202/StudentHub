import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo/models/option.dart';

class ReceiveIdNotifier extends StateNotifier<String> {
  ReceiveIdNotifier() : super('');

  bool setReceiveId(String id) {
    state = id;
    return true;
  }
}

final receiveIdProvider = StateNotifierProvider<ReceiveIdNotifier, String>((ref) {
  return ReceiveIdNotifier();
});

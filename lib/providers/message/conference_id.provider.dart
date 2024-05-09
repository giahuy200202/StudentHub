import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo/models/option.dart';

class ConferenceIdNotifier extends StateNotifier<String> {
  ConferenceIdNotifier() : super('');

  bool setConferenceId(String id) {
    state = id;
    return true;
  }
}

final conferenceIdProvider = StateNotifierProvider<ConferenceIdNotifier, String>((ref) {
  return ConferenceIdNotifier();
});

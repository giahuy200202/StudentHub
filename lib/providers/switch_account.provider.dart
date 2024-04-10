import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo/models/option.dart';

class SwitchAccountNotifier extends StateNotifier<String> {
  SwitchAccountNotifier() : super('');

  bool setSwitchAccount(String switchOption) {
    state = switchOption;
    return true;
  }
}

final switchAccountProvider = StateNotifierProvider<SwitchAccountNotifier, String>((ref) {
  return SwitchAccountNotifier();
});

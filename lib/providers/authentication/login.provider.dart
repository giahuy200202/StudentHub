import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLoginNotifier extends StateNotifier<String> {
  UserLoginNotifier() : super('');

  void setRole(String value) {
    state = value;
  }
}

final userLoginProvider = StateNotifierProvider<UserLoginNotifier, String>(
    (ref) => UserLoginNotifier());

import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  int? id;
  String? role;
  String? token;

  User({
    this.id,
    this.role,
    this.token,
  });
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(id: 0, role: '', token: ''));

  void setUserData(int id, String role, String token) {
    User temp = User(
      id: state.id,
      role: state.role,
      token: state.token,
    );
    temp.id = id;
    temp.role = role;
    temp.token = token;
    state = temp;
  }

  void setRole(String role) {
    User temp = User(
      id: state.id,
      role: state.role,
      token: state.token,
    );
    temp.role = role;
    state = temp;
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());

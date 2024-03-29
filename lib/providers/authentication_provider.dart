import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  int? id;
  String? name;
  String? role;
  String? token;
  int? roleId;

  User({
    this.id,
    this.name,
    this.role,
    this.token,
    this.roleId,
  });
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(id: 0, name: '', role: '', token: '', roleId: 0));

  void setUserData(int id, String name, String role, String token, int roleId) {
    User temp = User(
      id: state.id,
      name: state.name,
      role: state.role,
      token: state.token,
      roleId: state.roleId,
    );
    temp.id = id;
    temp.name = name;
    temp.role = role;
    temp.token = token;
    temp.roleId = roleId;
    state = temp;
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());

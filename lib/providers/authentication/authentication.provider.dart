import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  int? id;
  String? role;
  String? token;
  String? fullname;

  User({this.id, this.role, this.token, this.fullname});
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(
          User(
            id: 0,
            role: '',
            token: '',
            fullname: '',
          ),
        );

  void setUserData(
    int id,
    String role,
    String token,
    String fullname,
  ) {
    User temp = User(
      id: state.id,
      role: state.role,
      token: state.token,
      fullname: state.fullname,
    );
    temp.id = id;
    temp.role = role;
    temp.token = token;
    temp.fullname = fullname;
    state = temp;
  }

  void setRole(String role) {
    User temp = User(
      id: state.id,
      role: state.role,
      token: state.token,
      fullname: state.fullname,
    );
    temp.role = role;
    state = temp;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());

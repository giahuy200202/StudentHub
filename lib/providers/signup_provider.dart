import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSignup {
  int? role;
  String? fullname;
  String? email;
  String? password;

  UserSignup({
    this.role,
    this.fullname,
    this.email,
    this.password,
  });
}

class UserSignupNotifier extends StateNotifier<UserSignup> {
  UserSignupNotifier()
      : super(UserSignup(role: 0, fullname: '', email: '', password: ''));

  void setRole(int value) {
    UserSignup temp = UserSignup(
      role: state.role,
      fullname: state.fullname,
      email: state.email,
      password: state.password,
    );
    temp.role = value;
    state = temp;
  }
}

final userSignupProvider =
    StateNotifierProvider<UserSignupNotifier, UserSignup>(
        (ref) => UserSignupNotifier());

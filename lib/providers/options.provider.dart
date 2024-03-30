import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo/models/option.dart';

enum Option { widgetOption }

class OptionsNotifier extends StateNotifier<Map<Option, String>> {
  OptionsNotifier() : super({Option.widgetOption: ''});

  bool setWidgetOption(String option, String role) {
    print(role);
    if (role == '') {
      if (option == 'Login' ||
          option == 'Dashboard' ||
          option == 'SignupStep1' ||
          option == 'SignupStep2') {
        state = {
          ...state,
          Option.widgetOption: option,
        };
      } else {
        state = {
          ...state,
          Option.widgetOption: '',
        };
      }
    } else {
      state = {
        ...state,
        Option.widgetOption: option,
      };
    }
    return true;
  }

  // bool setWidgetOption(String option) {
  //   state = {
  //     ...state,
  //     Option.widgetOption: option,
  //   };

  //   return true;
  // }
}

final optionsProvider =
    StateNotifierProvider<OptionsNotifier, Map<Option, String>>((ref) {
  return OptionsNotifier();
});

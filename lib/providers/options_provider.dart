import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo/models/option.dart';

enum Option { widgetOption }

class OptionsNotifier extends StateNotifier<Map<Option, String>> {
  OptionsNotifier() : super({Option.widgetOption: ''});

  bool setWidgetOption(String option) {
    state = {
      ...state,
      Option.widgetOption: option,
    };
    return true;
  }

  // bool setWidgetOptionForBottomNavBar(int index) {
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

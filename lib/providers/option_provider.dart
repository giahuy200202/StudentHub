import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo/models/option.dart';

enum Option { categoryOption }

class OptionsNotifier extends StateNotifier<Map<Option, String>> {
  OptionsNotifier() : super({Option.categoryOption: ''});

  bool setCategoryOption(String option) {
    state = {
      ...state,
      Option.categoryOption: option,
    };
    return true;
  }
}

final optionsProvider =
    StateNotifierProvider<OptionsNotifier, Map<Option, String>>((ref) {
  return OptionsNotifier();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectmonthProvider = StateNotifierProvider<SelectedMonthNotifier, int>(
    (ref) => SelectedMonthNotifier());

class SelectedMonthNotifier extends StateNotifier<int> {
  SelectedMonthNotifier() : super(0);

  void selectMonth(int value) {
    state = value;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedEmployeeProvider =
    StateNotifierProvider<SelectedEmployeeNotifier, int>(
        (ref) => SelectedEmployeeNotifier());

class SelectedEmployeeNotifier extends StateNotifier<int> {
  SelectedEmployeeNotifier() : super(0);

  void selectEmployee(int value) {
    state = value;
  }
}

final TextCompanyEmployeeProvider =
    StateNotifierProvider<TextCompanyEmployeeNotifier, String>(
        (ref) => TextCompanyEmployeeNotifier());

class TextCompanyEmployeeNotifier extends StateNotifier<String> {
  TextCompanyEmployeeNotifier() : super('');

  void TextCompanye(String value) {
    state = value;
  }
}

final TextDescriptionEmpoyleeProvider =
    StateNotifierProvider<TextDescriptionEmpoyleeNotifier, String>(
        (ref) => TextDescriptionEmpoyleeNotifier());

class TextDescriptionEmpoyleeNotifier extends StateNotifier<String> {
  TextDescriptionEmpoyleeNotifier() : super('');

  void TextDescriptione(String value) {
    state = value;
  }
}

final TextWebsiteEmpoyleeProvider =
    StateNotifierProvider<TextWebsiteEmpoyleeNotifier, String>(
        (ref) => TextWebsiteEmpoyleeNotifier());

class TextWebsiteEmpoyleeNotifier extends StateNotifier<String> {
  TextWebsiteEmpoyleeNotifier() : super('');

  void TextWebsitee(String value) {
    state = value;
  }
}

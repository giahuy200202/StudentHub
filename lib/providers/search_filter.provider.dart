import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchFilter {
  String? search;
  int? projectLength;
  String? numOfStudents;
  String? proposals;

  SearchFilter({
    this.search,
    this.projectLength,
    this.numOfStudents,
    this.proposals,
  });
}

class SearchFilterNotifier extends StateNotifier<SearchFilter> {
  SearchFilterNotifier()
      : super(SearchFilter(
          search: '',
          projectLength: -1,
          numOfStudents: '',
          proposals: '',
        ));

  void setSearch(String value) {
    SearchFilter temp = SearchFilter(
      search: state.search,
      projectLength: state.projectLength,
      numOfStudents: state.numOfStudents,
      proposals: state.proposals,
    );
    temp.search = value;
    state = temp;
  }

  void setProjectLength(int value) {
    SearchFilter temp = SearchFilter(
      search: state.search,
      projectLength: state.projectLength,
      numOfStudents: state.numOfStudents,
      proposals: state.proposals,
    );
    temp.projectLength = value;
    state = temp;
    // print(state.projectLength);
  }

  void setNumOfStudents(String value) {
    SearchFilter temp = SearchFilter(
      search: state.search,
      projectLength: state.projectLength,
      numOfStudents: state.numOfStudents,
      proposals: state.proposals,
    );
    temp.numOfStudents = value;
    state = temp;
  }

  void setProposals(String value) {
    SearchFilter temp = SearchFilter(
      search: state.search,
      projectLength: state.projectLength,
      numOfStudents: state.numOfStudents,
      proposals: state.proposals,
    );
    temp.proposals = value;
    state = temp;
  }
}

final searchFilterProvider = StateNotifierProvider<SearchFilterNotifier, SearchFilter>((ref) => SearchFilterNotifier());

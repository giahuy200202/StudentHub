import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';
import 'package:studenthub/providers/profile/student.provider.dart';
import 'package:studenthub/providers/projects/project_id.provider.dart';
import 'package:studenthub/providers/projects/search_filter.provider.dart';
import '../../providers/projects/project_posting.provider.dart';
// import '../../providers/options_provider.dart';
import 'package:studenthub/providers/language/language.provider.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Project {
  final String id;
  final String title;
  final String createTime;
  final int projectScopeFlag;
  final int numberOfStudents;
  final String description;
  final int countProposals;
  final bool isFavorite;

  Project({
    required this.id,
    required this.title,
    required this.createTime,
    required this.projectScopeFlag,
    required this.numberOfStudents,
    required this.description,
    required this.countProposals,
    required this.isFavorite,
  });

  Project.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        title = json['title'],
        createTime = json['createdAt'],
        projectScopeFlag = json['projectScopeFlag'],
        numberOfStudents = json['numberOfStudents'],
        description = json['description'],
        countProposals = json['countProposals'],
        isFavorite = json['isFavorite'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createTime,
      'projectScopeFlag': projectScopeFlag,
      'numberOfStudents': numberOfStudents,
      'description': description,
      'countProposals': countProposals,
      'isFavorite': isFavorite,
    };
  }
}

class LabeledRadio<T> extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.textColor,
  }) : super(key: key);

  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          DefaultTextStyle(
            style: TextStyle(color: textColor, fontSize: 16),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}

class ProjectSearchWidget extends ConsumerStatefulWidget {
  const ProjectSearchWidget({super.key});

  @override
  ConsumerState<ProjectSearchWidget> createState() {
    return _ProjectSearchWidgetState();
  }
}

class _ProjectSearchWidgetState extends ConsumerState<ProjectSearchWidget> {
  var searchController = TextEditingController();
  var numOfStudentsController = TextEditingController();
  var proposalsController = TextEditingController();
  bool enable = false;

  // @override
  // void dispose() {
  //   searchController.dispose();
  //   super.dispose();
  // }

  List<Project> listProjectsSearch = [];
  bool isFetchingData = false;

  void showErrorToast(title, description) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: Text(
        description,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  void showSuccessToast(title, description) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      description: Text(
        description,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  void getProjects(token, searchFilter, tmp) async {
    setState(() {
      isFetchingData = true;
    });

    String titleParam = searchFilter.search != null && searchFilter.search != '' ? 'title=${searchFilter.search}&' : '';
    String projectScopeFlagParam = searchFilter.projectLength != null && searchFilter.projectLength != -1 ? 'projectScopeFlag=${searchFilter.projectLength}&' : '';
    String numberOfStudentsParam = searchFilter.numOfStudents != null && searchFilter.numOfStudents != '' ? 'numberOfStudents=${searchFilter.numOfStudents}&' : '';
    String proposalsLessThanParam = searchFilter.proposals != null && searchFilter.proposals != '' ? 'proposalsLessThan=${searchFilter.proposals}&' : '';

    print('----titleParam----');
    print(titleParam);
    print('----projectScopeFlagParam----');
    print(projectScopeFlagParam);
    print('----numberOfStudentsParam----');
    print(numberOfStudentsParam);
    print('----proposalsLessThanParam----');
    print(proposalsLessThanParam);

    final urlGetProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/project?$titleParam$projectScopeFlagParam$numberOfStudentsParam$proposalsLessThanParam');

    print('----urlGetProjects----');
    print(urlGetProjects);

    final responseProjectsSearch = await http.get(
      urlGetProjects,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final responseProjectsSearchData = json.decode(responseProjectsSearch.body);
    print('----responseProjectsSearchData----');
    print(responseProjectsSearchData['result']);

    List<Project> listProjectSearchsGetFromRes = [];
    if (responseProjectsSearchData['result'] != null) {
      for (var item in responseProjectsSearchData['result']) {
        listProjectSearchsGetFromRes.add(Project(
          id: item['id'].toString(),
          title: item['title'],
          createTime: '${tmp.Createat} ${DateFormat("dd/MM/yyyy | HH:mm").format(
                DateTime.parse(item['createdAt']).toLocal(),
              ).toString()}',
          projectScopeFlag: item['projectScopeFlag'],
          numberOfStudents: item['numberOfStudents'],
          description: item['description'],
          countProposals: item['countProposals'],
          isFavorite: item['isFavorite'],
        ));
      }
      print('----listProjectsSearch----');
      print(json.encode(listProjectsSearch));
    }

    setState(() {
      listProjectsSearch = [...listProjectSearchsGetFromRes];
      isFetchingData = false;
    });
  }

  @override
  void initState() {
    final user = ref.read(userProvider);
    final searchFilter = ref.read(searchFilterProvider);
    final lang = ref.read(LanguageProvider);
    getProjects(user.token!, searchFilter, lang);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchFilter = ref.watch(searchFilterProvider);
    final student = ref.watch(studentProvider);
    var Language = ref.watch(LanguageProvider);
    int projectLength = -1;
    var colorApp = ref.watch(colorProvider);
    searchController.text = searchFilter.search!;
    final user = ref.watch(userProvider);
    final projectId = ref.watch(projectIdProvider);

    return Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        ref.read(optionsProvider.notifier).setWidgetOption('Projects', user.role!);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      Language.ProjectSearch,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: colorApp.colorTitle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 315,
                      child: InkWell(
                        onTap: () {
                          final leftColumnDiscoverData = ['frontend developer', 'backend developer', 'app designer'];
                          final rightColumnDiscoverData = ['flutter intern', 'senior frontend', 'fresher python'];
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: colorApp.colorBackgroundBootomSheet,
                            builder: (ctx) {
                              return SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 40),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          Language.Search,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: colorApp.colorTitle,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        height: 45,
                                        child: TextField(
                                          style: const TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(255, 114, 111, 111),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          controller: searchController,
                                          textInputAction: TextInputAction.search,
                                          onSubmitted: (value) {
                                            ref.read(optionsProvider.notifier).setWidgetOption('ProjectSearch', user.role!);
                                            ref.read(searchFilterProvider.notifier).setSearch(searchController.text);

                                            final searchFilterAfterFilter = ref.watch(searchFilterProvider);
                                            getProjects(user.token!, searchFilterAfterFilter, Language);

                                            numOfStudentsController.text = '';
                                            proposalsController.text = '';
                                            setState(() {
                                              projectLength = -1;
                                            });

                                            Navigator.pop(context);
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(9),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(9),
                                              borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 15,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: colorApp.colorIcon,
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                searchController.text = '';
                                              },
                                              child: const Icon(Icons.clear),
                                            ),
                                            hintText: Language.textSearch_2,
                                            hintStyle: const TextStyle(color: Color.fromARGB(255, 114, 111, 111), fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        height: 580,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  Language.Discover,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: colorApp.colorTitle,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      ...leftColumnDiscoverData.map(
                                                        (data) => InkWell(
                                                          onTap: () {
                                                            searchController.text = data;
                                                            Navigator.pop(context);
                                                            ref.read(optionsProvider.notifier).setWidgetOption('ProjectSearch', user.role!);
                                                            ref.read(searchFilterProvider.notifier).setSearch(searchController.text);

                                                            final searchFilterAfterFilter = ref.watch(searchFilterProvider);
                                                            getProjects(user.token!, searchFilterAfterFilter, Language);

                                                            numOfStudentsController.text = '';
                                                            proposalsController.text = '';
                                                            setState(() {
                                                              projectLength = -1;
                                                            });
                                                          },
                                                          child: SizedBox(
                                                            height: 40,
                                                            width: 185,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  Icons.search,
                                                                  color: colorApp.colorIcon,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  data,
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    color: colorApp.colorText,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  // const SizedBox(width: 5),
                                                  Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      ...rightColumnDiscoverData.map(
                                                        (data) => InkWell(
                                                          onTap: () {
                                                            searchController.text = data;
                                                            Navigator.pop(context);
                                                            ref.read(optionsProvider.notifier).setWidgetOption('ProjectSearch', user.role!);
                                                            ref.read(searchFilterProvider.notifier).setSearch(searchController.text);

                                                            final searchFilterAfterFilter = ref.watch(searchFilterProvider);
                                                            getProjects(user.token!, searchFilterAfterFilter, Language);

                                                            numOfStudentsController.text = '';
                                                            proposalsController.text = '';
                                                            setState(() {
                                                              projectLength = -1;
                                                            });
                                                          },
                                                          child: SizedBox(
                                                            height: 40,
                                                            width: 175,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  Icons.search,
                                                                  color: colorApp.colorIcon,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  data,
                                                                  style: TextStyle(fontSize: 16, color: colorApp.colorText),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  Language.Suggested,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: colorApp.colorTitle,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 20,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: SizedBox(
                                                              width: 300,
                                                              child: Text(
                                                                'Senior frontend developer (Fintech)',
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                  color: colorApp.colorTitle,
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          InkWell(
                                                            onTap: () {},
                                                            child: Icon(
                                                              Icons.favorite_border,
                                                              color: colorApp.colorIcon,
                                                              size: 28,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: SizedBox(
                                                          width: 340,
                                                          child: Text(
                                                            Language.ex_1,
                                                            style: TextStyle(
                                                              color: colorApp.colorTime,
                                                              overflow: TextOverflow.ellipsis,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: SizedBox(
                                                          width: 340,
                                                          child: Text(
                                                            Language.ex_2,
                                                            style: TextStyle(
                                                              color: colorApp.colorText,
                                                              overflow: TextOverflow.ellipsis,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 15),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: colorApp.colorDivider as Color, //                   <--- border color
                                                            width: 0.3,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 15),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.format_indent_increase_rounded,
                                                            size: 22,
                                                            color: colorApp.colorIcon,
                                                          ),
                                                          const SizedBox(width: 5),
                                                          Text(
                                                            Language.ex_3,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: colorApp.colorText,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 20,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: SizedBox(
                                                              width: 300,
                                                              child: Text(
                                                                'Senior frontend developer (Fintech)',
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                  color: colorApp.colorTitle,
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          InkWell(
                                                            onTap: () {},
                                                            child: Icon(
                                                              Icons.favorite_border,
                                                              color: colorApp.colorIcon,
                                                              size: 28,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: SizedBox(
                                                          width: 340,
                                                          child: Text(
                                                            Language.ex_1,
                                                            style: TextStyle(
                                                              color: colorApp.colorTime,
                                                              overflow: TextOverflow.ellipsis,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: SizedBox(
                                                          width: 340,
                                                          child: Text(
                                                            Language.ex_2,
                                                            style: TextStyle(
                                                              color: colorApp.colorText,
                                                              overflow: TextOverflow.ellipsis,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 15),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: colorApp.colorDivider as Color, //                   <--- border color
                                                            width: 0.3,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 15),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.format_indent_increase_rounded,
                                                            size: 22,
                                                            color: colorApp.colorIcon,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            Language.ex_3,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: colorApp.colorText,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: IgnorePointer(
                          child: TextField(
                            showCursor: true,
                            readOnly: true,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 114, 111, 111),
                              fontWeight: FontWeight.w500,
                            ),
                            controller: searchController,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              Navigator.pop(context);
                              ref.read(optionsProvider.notifier).setWidgetOption('ProjectSearch', user.role!);

                              ref.read(searchFilterProvider.notifier).setSearch(searchController.text);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 15,
                              ),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: InkWell(
                                onTap: () {},
                                child: const Icon(Icons.clear),
                              ),
                              hintText: Language.textSearch,
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 114, 111, 111),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: colorApp.colorBackgroundBootomSheet,
                          builder: (ctx) {
                            return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: SingleChildScrollView(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 40),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            Language.Fillter,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: colorApp.colorTitle,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: colorApp.colorDivider as Color, //                   <--- border color
                                              width: 0.3,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          height: 580,
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  Language.Projectlength,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: colorApp.colorTitle,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 15),

                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: LabeledRadio(
                                                      label: Language.Time_1,
                                                      textColor: colorApp.colorText,
                                                      value: 0,
                                                      groupValue: projectLength,
                                                      onChanged: (value) {
                                                        ref.read(searchFilterProvider.notifier).setProjectLength(value as int);
                                                        setState(() {
                                                          projectLength = value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: LabeledRadio(
                                                      label: Language.Time_2,
                                                      textColor: colorApp.colorText,
                                                      value: 1,
                                                      groupValue: projectLength,
                                                      onChanged: (value) {
                                                        ref.read(searchFilterProvider.notifier).setProjectLength(value as int);
                                                        setState(() {
                                                          projectLength = value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: LabeledRadio(
                                                      label: Language.Time_3,
                                                      textColor: colorApp.colorText,
                                                      value: 2,
                                                      groupValue: projectLength,
                                                      onChanged: (value) {
                                                        ref.read(searchFilterProvider.notifier).setProjectLength(value as int);
                                                        setState(() {
                                                          projectLength = value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: LabeledRadio(
                                                      label: Language.Time_4,
                                                      textColor: colorApp.colorText,
                                                      value: 3,
                                                      groupValue: projectLength,
                                                      onChanged: (value) {
                                                        ref.read(searchFilterProvider.notifier).setProjectLength(value as int);
                                                        setState(() {
                                                          projectLength = value!;
                                                        });
                                                        if (projectLength == -1 || numOfStudentsController.text.isEmpty || proposalsController.text.isEmpty) {
                                                          enable = false;
                                                        } else {
                                                          enable = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // const SizedBox(width: 5),

                                              const SizedBox(height: 20),

                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  Language.StudentNeed,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: colorApp.colorTitle,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 15),

                                              SizedBox(
                                                child: TextField(
                                                  controller: numOfStudentsController,
                                                  onChanged: (data) {},
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: colorApp.colorText,
                                                  ),
                                                  decoration: InputDecoration(
                                                    // labelText: 'Number of students',
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(9),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(9),
                                                      borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                    ),
                                                    contentPadding: const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 15,
                                                    ),
                                                    hintText: Language.TextStudent,
                                                    hintStyle: TextStyle(color: colorApp.colorText),
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 20),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  Language.ProposalsFillter,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: colorApp.colorTitle,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 15),

                                              SizedBox(
                                                child: TextField(
                                                  controller: proposalsController,
                                                  onChanged: (data) {},
                                                  style: TextStyle(fontSize: 16, color: colorApp.colorText),
                                                  decoration: InputDecoration(
                                                    // labelText: 'Number of students',
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(9),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(9),
                                                      borderSide: BorderSide(color: colorApp.colorBorderSide as Color),
                                                    ),
                                                    contentPadding: const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 15,
                                                    ),
                                                    hintText: Language.TextProposals,
                                                    hintStyle: TextStyle(color: colorApp.colorText),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 120),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 46,
                                                    width: 175,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        numOfStudentsController.text = '';
                                                        proposalsController.text = '';
                                                        setState(() {
                                                          projectLength = -1;
                                                        });
                                                        ref.read(searchFilterProvider.notifier).setNumOfStudents(
                                                              '',
                                                            );
                                                        ref.read(searchFilterProvider.notifier).setProposals(
                                                              '',
                                                            );
                                                        ref.read(searchFilterProvider.notifier).setProjectLength(
                                                              -1,
                                                            );
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        minimumSize: Size.zero, // Set this
                                                        padding: EdgeInsets.zero, // and this
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                          side: const BorderSide(color: Colors.black),
                                                        ),
                                                        backgroundColor: colorApp.colorWhiteBlack,
                                                      ),
                                                      child: Text(
                                                        Language.ClearFilters,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: colorApp.colorBlackWhite,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  SizedBox(
                                                    height: 46,
                                                    width: 175,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        ref.read(searchFilterProvider.notifier).setNumOfStudents(
                                                              numOfStudentsController.text,
                                                            );
                                                        ref.read(searchFilterProvider.notifier).setProposals(
                                                              proposalsController.text,
                                                            );
                                                        ref.read(searchFilterProvider.notifier).setProjectLength(
                                                              projectLength,
                                                            );
                                                        final searchFilterAfterFilter = ref.watch(searchFilterProvider);
                                                        getProjects(user.token!, searchFilterAfterFilter, Language);

                                                        numOfStudentsController.text = '';
                                                        proposalsController.text = '';
                                                        setState(() {
                                                          projectLength = -1;
                                                        });
                                                        ref.read(searchFilterProvider.notifier).setNumOfStudents(
                                                              '',
                                                            );
                                                        ref.read(searchFilterProvider.notifier).setProposals(
                                                              '',
                                                            );
                                                        ref.read(searchFilterProvider.notifier).setProjectLength(
                                                              -1,
                                                            );
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        minimumSize: Size.zero, // Set this
                                                        padding: EdgeInsets.zero, // and this
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        backgroundColor: colorApp.colorBlackWhite,
                                                      ),
                                                      child: Text(
                                                        Language.apply,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: colorApp.colorWhiteBlack,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                      child: Icon(
                        Icons.filter_list_sharp,
                        size: 35,
                        color: colorApp.colorIcon,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Result',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorApp.colorText,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 650,
                  child: SingleChildScrollView(
                    child: isFetchingData
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 220),
                              Center(
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : listProjectsSearch.isEmpty
                            ? Column(
                                children: [
                                  Text(
                                    Language.Noproject,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: colorApp.colorText,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              )
                            : Column(
                                children: [
                                  ...listProjectsSearch.map((el) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            ref.read(projectIdProvider.notifier).setProjectId(el.id.toString());

                                            ref.read(optionsProvider.notifier).setWidgetOption('ProjectDetails', user.role!);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.white,
                                              // border: Border.all(color: Colors.grey),
                                              //color: Colors.white,
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 20,
                                                horizontal: 20,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: SizedBox(
                                                          width: 300,
                                                          child: Text(
                                                            el.title,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              color: colorApp.colorTitle,
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      InkWell(
                                                        onTap: user.role == '1'
                                                            ? null
                                                            : () async {
                                                                final urlFavoriteProjects = Uri.parse('${dotenv.env['IP_ADDRESS']}/api/favoriteProject/${student.id}?');

                                                                final responsePatchFavoriteProject = await http.patch(
                                                                  urlFavoriteProjects,
                                                                  headers: {
                                                                    'Content-Type': 'application/json',
                                                                    'Authorization': 'Bearer ${user.token!}',
                                                                  },
                                                                  body: json.encode({
                                                                    'projectId': el.id,
                                                                    'disableFlag': el.isFavorite ? 1 : 0,
                                                                  }),
                                                                );

                                                                final responsePatchFavoriteProjectData = json.decode(responsePatchFavoriteProject.body);

                                                                print('----responsePatchFavoriteProjecData----');
                                                                print(responsePatchFavoriteProjectData);

                                                                getProjects(user.token!, searchFilter, Language);
                                                              },
                                                        child: Icon(
                                                          el.isFavorite ? Icons.favorite_rounded : Icons.favorite_border,
                                                          size: 28,
                                                          color: colorApp.colorIcon,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: SizedBox(
                                                      width: 340,
                                                      child: Text(
                                                        el.createTime,
                                                        style: TextStyle(
                                                          color: colorApp.colorTime,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: SizedBox(
                                                      width: 340,
                                                      child: Text(
                                                        Language.Time +
                                                            ': ${el.projectScopeFlag == 0 ? Language.Time_1 : el.projectScopeFlag == 1 ? Language.Time_2 : el.projectScopeFlag == 2 ? Language.Time_3 : Language.Time_3}, ${el.numberOfStudents} ' +
                                                            Language.StudentNeed,
                                                        style: TextStyle(
                                                          color: colorApp.colorText,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: colorApp.colorDivider as Color, //                   <--- border color
                                                        width: 0.3,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      el.description,
                                                      style: TextStyle(
                                                        color: colorApp.colorText,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: colorApp.colorDivider as Color, //                   <--- border color
                                                        width: 0.3,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.format_indent_increase_rounded,
                                                        size: 22,
                                                        color: colorApp.colorIcon,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        '${Language.Proposals}: ${el.countProposals}',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: colorApp.colorText,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                    );
                                  })
                                ],
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

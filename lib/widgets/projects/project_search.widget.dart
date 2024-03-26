import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/options_provider.dart';
import 'package:studenthub/providers/search_filter_provider.dart';
import '../../providers/project_posting_provider.dart';
// import '../../providers/options_provider.dart';

class LabeledRadio<T> extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

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
            style: const TextStyle(color: Colors.black, fontSize: 16),
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

  void openMoreOverlay() {
    final leftColumnDiscoverData = [
      'frontend developer',
      'backend developer',
      'app designer'
    ];
    final rightColumnDiscoverData = [
      'flutter intern',
      'senior frontend',
      'fresher python'
    ];
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      builder: (ctx) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
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
                      Navigator.pop(context);
                      ref
                          .read(optionsProvider.notifier)
                          .setWidgetOption('ProjectSearch');

                      ref
                          .read(searchFilterProvider.notifier)
                          .setSearch(searchController.text);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 15,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            searchController.text = '';
                          });
                          ref.read(searchFilterProvider.notifier).setSearch('');
                        },
                        child: const Icon(Icons.clear),
                      ),
                      hintText: 'Titles, Contents and More',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 114, 111, 111),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 580,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Discover",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
                                      setState(() {
                                        searchController.text = data;
                                      });
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      width: 185,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.search),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data,
                                            style: const TextStyle(
                                              fontSize: 16,
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
                                      setState(() {
                                        searchController.text = data;
                                      });
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      width: 175,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.search),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            data,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
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
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Suggested",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 233, 235, 240),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        width: 300,
                                        child: Text(
                                          'Senior frontend developer (Fintech)',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.favorite_border,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: 340,
                                    child: Text(
                                      'Created 3 days ago',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 94, 94, 94),
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: 340,
                                    child: Text(
                                      'Time: 1-3 months, 6 students needed',
                                      style: TextStyle(
                                        color: Colors.black,
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
                                      color: Colors
                                          .black, //                   <--- border color
                                      width: 0.3,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.format_indent_increase_rounded,
                                      size: 22,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Proposals: Less than 5',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
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
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 233, 235, 240),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        width: 300,
                                        child: Text(
                                          'Senior frontend developer (Fintech)',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.favorite_border,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: 340,
                                    child: Text(
                                      'Created 3 days ago',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 94, 94, 94),
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: 340,
                                    child: Text(
                                      'Time: 1-3 months, 6 students needed',
                                      style: TextStyle(
                                        color: Colors.black,
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
                                      color: Colors
                                          .black, //                   <--- border color
                                      width: 0.3,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.format_indent_increase_rounded,
                                      size: 22,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Proposals: Less than 5',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
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
  }

  @override
  Widget build(BuildContext context) {
    var searchFilter = ref.watch(searchFilterProvider);
    int projectLength = 0;

    searchController.text = searchFilter.search!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        ref
                            .read(optionsProvider.notifier)
                            .setWidgetOption('Projects');
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Project search',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
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
                        onTap: openMoreOverlay,
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
                              ref
                                  .read(optionsProvider.notifier)
                                  .setWidgetOption('ProjectSearch');

                              ref
                                  .read(searchFilterProvider.notifier)
                                  .setSearch(searchController.text);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
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
                              hintText: 'Search for projects',
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
                          backgroundColor: Colors.white,
                          builder: (ctx) {
                            return StatefulBuilder(builder: (BuildContext
                                    context,
                                StateSetter setState /*You can rename this!*/) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: SingleChildScrollView(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 40),
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Filter by",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors
                                                  .black, //                   <--- border color
                                              width: 0.3,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          height: 580,
                                          child: Column(
                                            children: [
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Project length",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 15),

                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: LabeledRadio(
                                                      label:
                                                          'Less than one month',
                                                      value: 1,
                                                      groupValue: projectLength,
                                                      onChanged: (value) {
                                                        ref
                                                            .read(
                                                                searchFilterProvider
                                                                    .notifier)
                                                            .setProjectLength(
                                                                value as int);
                                                        setState(() {
                                                          projectLength = value;
                                                        });
                                                        if (projectLength ==
                                                                0 ||
                                                            numOfStudentsController
                                                                .text.isEmpty ||
                                                            proposalsController
                                                                .text.isEmpty) {
                                                          enable = false;
                                                        } else {
                                                          enable = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: LabeledRadio(
                                                      label: '1 to 3 months',
                                                      value: 2,
                                                      groupValue: projectLength,
                                                      onChanged: (value) {
                                                        ref
                                                            .read(
                                                                searchFilterProvider
                                                                    .notifier)
                                                            .setProjectLength(
                                                                value as int);
                                                        setState(() {
                                                          projectLength = value;
                                                        });
                                                        if (projectLength ==
                                                                0 ||
                                                            numOfStudentsController
                                                                .text.isEmpty ||
                                                            proposalsController
                                                                .text.isEmpty) {
                                                          enable = false;
                                                        } else {
                                                          enable = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: LabeledRadio(
                                                      label: '3 to 6 months',
                                                      value: 3,
                                                      groupValue: projectLength,
                                                      onChanged: (value) {
                                                        ref
                                                            .read(
                                                                searchFilterProvider
                                                                    .notifier)
                                                            .setProjectLength(
                                                                value as int);
                                                        setState(() {
                                                          projectLength = value;
                                                        });
                                                        if (projectLength ==
                                                                0 ||
                                                            numOfStudentsController
                                                                .text.isEmpty ||
                                                            proposalsController
                                                                .text.isEmpty) {
                                                          enable = false;
                                                        } else {
                                                          enable = true;
                                                        }
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: LabeledRadio(
                                                      label:
                                                          'More than 6 months',
                                                      value: 4,
                                                      groupValue: projectLength,
                                                      onChanged: (value) {
                                                        ref
                                                            .read(
                                                                searchFilterProvider
                                                                    .notifier)
                                                            .setProjectLength(
                                                                value as int);
                                                        setState(() {
                                                          projectLength = value;
                                                        });
                                                        if (projectLength ==
                                                                0 ||
                                                            numOfStudentsController
                                                                .text.isEmpty ||
                                                            proposalsController
                                                                .text.isEmpty) {
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

                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Students needed",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 15),

                                              SizedBox(
                                                child: TextField(
                                                  controller:
                                                      numOfStudentsController,
                                                  onChanged: (data) {
                                                    if (projectLength == 0 ||
                                                        numOfStudentsController
                                                            .text.isEmpty ||
                                                        proposalsController
                                                            .text.isEmpty) {
                                                      enable = false;
                                                    } else {
                                                      enable = true;
                                                    }
                                                    setState(() {});
                                                  },
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  decoration: InputDecoration(
                                                    // labelText: 'Number of students',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      vertical: 14,
                                                      horizontal: 15,
                                                    ),
                                                    hintText:
                                                        'Number of students',
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 20),
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Proposals less than",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 15),

                                              SizedBox(
                                                child: TextField(
                                                  controller:
                                                      proposalsController,
                                                  onChanged: (data) {
                                                    if (projectLength == 0 ||
                                                        numOfStudentsController
                                                            .text.isEmpty ||
                                                        proposalsController
                                                            .text.isEmpty) {
                                                      enable = false;
                                                    } else {
                                                      enable = true;
                                                    }
                                                    setState(() {});
                                                  },
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  decoration: InputDecoration(
                                                    // labelText: 'Number of students',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      vertical: 14,
                                                      horizontal: 15,
                                                    ),
                                                    hintText:
                                                        'Number of students',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 120),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 46,
                                                    width: 175,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        numOfStudentsController
                                                            .text = '';
                                                        proposalsController
                                                            .text = '';
                                                        setState(() {
                                                          projectLength = 0;
                                                          enable = false;
                                                        });
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        minimumSize: Size
                                                            .zero, // Set this
                                                        padding: EdgeInsets
                                                            .zero, // and this
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          side:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                      child: const Text(
                                                        'Clear filters',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  SizedBox(
                                                    height: 46,
                                                    width: 175,
                                                    child: ElevatedButton(
                                                      onPressed:
                                                          enable ? () {} : null,
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        minimumSize: Size
                                                            .zero, // Set this
                                                        padding: EdgeInsets
                                                            .zero, // and this
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        backgroundColor:
                                                            Colors.black,
                                                      ),
                                                      child: const Text(
                                                        'Apply',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontWeight:
                                                              FontWeight.w500,
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
                      child: const Icon(
                        Icons.filter_list_sharp,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 610,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(optionsProvider.notifier)
                                .setWidgetOption('ProjectDetails');
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 233, 235, 240),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          width: 300,
                                          child: Text(
                                            'Senior frontend developer (Fintech)',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.favorite_border,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: 340,
                                      child: Text(
                                        'Created 3 days ago',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 94, 94, 94),
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: 340,
                                      child: Text(
                                        'Time: 1-3 months, 6 students needed',
                                        style: TextStyle(
                                          color: Colors.black,
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
                                        color: Colors
                                            .black, //                   <--- border color
                                        width: 0.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'This practice lesson consists of short paragraphs about interesting subjects. Find fun keyboard typing practice—and learn something new! Our paragraph practice is great typing practice for writing essays, reports, emails, and more for school and work.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors
                                            .black, //                   <--- border color
                                        width: 0.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.format_indent_increase_rounded,
                                        size: 22,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Proposals: Less than 5',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
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
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(optionsProvider.notifier)
                                .setWidgetOption('ProjectDetails');
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 233, 235, 240),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: SizedBox(
                                          width: 300,
                                          child: Text(
                                            'Senior frontend developer (Fintech)',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.favorite_border,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: 340,
                                      child: Text(
                                        'Created 3 days ago',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 94, 94, 94),
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: 340,
                                      child: Text(
                                        'Time: 1-3 months, 6 students needed',
                                        style: TextStyle(
                                          color: Colors.black,
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
                                        color: Colors
                                            .black, //                   <--- border color
                                        width: 0.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'This practice lesson consists of short paragraphs about interesting subjects. Find fun keyboard typing practice—and learn something new! Our paragraph practice is great typing practice for writing essays, reports, emails, and more for school and work.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors
                                            .black, //                   <--- border color
                                        width: 0.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.format_indent_increase_rounded,
                                        size: 22,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Proposals: Less than 5',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
        ),
      ),
    );
  }
}

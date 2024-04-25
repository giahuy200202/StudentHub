import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/projects/search_filter.provider.dart';
import 'package:studenthub/widgets/projects/list_projects.widget.dart';
import '../../providers/options.provider.dart';
// import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:studenthub/providers/theme/theme_provider.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ProjectScreen> createState() {
    return _ProjectScreenState();
  }
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  var searchController = TextEditingController();
  var tempController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    var colorApp = ref.watch(colorProvider);

    return Scaffold(
      backgroundColor: colorApp.colorBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
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
                                          "Search",
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
                                            Navigator.pop(context);
                                            ref.read(optionsProvider.notifier).setWidgetOption('ProjectSearch', user.role!);
                                            ref.read(searchFilterProvider.notifier).setSearch(searchController.text);
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
                                            prefixIcon: const Icon(Icons.search),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                searchController.text = '';
                                                ref.read(searchFilterProvider.notifier).setSearch('');
                                              },
                                              child: const Icon(Icons.clear),
                                            ),
                                            hintText: 'Titles, Contents and More',
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
                                                  "Discover",
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
                                                            setState(() {
                                                              searchController.text = data;
                                                              Navigator.pop(context);
                                                              ref.read(optionsProvider.notifier).setWidgetOption('ProjectSearch', user.role!);
                                                              ref.read(searchFilterProvider.notifier).setSearch(searchController.text);
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
                                                            setState(() {
                                                              searchController.text = data;
                                                              Navigator.pop(context);
                                                              ref.read(optionsProvider.notifier).setWidgetOption('ProjectSearch', user.role!);
                                                              ref.read(searchFilterProvider.notifier).setSearch(searchController.text);
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
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Suggested",
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
                                                  // color: Colors.white,
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
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: SizedBox(
                                                          width: 340,
                                                          child: Text(
                                                            'Time: 1-3 months, 6 students needed',
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
                                                            'Proposals: Less than 5',
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
                                                              size: 28,
                                                              color: colorApp.colorIcon,
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
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: SizedBox(
                                                          width: 340,
                                                          child: Text(
                                                            'Time: 1-3 months, 6 students needed',
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
                                                            color: colorApp.colorText,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            'Proposals: Less than 5',
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
                            controller: tempController,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {},
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
                      onTap: user.role == '1'
                          ? null
                          : () {
                              ref.read(optionsProvider.notifier).setWidgetOption('SavedProjects', user.role!);
                            },
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 35,
                        color: colorApp.colorIcon,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const ListProjectsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

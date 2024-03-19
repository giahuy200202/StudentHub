import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/projects/list_projects.widget.dart';
import '../../providers/options_provider.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ProjectScreen> createState() {
    return _ProjectScreenState();
  }
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
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
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 114, 111, 111),
                          fontWeight: FontWeight.w500,
                        ),
                        // controller: searchController,
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
                    const Spacer(),
                    const Icon(
                      Icons.favorite_rounded,
                      size: 35,
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const ListProjects()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

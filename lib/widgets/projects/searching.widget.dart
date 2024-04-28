import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchingWidget extends ConsumerStatefulWidget {
  const SearchingWidget({super.key});

  @override
  ConsumerState<SearchingWidget> createState() {
    return _SearchingWidgetState();
  }
}

class _SearchingWidgetState extends ConsumerState<SearchingWidget> {
  @override
  Widget build(BuildContext context) {
    final leftColumnDiscoverData = ['flutter', 'react native', 'ux'];
    final rightColumnDiscoverData = ['animation', 'riverpod', 'http requests'];

    var getToday = DateTime.now();

    var getFormatDate = DateTime(getToday.year, getToday.month, getToday.day);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 25),
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
                            fontSize: 20,
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
                                      // searchController.text = data;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: SizedBox(
                                      width: 185,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              ...rightColumnDiscoverData.map(
                                (data) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      // searchController.text = data;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: SizedBox(
                                      width: 175,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Suggested",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

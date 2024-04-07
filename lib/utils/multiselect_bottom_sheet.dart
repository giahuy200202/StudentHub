import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/profile/student_input.provider.dart';
import 'package:studenthub/utils/multiselect_bottom_sheet_model.dart';
import 'package:studenthub/utils/colors.dart';

class MultiSelectBottomSheet extends ConsumerStatefulWidget {
  final List<MultiSelectBottomSheetModel> items;
  final double width;

  final double bottomSheetHeight;
  final double? searchTextFieldWidth;
  final String? hint;
  final String cancelText;
  final String confirmText;
  final String clearAll;
  final Color hintColor;
  final Color textColor;
  final Color borderColor;
  final Color selectedBackgroundColor;
  final Color unSelectedBackgroundColor;
  final Color suggestionListBorderColor;
  final TextEditingController controller;
  final TextStyle? searchHintTextStyle;
  final TextStyle? selectTextStyle;
  final TextStyle? unSelectTextStyle;
  final Icon searchIcon;

  const MultiSelectBottomSheet({
    required this.items,
    required this.width,
    required this.hint,
    required this.bottomSheetHeight,
    required this.searchIcon,
    required this.controller,
    this.searchTextFieldWidth,
    this.cancelText = 'Cancel',
    this.confirmText = 'Confirm',
    this.clearAll = 'Clear All',
    this.hintColor = Colors.black,
    this.textColor = Colors.black54,
    this.borderColor = Colors.black12,
    this.selectedBackgroundColor = const Color.fromARGB(255, 0, 0, 0),
    this.unSelectedBackgroundColor = Colors.white,
    this.suggestionListBorderColor = const Color.fromARGB(255, 0, 0, 0),
    this.searchHintTextStyle,
    this.selectTextStyle,
    this.unSelectTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MultiSelectBottomSheet> createState() => _MultiSelectBottomSheetState();
}

class _MultiSelectBottomSheetState extends ConsumerState<MultiSelectBottomSheet> {
  TextEditingController controller = TextEditingController();
  List<MultiSelectBottomSheetModel> filterList = [];
  List<MultiSelectBottomSheetModel> defaultList = [];

  @override
  void initState() {
    super.initState();
    defaultList.clear();
    filterList.clear();
    for (var item in widget.items) {
      defaultList.add(MultiSelectBottomSheetModel(id: item.id, name: item.name, isSelected: item.isSelected));
      filterList.add(MultiSelectBottomSheetModel(id: item.id, name: item.name, isSelected: item.isSelected));
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 450,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 114, 111, 111),
                            fontWeight: FontWeight.w500,
                          ),
                          // controller: searchController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            setState(() {
                              filterList = widget.items.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
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
                            hintText: 'Search for skillset',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 114, 111, 111),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Skillset',
                        style: (TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: width,
                            child: Wrap(
                              spacing: 12,
                              runSpacing: width * 0.01,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              alignment: WrapAlignment.start,
                              children: filterList.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      e.isSelected = !e.isSelected;

                                      if (e.id == widget.items[0].id) {
                                      } else {
                                        if (filterList[0].id != widget.items[0].id) {
                                          filterList[0].isSelected = false;
                                        }
                                      }
                                      defaultList.where((element) => element.id == e.id).first.isSelected = e.isSelected;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.025, vertical: width * 0.015),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: e.isSelected ? widget.selectedBackgroundColor : widget.unSelectedBackgroundColor,
                                      border: Border.all(color: widget.suggestionListBorderColor),
                                    ),
                                    child: Text(
                                      e.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: e.isSelected ? widget.selectTextStyle : widget.unSelectTextStyle,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 100,
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            defaultList.where((element) => element.isSelected).isEmpty
                                ? Container()
                                : SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            for (var item in defaultList) {
                                              item.isSelected = false;
                                            }
                                            filterList = defaultList;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                                          child: Text(
                                            widget.clearAll,
                                            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                                        child: Text(
                                          widget.cancelText,
                                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        final isSelectedList = filterList.where((el) => el.isSelected).toList();

                                        final List<int> isSelectedIdList = [];

                                        for (var item in isSelectedList) {
                                          isSelectedIdList.add(item.id);
                                        }

                                        ref.read(studentInputProvider.notifier).setStudentInputSkillSet(
                                              isSelectedIdList,
                                            );

                                        setState(() {
                                          widget.items.clear();
                                          widget.items.addAll(defaultList);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                                        child: Text(
                                          widget.confirmText,
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        ).then((value) {
          setState(() {});
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(9),
            color: whiteColor),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: widget.items.where((element) => element.isSelected).isEmpty ? 15 : height * 0.015),
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.items.where((element) => element.isSelected).isEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      "${widget.hint}",
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: widget.hintColor, fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Wrap(
                      spacing: width * 0.01,
                      runSpacing: width * 0.01,
                      children: widget.items.where((element) => element.isSelected).map((e) {
                        String separator = e.id == widget.items.where((element) => element.isSelected).last.id ? "" : ", ";
                        return Text(
                          "${e.name}$separator",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16),
                        );
                      }).toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

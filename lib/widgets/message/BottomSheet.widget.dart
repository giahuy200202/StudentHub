import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studenthub/providers/authentication/authentication.provider.dart';
import 'package:studenthub/providers/options.provider.dart';

class ShowbottomSheduleWidget extends ConsumerStatefulWidget {
  const ShowbottomSheduleWidget({super.key});

  @override
  ConsumerState<ShowbottomSheduleWidget> createState() {
    return _ShowbottomSheduleWidget();
  }
}

class _ShowbottomSheduleWidget extends ConsumerState<ShowbottomSheduleWidget> {
  var dateController = TextEditingController(text: 'Select Date');
  var timeController = TextEditingController(text: 'Select Time');
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void showVideoCallInterviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Schedule a video call interview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Title',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: TextField(
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    hintText: 'Catch up meeting',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 114, 111, 111),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Text(
                'Start time',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 114, 111, 111),
                              fontWeight: FontWeight.w500,
                            ),
                            readOnly: true,
                            controller: dateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 10,
                              ),
                              suffixIcon: InkWell(
                                onTap: presentDatePicker,
                                child:
                                    const Icon(Icons.calendar_month_outlined),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 170,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 114, 111, 111),
                              fontWeight: FontWeight.w500,
                            ),
                            readOnly: true,
                            controller: timeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 10,
                              ),
                              suffixIcon: InkWell(
                                onTap: presentTimePicker,
                                child: const Icon(Icons.timer_sharp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Text(
                'End time',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 114, 111, 111),
                              fontWeight: FontWeight.w500,
                            ),
                            readOnly: true,
                            controller: dateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 10,
                              ),
                              suffixIcon: InkWell(
                                onTap: presentDatePicker,
                                child:
                                    const Icon(Icons.calendar_month_outlined),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 170,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 60,
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 114, 111, 111),
                              fontWeight: FontWeight.w500,
                            ),
                            readOnly: true,
                            controller: timeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 10,
                              ),
                              suffixIcon: InkWell(
                                onTap: presentTimePicker,
                                child: const Icon(Icons.timer_sharp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 46,
                    width: 175,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero, // Set this
                        padding: EdgeInsets.zero, // and this
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
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
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero, // Set this
                        padding: EdgeInsets.zero, // and this
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Schedule',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        {
          showVideoCallInterviewBottomSheet(context);
          break;
        }

      case 1:
        break;
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  void presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      selectedDate = pickedDate;
    });
    dateController.text =
        DateFormat('dd/MM/yyyy').format(selectedDate!).toString();
  }

  void presentTimePicker() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    setState(() {
      selectedTime = pickedTime;
    });

    timeController.text = '${pickedTime!.hour}:${pickedTime.minute}';
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(69),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              ref
                                  .read(optionsProvider.notifier)
                                  .setWidgetOption('Message', user.role!);
                            },
                            child: const SizedBox(
                              height: 20,
                              width: 20,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Luis Pham',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          PopupMenuButton<int>(
                            onSelected: (item) => handleClick(item),
                            itemBuilder: (context) => [
                              const PopupMenuItem<int>(
                                  value: 0,
                                  child: Text(
                                    'Schedule an interview',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )),
                              const PopupMenuItem<int>(
                                value: 1,
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ])))));
  }
}

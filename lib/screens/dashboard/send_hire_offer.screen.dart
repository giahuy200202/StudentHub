import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication_provider.dart';
import 'package:studenthub/widgets/dashboard/archieved.widget.dart';
import 'package:studenthub/widgets/dashboard/detail.widget.dart';
import 'package:studenthub/widgets/dashboard/hired.widget.dart';
import 'package:studenthub/widgets/dashboard/message.widget.dart';
import 'package:studenthub/widgets/dashboard/proposals.widget.dart';
import 'package:studenthub/widgets/dashboard/working.widget.dart';
import '../../providers/options_provider.dart';

class SendHireOfferScreen extends ConsumerStatefulWidget {
  const SendHireOfferScreen({super.key});

  @override
  ConsumerState<SendHireOfferScreen> createState() {
    return _SendHireOfferScreenState();
  }
}

class _SendHireOfferScreenState extends ConsumerState<SendHireOfferScreen> {
  int tabWidget = 1;

  void setTabWidget(int index) {
    setState(() {
      tabWidget = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      ref
                          .read(optionsProvider.notifier)
                          .setWidgetOption('Dashboard', user.role!);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(
                    width: 320,
                    child: Text(
                      'Senior frontend developer (Fintech)',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(1);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 1
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Proposals",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 1
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(2);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 2
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Detail",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 2
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(3);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 3
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Message",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 3
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setTabWidget(4);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 1,
                      ),
                      decoration: tabWidget == 4
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            )
                          : null,
                      child: Text(
                        "Hired",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: tabWidget == 4
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              tabWidget == 1
                  ? ProposalsWidget()
                  : tabWidget == 2
                      ? DetailWidget()
                      : tabWidget == 3
                          ? MessageWidget()
                          : HiredWidget()
            ],
          ),
        ),
      ),
    );
  }
}

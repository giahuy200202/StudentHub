import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/providers/authentication_provider.dart';
import 'package:studenthub/providers/options_provider.dart';

class VideocallWidget extends ConsumerStatefulWidget {
  const VideocallWidget({super.key});

  @override
  ConsumerState<VideocallWidget> createState() {
    return _VideocallWidget();
  }
}

class _VideocallWidget extends ConsumerState<VideocallWidget> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          ref
                              .read(optionsProvider.notifier)
                              .setWidgetOption('MessageDetails', user.role!);
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
                        'Video call',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                    ])
                  ]))),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 320,
                        width: 360,
                        child: Column(
                          children: [
                            Container(
                              width: 360,
                              height: 300,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/1.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 320,
                        width: 360,
                        child: Column(
                          children: [
                            Container(
                              width: 360,
                              height: 300,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/2.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const SizedBox(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.mic,
                                  size: 30,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {},
                              child: const SizedBox(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(optionsProvider.notifier)
                                    .setWidgetOption(
                                        'MessageDetails', user.role!);
                              },
                              child: const SizedBox(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.phone_enabled,
                                  size: 30,
                                ),
                              ),
                            ),
                          ])
                    ]))));
  }
}

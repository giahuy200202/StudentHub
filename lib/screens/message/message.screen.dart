import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/message/list_message.widget.dart';
//import '../../providers/options_provider.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({super.key});

  @override
  ConsumerState<MessageScreen> createState() {
    return _MessageScreenState();
  }
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 370,
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
                          hintText: 'Search for message',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 114, 111, 111),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const MessageWidget()
              ],
            ))));
  }
}

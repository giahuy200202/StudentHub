import 'package:flutter/material.dart';

class TopNavbar extends StatelessWidget {
  const TopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 15, top: 50, bottom: 15),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'StudentHub',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              print('123');
            },
            child: const Icon(
              Icons.person,
              size: 35,
              color: Colors.white,
              // onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

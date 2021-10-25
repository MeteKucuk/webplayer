import 'package:flutter/material.dart';

class appBar extends StatelessWidget with PreferredSizeWidget {
  appBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  String? value;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xf967D9C6),
      elevation: 0,
      leadingWidth: 140.0,
      leading: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.account_circle_outlined,
            size: 30,
          ),
          style: TextButton.styleFrom(primary: Colors.white),
          label: const Text('Mete Küçük'),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          padding: const EdgeInsets.only(),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 30,
          ),
          onPressed: () {},
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

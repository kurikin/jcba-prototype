import 'package:cap_member_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthAppBar extends StatelessWidget with PreferredSizeWidget {
  AuthAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 28,
            color: Colors.black87,
          ),
          onPressed: () {
            Get.offAll(BaseScreen(), transition: Transition.upToDown);
          },
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}

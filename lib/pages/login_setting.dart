import 'package:cap_member_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: <Widget>[
        // ListTile(
        //   title: const Text(
        //     'プロフィールを更新',
        //     style: TextStyle(
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        //   trailing: ElevatedButton(
        //     onPressed: () async {
        //       Get.to(UpdateProfile());
        //     },
        //     child: const Text(
        //       '更新',
        //     ),
        //   ),
        // ),
        ListTile(
          title: const Text(
            'ログアウト',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: ElevatedButton(
            onPressed: () {
              AuthController.to.signOut();
              Get.back();
            },
            child: const Text(
              'ログアウト',
            ),
          ),
        )
      ],
    );
  }
}

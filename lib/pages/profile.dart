import 'package:auto_size_text/auto_size_text.dart';
import 'package:cap_member_app/controllers/auth_controller.dart';
import 'package:cap_member_app/pages/login_setting.dart';
import 'package:cap_member_app/pages/sign_in.dart';
import 'package:cap_member_app/pages/sign_up.dart';
import 'package:cap_member_app/widgets/auth/bigger_vertical_space.dart';
import 'package:cap_member_app/widgets/auth/vertical_space.dart';
import 'package:cap_member_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return controller.firestoreUser.value?.uid == null
            ? _buildNonUserPage(context)
            : _buildUserPage(controller);
      },
    );
  }

  Widget _buildUserPage(AuthController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('会員証'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.to(LoginSettings());
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10),
            Card(
              elevation: 10,
              color: const Color(0xFF0a2d49),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '一般会員',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                          ),
                          child: Image.asset(
                            'assets/images/dummy-qr.png',
                            height: 75,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    _cardTextRow(
                        '所属チーム', controller.firestoreUser.value!.teamName),
                    const VerticalSpace(),
                    _cardTextRow('ID', controller.firebaseUser.value!.uid),
                    const VerticalSpace(),
                    _cardTextRow('氏名', controller.firestoreUser.value!.name),
                    // const VerticalSpace(),
                    // _cardTextRow(
                    //     'Email', controller.firestoreUser.value!.email),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardTextRow(String title, String content) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: AutoSizeText(
            content,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNonUserPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('会員証'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: Center(
                child: AutoSizeText(
                  '会員証を表示するには、\nログインまたは会員登録をしてください',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.8,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PrimaryButton(
                  color: Colors.blue,
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: SignIn(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                    );
                  },
                  labelText: 'ログイン',
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  color: Colors.black,
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: SignUp(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                    );
                  },
                  labelText: '新規登録',
                ),
                const BiggerVerticalSpace(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

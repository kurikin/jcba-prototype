import 'package:cap_member_app/controllers/auth_controller.dart';
import 'package:cap_member_app/helpers/validator.dart';
import 'package:cap_member_app/pages/sign_in.dart';
import 'package:cap_member_app/widgets/auth/auth_app_bar.dart';
import 'package:cap_member_app/widgets/auth/bigger_vertical_space.dart';
import 'package:cap_member_app/widgets/auth/form_input_field_with_icon.dart';
import 'package:cap_member_app/widgets/auth/vertical_space.dart';
import 'package:cap_member_app/widgets/label_button.dart';
import 'package:cap_member_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ResetPassword extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // const LogoGraphicHeader(),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'メールアドレス',
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.emailController.text = value as String,
                  ),
                  const BiggerVerticalSpace(),
                  PrimaryButton(
                    labelText: 'パスワードの変更メールを送信',
                    color: Colors.black,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await authController.sendPasswordResetEmail(context);
                      }
                    },
                  ),
                  const VerticalSpace(),
                  Center(
                    child: LabelButton(
                      labelText: 'ログイン画面へ',
                      onPressed: () => pushNewScreen(context,
                          screen: SignIn(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.fade),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    if (authController.emailController.text == '') {
      return null;
    }
    return AppBar(
      title: const Text('パスワードをリセット'),
    );
  }
}

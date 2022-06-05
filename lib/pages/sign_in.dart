import 'package:cap_member_app/controllers/auth_controller.dart';
import 'package:cap_member_app/helpers/validator.dart';
import 'package:cap_member_app/pages/reset_password.dart';
import 'package:cap_member_app/pages/sign_up.dart';
import 'package:cap_member_app/widgets/auth/auth_app_bar.dart';
import 'package:cap_member_app/widgets/auth/form_input_field_with_icon.dart';
import 'package:cap_member_app/widgets/auth/vertical_space.dart';
import 'package:cap_member_app/widgets/label_button.dart';
import 'package:cap_member_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../widgets/auth/bigger_vertical_space.dart';

class SignIn extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignIn({Key? key}) : super(key: key);

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // LogoGraphicHeader(),
                  // SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'メールアドレス',
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.emailController.text = value!,
                  ),
                  const VerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: "パスワード",
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  const BiggerVerticalSpace(),
                  PrimaryButton(
                    color: Colors.blue,
                    labelText: 'ログイン',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        authController.signInWithEmailAndPassword(context);
                      }
                    },
                  ),
                  const VerticalSpace(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LabelButton(
                        labelText: 'パスワードをリセット',
                        onPressed: () => pushNewScreen(
                          context,
                          screen: ResetPassword(),
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        ),
                      ),
                      LabelButton(
                        labelText: '新規登録はこちら',
                        onPressed: () => pushNewScreen(
                          context,
                          screen: SignUp(),
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

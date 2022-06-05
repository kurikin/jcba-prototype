import 'package:cap_member_app/constants.dart';
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
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SignUp extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUp({Key? key}) : super(key: key);

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
                  // const SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.nameController,
                    iconPrefix: Icons.person,
                    labelText: '氏名',
                    validator: Validator().notEmpty,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.nameController.text = value!,
                  ),
                  const VerticalSpace(),
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
                    labelText: 'パスワード',
                    validator: Validator().password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  const VerticalSpace(),
                  DropdownSearch<String>(
                    clearButton: const Icon(
                      Icons.close,
                      size: 18,
                    ),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    showClearButton: true,
                    validator: Validator().selected,
                    onChanged: (value) {
                      if (value != null) {
                        print(value);
                        authController.teamController.text = value;
                      }
                    },
                    dropdownSearchDecoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      prefixIcon: Icon(
                        Icons.groups,
                        size: 20,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black45,
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      isDense: true,
                      isCollapsed: true,
                      filled: true,
                    ),
                    mode: Mode.DIALOG,
                    label: "所属チーム",
                    items:
                        teamNames, // popupItemDisabled: (String s) => s.startsWith('I'),
                    // onChanged: print,
                  ),
                  const BiggerVerticalSpace(),
                  PrimaryButton(
                      color: Colors.black,
                      labelText: '新規登録',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController.registerWithEmailAndPassword(context);
                        }
                      }),
                  const VerticalSpace(),
                  Center(
                    child: LabelButton(
                      labelText: 'またはログイン',
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
}

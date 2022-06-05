import 'package:cap_member_app/controllers/auth_controller.dart';
import 'package:cap_member_app/helpers/validator.dart';
import 'package:cap_member_app/models/user_model.dart';
import 'package:cap_member_app/widgets/auth/bigger_vertical_space.dart';
import 'package:cap_member_app/widgets/auth/form_input_field_with_icon.dart';
import 'package:cap_member_app/widgets/auth/vertical_space.dart';
import 'package:cap_member_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('user.name: ' + user?.value?.name);
    authController.nameController.text =
        authController.firestoreUser.value!.name;
    authController.emailController.text =
        authController.firestoreUser.value!.email;
    return Scaffold(
      appBar: AppBar(title: const Text('プロフィールを変更')),
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
                    labelText: '名前',
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
                  const BiggerVerticalSpace(),
                  PrimaryButton(
                      color: Colors.blue,
                      labelText: 'プロフィールを更新',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          UserModel _updatedUser = UserModel(
                            uid: authController.firestoreUser.value!.uid,
                            name: authController.nameController.text,
                            email: authController.emailController.text,
                            teamName: authController.teamController.value.text,
                          );
                          _updateUserConfirm(context, _updatedUser,
                              authController.firestoreUser.value!.email);
                        }
                      }),
                  const VerticalSpace(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateUserConfirm(
      BuildContext context, UserModel updatedUser, String oldEmail) async {
    final AuthController authController = AuthController.to;
    final TextEditingController _password = TextEditingController();
    return Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: const Text(
          'パスワードを入力',
        ),
        content: FormInputFieldWithIcon(
          controller: _password,
          iconPrefix: Icons.lock,
          labelText: 'パスワード',
          validator: (value) {
            String pattern = r'^.{6,}$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!)) {
              return '不正なパスワードです';
            } else {
              return null;
            }
          },
          obscureText: true,
          onChanged: (value) => null,
          onSaved: (value) => _password.text = value!,
          maxLines: 1,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('キャンセル'),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              Get.back();
              await authController.updateUser(
                  context, updatedUser, oldEmail, _password.text);
            },
          )
        ],
      ),
    );
  }
}

import 'package:evently_hti_sun/core/resources/assets_manager.dart';
import 'package:evently_hti_sun/core/resources/colors_manager.dart';
import 'package:evently_hti_sun/core/resources/constant_manager.dart';
import 'package:evently_hti_sun/core/resources/routes_manager.dart';
import 'package:evently_hti_sun/core/utils/UI_Utils.dart';
import 'package:evently_hti_sun/core/utils/validation_utils.dart';
import 'package:evently_hti_sun/core/widgets/custom_elevated_button.dart';
import 'package:evently_hti_sun/core/widgets/custom_text_button.dart';
import 'package:evently_hti_sun/core/widgets/custom_text_form_field.dart';
import 'package:evently_hti_sun/firebase/firebase_service.dart';
import 'package:evently_hti_sun/l10n/app_localizations.dart';
import 'package:evently_hti_sun/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool securePassword = true;
  bool secureRePassword = true;
  late TextEditingController nameController;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  late TextEditingController rePasswordController;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations!.register)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  ImageAssets.eventlyLogo,
                  width: 136.w,
                  height: 186.h,
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  controller: nameController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Name is required";
                    }

                    return null;
                  },
                  labelText: appLocalizations.name,
                  prefixIcon: Icons.person,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  controller: emailController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Email is required";
                    }
                    if (!ValidationUtils.isValidEmail(input)) {
                      return "Email bad format";
                    }
                    return null;
                  },
                  labelText: appLocalizations.email,
                  prefixIcon: Icons.email_sharp,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  controller: passwordController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Password is required";
                    }
                    if (input.length < 6) {
                      return "Password must be at least 6 chars";
                    }
                    return null;
                  },
                  isSecure: securePassword,
                  labelText: appLocalizations.password,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      securePassword = !securePassword;
                      setState(() {});
                    },
                    icon: Icon(
                      securePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  controller: rePasswordController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Plz confirm password";
                    }
                    if (input != passwordController.text) {
                      return "Password doesn't match";
                    }
                    return null;
                  },
                  isSecure: secureRePassword,
                  labelText: appLocalizations.re_password,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      secureRePassword = !secureRePassword;
                      setState(() {});
                    },
                    icon: Icon(
                      secureRePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                CustomElevatedButton(
                  text: appLocalizations.create_account,
                  onPress: _createAccount,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${appLocalizations.already_have_account}? ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    CustomTextButton(
                      text: appLocalizations.login,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.login,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createAccount() async {
    if (formKey.currentState?.validate() == false) return;

    try {
      UIUtils.showLoadingDialog(context);
      UserCredential credential = await FirebaseService.register(
        emailController.text,
        passwordController.text,
      );
      await FirebaseService.addUserToFirestore(
        UserModel(
          id: credential.user!.uid,
          name: nameController.text,
          email: emailController.text,
        ),
      );
      UIUtils.hideDialog(context);
      Navigator.pushReplacementNamed(context, RoutesManager.login);
    } on FirebaseAuthException catch (exception) {
      UIUtils.hideDialog(context);
      if (exception.code == FirebaseConstants.weakPasswordCode) {
        UIUtils.showMessage(context, FirebaseConstants.weakPasswordMessage);
      } else if (exception.code == FirebaseConstants.emailInUseCode) {
        UIUtils.showMessage(context, FirebaseConstants.emailInUseMessage);
      }
    } catch (exception) {
      UIUtils.hideDialog(context);
      UIUtils.showMessage(context, FirebaseConstants.failedToRegisterMessage);
    }
  }
}

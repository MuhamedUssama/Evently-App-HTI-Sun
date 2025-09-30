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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool securePassword = true;
  var formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //navigate();
    emailController = TextEditingController();
    passwordController = TextEditingController();


  }


  // navigate()async{
  //   if(FirebaseAuth.instance.currentUser != null){
  //     UserModel.currentUser =await  FirebaseService.getUserFromFirestore(FirebaseAuth.instance.currentUser!.uid);
  //     Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: MediaQuery.of(context).viewInsets.top,
        ),
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
                  labelText: appLocalizations!.email,
                  prefixIcon: Icons.email,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Email is required";
                    }
                    if (!ValidationUtils.isValidEmail(input)) {
                      return "Email ba format";
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  labelText: appLocalizations.password,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return "Password is required";
                    }
                    if (input.length < 6) {
                      return "Password must be at least 6 chars";
                    }
                    return null;
                  },
                  controller: passwordController,
                  prefixIcon: Icons.lock,
                  isSecure: securePassword,
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
                CustomTextButton(
                  text: appLocalizations.forget_password,
                  textAlign: TextAlign.end,
                  onTap: () {},
                ),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  text: appLocalizations.login,
                  onPress: login,
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${appLocalizations.dont_have_account} ? ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    CustomTextButton(
                      text: appLocalizations.create_account,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.register,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: ColorsManager.blue,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                    Text("or"),
                    Expanded(
                      child: Divider(
                        color: ColorsManager.blue,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: REdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: ColorsManager.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImageAssets.google),
                      SizedBox(width: 4.w),
                      Text(
                        appLocalizations.login_with_google,
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == false) return;
    try{
      UIUtils.showLoadingDialog(context);
    UserCredential userCredential =  await  FirebaseService.login(emailController.text, passwordController.text);
  UserModel.currentUser = await  FirebaseService.getUserFromFirestore(userCredential.user!.uid);


   UIUtils.hideDialog(context);
      Navigator.pushReplacementNamed(context, RoutesManager.mainLayout, );
    }on FirebaseAuthException catch(exception){
      UIUtils.hideDialog(context);
      UIUtils.showMessage(context, FirebaseConstants.invalidEmailOrPasswordMessage);
    }catch(exception){
      UIUtils.hideDialog(context);
      UIUtils.showMessage(context, FirebaseConstants.failedToLogin);
    }
  }
}

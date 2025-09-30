import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_hti_sun/core/resources/assets_manager.dart';
import 'package:evently_hti_sun/core/resources/colors_manager.dart';
import 'package:evently_hti_sun/core/resources/routes_manager.dart';
import 'package:evently_hti_sun/features/main_layout/profile/custom_drop_down_button.dart';
import 'package:evently_hti_sun/firebase/firebase_service.dart';
import 'package:evently_hti_sun/l10n/app_localizations.dart';
import 'package:evently_hti_sun/models/user_model.dart';
import 'package:evently_hti_sun/providers/language_provider.dart';
import 'package:evently_hti_sun/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          padding: REdgeInsets.symmetric(vertical: 46),
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(ImageAssets.profileImage),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    UserModel.currentUser!.name,
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.white,
                    ),
                  ),
                  Text(
                    UserModel.currentUser!.email,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        CustomDropDownButton(
          label: appLocalizations!.theme,
          selectedItem:
              themeProvider.isDarkEnabled
                  ? appLocalizations.dark
                  : appLocalizations.light,
          menuItems: [appLocalizations.light, appLocalizations.dark],
          onChange: (newTheme) {
            print(newTheme);
            themeProvider.changeAppTheme(
              newTheme == appLocalizations.light
                  ? ThemeMode.light
                  : ThemeMode.dark,
            );
          },
        ),
        SizedBox(height: 16.h),

        CustomDropDownButton(
          label: appLocalizations.language,
          selectedItem:
              languageProvider.isEnglishEnabled ? "English" : "Arabic",
          menuItems: ["English", "Arabic"],

          onChange: (newLang) {
            print(newLang);
            languageProvider.changeAppLang(newLang == "English" ? "en" : "ar");
          },
        ),
        Spacer(flex: 7),
        Container(
          margin: REdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.red,
              foregroundColor: ColorsManager.white,
              padding: REdgeInsets.all(16),
            ),
            onPressed: _logout,
            child: Row(
              children: [
                Icon(Icons.logout, color: ColorsManager.white),
                SizedBox(width: 8),
                Text(appLocalizations.logout),
              ],
            ),
          ),
        ),
        Spacer(flex: 3),
      ],
    );
  }

  void _logout() async {
   // FirebaseAuth.instance.currentUser = null;
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, RoutesManager.login);
  }
}

import 'package:evently_hti_sun/config/theme/theme_manager.dart';
import 'package:evently_hti_sun/core/prefs_manager/prefs_manager.dart';
import 'package:evently_hti_sun/core/resources/routes_manager.dart';
import 'package:evently_hti_sun/firebase/firebase_service.dart';
import 'package:evently_hti_sun/l10n/app_localizations.dart';
import 'package:evently_hti_sun/models/user_model.dart';
import 'package:evently_hti_sun/providers/language_provider.dart';
import 'package:evently_hti_sun/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await PrefsManager.init();
  if (FirebaseAuth.instance.currentUser != null) {
    UserModel.currentUser = await FirebaseService.getUserFromFirestore(
      FirebaseAuth.instance.currentUser!.uid,
    );
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: const Evently(),
    ),
  );
}

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return ScreenUtilInit(
      designSize: Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesManager.getRoute,
            initialRoute:
                FirebaseAuth.instance.currentUser == null
                    ? RoutesManager.login
                    : RoutesManager.mainLayout,
            theme: ThemeManager.light,
            darkTheme: ThemeManager.dark,
            themeMode: themeProvider.currentTheme,
            locale: Locale(languageProvider.currentLang),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: [
              Locale('en'), // English
              Locale('ar'), // Spanish
            ],
          ),
    );
  }
}

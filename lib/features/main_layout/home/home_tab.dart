import 'package:evently_hti_sun/core/resources/colors_manager.dart';
import 'package:evently_hti_sun/core/widgets/custom_tab_bar.dart';
import 'package:evently_hti_sun/core/widgets/custom_tab_item.dart';
import 'package:evently_hti_sun/core/widgets/event_item.dart';
import 'package:evently_hti_sun/l10n/app_localizations.dart';
import 'package:evently_hti_sun/models/category_model.dart';
import 'package:evently_hti_sun/models/event_model.dart' show EventModel;
import 'package:evently_hti_sun/models/user_model.dart';
import 'package:evently_hti_sun/providers/language_provider.dart';
import 'package:evently_hti_sun/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      children: [
      Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .primaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.welcome_message} ✨",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                    Text(
                      "${UserModel.currentUser!.name} ✨",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 4.w),
                        Text(
                          "Cairo, Egypt",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
             IconButton(onPressed: (){
               themeProvider.changeAppTheme( themeProvider.isDarkEnabled ?ThemeMode.light: ThemeMode.dark);
             }, icon:    Icon(themeProvider.isDarkEnabled ? Icons.dark_mode: Icons.light_mode)),
                InkWell(
                  onTap: (){
                    languageProvider.changeAppLang(languageProvider.currentLang == "en"? "ar": "en");
                  },

                  child: Card(
                    color: themeProvider.isDarkEnabled ? ColorsManager.ofWhite : ColorsManager.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                       languageProvider.currentLang == "en"? "En": "Ar",
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomTabBar(categories: CategoryModel.getCategoriesWithAll(context),
            selectedBgColor: ColorsManager.whiteBlue,
            selectedFgColor: ColorsManager.blue,
            unSelectedBgColor: Colors.transparent,
            unSelectedFgColor: ColorsManager.white,)
        ],
      ),
    ),
    Expanded(child: ListView.separated(

    padding: REdgeInsets.symmetric(vertical: 16),
    separatorBuilder: (context, index)=> SizedBox(height: 16.h,),
    itemBuilder: (context, index)=>EventItem(event: EventModel(category: CategoryModel.getCategories(context)[3], title: "Meeting for Updating The Development Method ", description: "Meeting for Updating The Development Method ", dateTime: DateTime.now(), timeOfDay: TimeOfDay.now(),)), itemCount: 20,))
    ],
    );
  }
}

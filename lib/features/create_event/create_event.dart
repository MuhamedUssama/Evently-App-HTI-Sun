import 'package:evently_hti_sun/core/extensions/date_time_ex.dart';
import 'package:evently_hti_sun/core/resources/assets_manager.dart';
import 'package:evently_hti_sun/core/resources/colors_manager.dart';
import 'package:evently_hti_sun/core/widgets/custom_elevated_button.dart';
import 'package:evently_hti_sun/core/widgets/custom_tab_bar.dart';
import 'package:evently_hti_sun/core/widgets/custom_text_button.dart';
import 'package:evently_hti_sun/core/widgets/custom_text_form_field.dart';
import 'package:evently_hti_sun/l10n/app_localizations.dart';
import 'package:evently_hti_sun/models/category_model.dart';
import 'package:evently_hti_sun/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {

 late TextEditingController titleController;
 late TextEditingController descriptionController;
 var formKey = GlobalKey<FormState>();
 DateTime selectedDate = DateTime.now();
 TimeOfDay selectedTime = TimeOfDay.now();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
   AppLocalizations appLocalizations = AppLocalizations.of(context)!;
   ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.create_event)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(ImageAssets.meeting),
                ),
                SizedBox(height: 16.h),
                CustomTabBar(
                  categories: CategoryModel.getCategories(context),
                  selectedBgColor: ColorsManager.blue,
                  selectedFgColor: ColorsManager.white,
                  unSelectedBgColor: Colors.transparent,
                  unSelectedFgColor: ColorsManager.blue,
                ),
                SizedBox(height: 16.h),
                Text(
                  appLocalizations.title, style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: 8.h,),
                CustomTextFormField(hintText: appLocalizations.event_title,
                    prefixIcon: Icons.edit_note,
                    validator: (input){
                  if(input == null || input.trim().isEmpty){
                    return "Plz, enter event title";
                  }
                  return null;
                }, controller: titleController),
                SizedBox(height: 16.h),
                Text(appLocalizations.description, style: Theme.of(context).textTheme.titleMedium,),
                SizedBox(height: 8.h,),
                CustomTextFormField(
                    maxLines: 4,
                    hintText: appLocalizations.event_description, validator: (input){
                  if(input == null || input.trim().isEmpty){
                    return "Plz, enter event description";
                  }
                  return null;
                }, controller: descriptionController),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Icon(Icons.date_range,color: themeProvider.isDarkEnabled ? ColorsManager.ofWhite : ColorsManager.black,),
                    SizedBox(width: 4,),
                    Text(selectedDate.toFormattedDate, style: Theme.of(context).textTheme.headlineMedium,),
                  Spacer(),
                  CustomTextButton(text: appLocalizations.choose_date, onTap: _selectEventDate)
            
                  ],
                ),
                SizedBox(height: 18.h,),
                Row(
                  children: [
                    Icon(Icons.access_time,color: themeProvider.isDarkEnabled ? ColorsManager.ofWhite : ColorsManager.black, ),
                    SizedBox(width: 4,),
                    Text(selectedDate.toFormattedTime, style: Theme.of(context).textTheme.headlineMedium,),
                  Spacer(),
                  CustomTextButton(text: appLocalizations.choose_time, onTap:_selectEventTime )
            
                  ],
                ),
                SizedBox(height: 40.h,),
                CustomElevatedButton(
            
                    text: appLocalizations.add_event, onPress: _createEvent)
            
              ],
            ),
          ),
        ),
      ),
    );
  }
  


  void _createEvent() {
   if(formKey.currentState?.validate() == false)return;
   ///
  }

  void _selectEventDate()async {
  selectedDate = await  showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365))) ?? selectedDate;
  print(selectedDate.toString());
  selectedDate = selectedDate.copyWith(hour: selectedTime.hour, minute: selectedTime.minute);
  setState(() {

  });
  }

  void _selectEventTime()async {
   selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now()) ?? selectedTime;
selectedDate = selectedDate.copyWith(hour: selectedTime.hour, minute: selectedTime.minute);


   setState(() {

   });
  }
}

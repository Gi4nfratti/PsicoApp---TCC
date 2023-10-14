import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psicoapp/utils/app_routes.dart';
import 'package:psicoapp/components/tabs_widget.dart';
import 'package:psicoapp/views/action/action_page.dart';
import 'package:psicoapp/views/action/actionhistory_page.dart';
import 'package:psicoapp/views/action/actionmandatory_page.dart';
import 'package:psicoapp/views/action/actionoptional_page.dart';
import 'package:psicoapp/views/action/actionsummary_page.dart';
import 'package:psicoapp/views/login_page.dart';
import 'package:psicoapp/views/action/actionmood_page.dart';
import 'package:psicoapp/views/settings/avatar_page.dart';
import 'package:psicoapp/views/settings/mood_history_page.dart';
import 'package:psicoapp/views/settings/profile_page.dart';
import 'package:psicoapp/views/psychoeducation/psychoeducation_page.dart';
import 'package:psicoapp/views/psychoeducation/psychoeducationtext_page.dart';
import 'package:psicoapp/views/settings/register_page.dart';
import 'package:psicoapp/views/settings/scale_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PsicoApp',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xFF70c2e8),
            secondary: Color(0xFF70c2e8),
          ),
          appBarTheme: const AppBarTheme(
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Color(0xFF70c2e8)))),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.LOGIN: (context) => LoginPage(),
        AppRoutes.HOME: (context) => TabsWidget(),
        AppRoutes.PSYCHOEDUCATION: (context) => PsychoeducationPage(),
        AppRoutes.ACTIONS: (context) => ActionPage(),
        AppRoutes.PROFILE: (context) => ProfilePage(),
        AppRoutes.PSYCHOEDUCATION_TEXT: (context) => PsychoeducationTextPage(),
        AppRoutes.ACTIONS_HISTORY: (context) => ActionHistoryPage(),
        AppRoutes.ACTIONS_MANDATORY: (context) => ActionMandatoryPage(),
        AppRoutes.ACTIONS_OPTIONAL: (context) => ActionOptionalPage(),
        AppRoutes.ACTIONS_SUMMARY: (context) => ActionSummaryPage(),
        AppRoutes.REGISTER: (context) => RegisterPage(),
        AppRoutes.AVATAR: (context) => AvatarPage(),
        AppRoutes.SCALE: (context) => ScalePage(),
        AppRoutes.MOOD: (context) => ActionMoodPage(),
        AppRoutes.MOOD_HISTORY: (context) => MoodHistoryPage(),
      },
    );
  }
}

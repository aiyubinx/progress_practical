import 'package:flutter/material.dart';
import 'package:progress_practical/pages/congrats_page.dart';
import 'package:progress_practical/pages/enter_number_page.dart';
import 'package:progress_practical/pages/question_one_page.dart';
import 'package:progress_practical/pages/question_three_page.dart';
import 'package:progress_practical/pages/question_two_page.dart';
import 'package:progress_practical/pages/welcome_page.dart';
import 'package:progress_practical/providers/question_one_provider.dart';
import 'package:progress_practical/utils/strings.dart';
import 'package:progress_practical/utils/themes.dart';
import 'package:provider/provider.dart';

import 'providers/question_three_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionOneProvider()),
        ChangeNotifierProvider(create: (_) => QuestionThreeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: RouteConstants.welcomePage,
      routes: {
        RouteConstants.welcomePage: (context) => WelcomePage(key: welcomePageKey),
        RouteConstants.questionOnePage: (context) => QuestionOnePage(),
        RouteConstants.questionTwoPage: (context) => const QuestionTwoPage(),
        RouteConstants.enterNumberPage: (context) => const EnterNumberPage(),
        RouteConstants.questionThreePage: (context) => QuestionThreePage(),
        RouteConstants.congratsPage: (context) => CongratulationsPage(),
      },
    );
  }
}
